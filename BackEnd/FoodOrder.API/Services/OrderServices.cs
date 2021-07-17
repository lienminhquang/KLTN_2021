﻿using AutoMapper;
using FoodOrder.Core.Helpers;
using FoodOrder.Core.Inferstructer;
using FoodOrder.Core.Models;
using FoodOrder.Core.ViewModels;
using FoodOrder.Core.ViewModels.Foods;
using FoodOrder.Core.ViewModels.OrderDetails;
using FoodOrder.Core.ViewModels.Orders;
using FoodOrder.Core.ViewModels.OrderStatuses;
using FoodOrder.Core.ViewModels.Ratings;
using FoodOrder.Core.ViewModels.Users;
using FoodOrder.Data;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.Logging;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace FoodOrder.API.Services
{
    public class OrderServices
    {
        private readonly IConfiguration _config;
        private readonly ApplicationDBContext _dbContext;
        private readonly IMapper _mapper;
        private readonly ILogger<OrderServices> _logger;
        public FoodServices _foodServices { get; set; }

        private FirebaseServices _firebaseServices;

        public OrderServices(ApplicationDBContext applicationDBContext, IMapper mapper, ILogger<OrderServices> logger, FoodServices foodServices, IConfiguration configuration, FirebaseServices firebaseServices)
        {
            _config = configuration;
            _dbContext = applicationDBContext;
            _mapper = mapper;
            _logger = logger;
            _foodServices = foodServices;
            _firebaseServices = firebaseServices;
        }

        public async Task<ApiResult<PaginatedList<OrderVM>>> GetAllPaging(PagingRequestBase request)
        {



            var orders = (from c in _dbContext.Orders where c.IsDeleted == false select c)
                .Include(a => a.OrderStatus)
                .Include(a => a.AppUser);

            var sorted = Core.Helpers.Utilities<Order>.Sort(orders, request.SortOrder, "ID");

            var created = await PaginatedList<OrderVM>.CreateAsync(sorted.Select(c => _mapper.Map<Order, OrderVM>(c)), request.PageNumber ?? 1, request.PageSize ?? Core.Helpers.Configs.DefaultPageSize);
            //for(int i = 0; i < created.Items.Count; i++)
            //{
            //    created.Items[i].OrderStatusVM = sorted
            //}
            return new SuccessedResult<PaginatedList<OrderVM>>(created);
        }

        public ApiResult<OrderVM> GetByID(int id)
        {
            var c = _dbContext.Orders.Find(id);

            if (c == null || c.IsDeleted)
            {
                return new FailedResult<OrderVM>("Order not found!");
            }
            c.OrderStatus = _dbContext.OrderStatuses.Find(c.OrderStatusID);


            var orderDetails = (from od in _dbContext.OrderDetails
                                where od.OrderID == id
                                select od).Include(a => a.Food).ToList();
            var orderDetailVMs = orderDetails.Select(od => new OrderDetailVM()
            {
                SaleCampaignID = od.SaleCampaignID,
                SalePercent = od.SalePercent,
                Amount = od.Amount,
                FoodID = od.FoodID,
                OrderID = od.OrderID,
                Price = od.Price,
                FoodVM = _mapper.Map<FoodVM>(od.Food),
            }).ToList();

            var userVM = _mapper.Map<UserVM>(_dbContext.AppUsers.Find(c.AppUserID));

            foreach (var item in orderDetailVMs)
            {
                var rating = _dbContext.Ratings.Find(id, item.FoodID);

                if (rating != null)
                {
                    item.RatingVM = _mapper.Map<RatingVM>(rating);
                    item.RatingVM.UserFullName = userVM.Name + " " + userVM.Name;
                }
            }


            var orderVM = _mapper.Map<Order, OrderVM>(c);


            orderVM.OrderStatusVM = _mapper.Map<OrderStatusVM>(c.OrderStatus);
            orderVM.OrderDetailVMs = orderDetailVMs;
            orderVM.UserVM = userVM;

            return new SuccessedResult<OrderVM>(orderVM);
        }

        public ApiResult<List<OrderVM>> GetByUserID(string userID)
        {
            var orders = (from o in _dbContext.Orders
                          where o.AppUserID.ToString() == userID && o.IsDeleted == false
                          select o)
                    .Include(a => a.OrderDetails)
                    .Include(a => a.OrderStatus)
                    .ToList();


            var orderVMs = orders.Select(c => _mapper.Map<Order, OrderVM>(c)).ToList();
            for (int i = 0; i < orderVMs.Count(); i++)
            {
                orderVMs[i].OrderStatusVM = _mapper.Map<OrderStatusVM>(orders[i].OrderStatus);
                orderVMs[i].OrderDetailVMs = orders[i].OrderDetails.Select(f => _mapper.Map<OrderDetailVM>(f)).ToList();
                foreach (var detail in orderVMs[i].OrderDetailVMs)
                {
                    //detail.OrderVM = _mapper.Map<OrderVM>(_dbContext.Orders.Find(detail.OrderID));
                    detail.FoodVM = _mapper.Map<FoodVM>(_dbContext.Foods.Find(detail.FoodID));
                }
            }

            orderVMs.Sort(new Comparison<OrderVM>((a, b) =>
            {
                if (a.CreatedDate == b.CreatedDate)
                {
                    return 0;
                }
                if (a.CreatedDate > b.CreatedDate)
                {
                    return -1;
                }
                return 1;
            }));

            return new SuccessedResult<List<OrderVM>>(orderVMs);

        }

        public ApiResult<List<OrderVM>> GetProcessingByUserID(string userID)
        {
            var orders = (from o in _dbContext.Orders
                          where o.AppUserID.ToString() == userID
                          && o.IsDeleted == false
                          select o)
                    //.Include(a => a.OrderDetails)
                    //.Include(a => a.OrderStatus)
                    .ToList();


            var orderVMs = orders.Where(c => c.OrderStatusID != OrderStatus.DaHuy && c.OrderStatusID != OrderStatus.DaNhan)
                .Select(c => _mapper.Map<Order, OrderVM>(c)).ToList();
            for (int i = 0; i < orderVMs.Count(); i++)
            {
                orderVMs[i].OrderStatusVM = _mapper.Map<OrderStatusVM>(_dbContext.OrderStatuses.Find(orderVMs[i].OrderStatusID));
                orderVMs[i].OrderDetailVMs = _dbContext.OrderDetails.Where(x => x.OrderID == orderVMs[i].ID)
                    .Select(f => _mapper.Map<OrderDetailVM>(f)).ToList();
                foreach (var detail in orderVMs[i].OrderDetailVMs)
                {
                    //detail.OrderVM = _mapper.Map<OrderVM>(_dbContext.Orders.Find(detail.OrderID));
                    detail.FoodVM = _mapper.Map<FoodVM>(_dbContext.Foods.Find(detail.FoodID));
                }
            }

            orderVMs.Sort(new Comparison<OrderVM>((a, b) =>
            {
                if (a.CreatedDate == b.CreatedDate)
                {
                    return 0;
                }
                if (a.CreatedDate > b.CreatedDate)
                {
                    return -1;
                }
                return 1;
            }));

            return new SuccessedResult<List<OrderVM>>(orderVMs);

        }


        public async Task<ApiResult<OrderVM>> Create(OrderCreateVM vm)
        {
            var user = _dbContext.AppUsers.Find(vm.AppUserID);
            if (user == null || user.IsDeleted)
            {
                return new FailedResult<OrderVM>("User not found!");
            }

            var numProcessingOrder = (from o in _dbContext.Orders
                                      where (o.OrderStatusID == OrderStatus.DangGiao
                                      || o.OrderStatusID == OrderStatus.DangChuanBi)
                                      && o.AppUserID.Equals(vm.AppUserID)
                                      select o).Count();
            if (numProcessingOrder >= _config.GetValue<int>("MaxProcessingOrderPerUser"))
            {
                return new FailedResult<OrderVM>("Bạn đang có quá nhiều đơn hàng đang xử lý.\nVui lòng thử lại sau!");
            }

            using var transaction = _dbContext.Database.BeginTransaction();
            try
            {
                var order = _mapper.Map<OrderCreateVM, Order>(vm);
                order.CreatedDate = DateTime.Now;
                var createOrderResult = await _dbContext.Orders.AddAsync(order);

                if (createOrderResult.State != EntityState.Added)
                {
                    return new FailedResult<OrderVM>("Failed to create order");
                }
                _dbContext.SaveChanges();
                //order.AppUser.Orders = null;
                //_logger.LogInformation("Created Order: " + JsonConvert.SerializeObject(createOrderResult.Entity).ToString());

                var carts = (from c in _dbContext.Carts
                             where c.AppUserId == vm.AppUserID
                             select c)
                             .Include(a => a.Food);
                if (carts.Count() == 0)
                {
                    return new FailedResult<OrderVM>("Failed to create order. No food in cart!");
                }
                double totalPrice = 0;
                foreach (var cart in carts.ToList())
                {
                    var foodResult = await _foodServices.GetByID(cart.FoodID);
                    if (foodResult.IsSuccessed == false)
                    {
                        return new FailedResult<OrderVM>("Food not found!");
                    }
                    FoodVM foodVM = foodResult.PayLoad;
                    OrderDetail orderDetail = new OrderDetail
                    {
                        FoodID = cart.FoodID,
                        Amount = cart.Quantity,
                        OrderID = order.ID,
                        Price = foodVM.Price,
                        SaleCampaignID = foodVM.SaleCampaignVM == null ? null : foodVM.SaleCampaignVM.ID,
                        SalePercent = foodVM.SaleCampaignVM == null ? null : foodVM.SaleCampaignVM.Percent,
                    };
                    _dbContext.OrderDetails.Add(orderDetail);
                    _dbContext.Carts.Remove(cart);

                    if (orderDetail.SaleCampaignID != null)
                    {
                        var sc = _dbContext.SaleCampaigns.Find(orderDetail.SaleCampaignID);
                        if (sc == null || sc.IsDeleted)
                        {
                            return new FailedResult<OrderVM>("Sale Campaign not found!");
                        }

                        totalPrice += orderDetail.Price
                            * orderDetail.Amount
                            * (100 - orderDetail.SalePercent.Value) / 100;
                    }
                    else
                    {
                        totalPrice += orderDetail.Price * orderDetail.Amount;
                    }

                }

                _logger.LogInformation("Create order: TotalPrice: " + totalPrice);
                if (vm.PromotionID != null)
                {
                    var promotion = _dbContext.Promotions.Find(vm.PromotionID);
                    if (promotion == null || promotion.IsDeleted)
                    {
                        return new FailedResult<OrderVM>("Promotion not found!");
                    }

                    var timeUsed = (from o in _dbContext.Orders
                                    where o.AppUserID.Equals(order.AppUserID) && o.PromotionID == promotion.ID
                                    select o).Count() - 1;

                    if (promotion.StartDate <= DateTime.Now
                        && promotion.EndDate >= DateTime.Now
                        && promotion.Enabled == true
                        && promotion.MinPrice <= totalPrice
                        && timeUsed < promotion.UseTimes)
                    {
                        double promotedAmount = Math.Min((double)promotion.Max, totalPrice * promotion.Percent / 100);
                        _logger.LogInformation("Create order: promotedAmount: " + promotedAmount);
                        order.PromotionID = vm.PromotionID;
                        order.PromotionAmount = promotedAmount;
                    }
                    else
                    {
                        return new FailedResult<OrderVM>("Mã giảm giá không hợp lệ hoặc đã hết hạn!");
                    }
                }
                double finalPrice = (order.PromotionAmount != null ? totalPrice - order.PromotionAmount.Value : totalPrice);
                order.FinalTotalPrice = finalPrice;
                _logger.LogInformation("Create order: finalPrice: " + finalPrice);
                await _dbContext.SaveChangesAsync();

                transaction.Commit();

                var orderVM = _mapper.Map<OrderVM>(createOrderResult.Entity);
                orderVM.OrderStatusVM = _mapper.Map<OrderStatusVM>(_dbContext.OrderStatuses.Find(orderVM.OrderStatusID));
                orderVM.OrderDetailVMs = await (from od in _dbContext.OrderDetails
                                                where od.OrderID == createOrderResult.Entity.ID
                                                select _mapper.Map<OrderDetailVM>(od))
                                          .ToListAsync();
                return new SuccessedResult<OrderVM>(orderVM);
            }
            catch (Exception e)
            {
                _logger.LogError(e.ToString());
                return new FailedResult<OrderVM>("Some thing went wrong!");
            }

        }

        public async Task<ApiResult<OrderVM>> Edit(int id, OrderEditVM editVM)
        {
            var vm = await _dbContext.Orders.FirstOrDefaultAsync(c => c.ID == id);
            if (vm == null || vm.IsDeleted)
            {
                return new FailedResult<OrderVM>("Order not found!");
            }
            vm.IsPaid = editVM.IsPaid;
            vm.OrderStatusID = editVM.OrderStatusID;
            vm.DatePaid = editVM.DatePaid;
            vm.PromotionID = editVM.PromotionID;
            vm.AddressString = editVM.AddressString;
            vm.AddressName = editVM.AddressName;

            try
            {
                await _dbContext.SaveChangesAsync();
            }
            catch (Exception e)
            {
                _logger.LogError(e.Message);
                return new FailedResult<OrderVM>("Some thing went wrong!");
            }

            return new SuccessedResult<OrderVM>(_mapper.Map<OrderVM>(vm));
        }

        public async Task<ApiResult<OrderVM>> ChangOrderStatus(ChangeOrderStatusVM changeVM)
        {
            string pnTitle = "";
            string pnBody = "";
            string userDeviceToken = "";

            var vm = await _dbContext.Orders.FirstOrDefaultAsync(c => c.ID == changeVM.ID);
            if (vm == null || vm.IsDeleted)
            {
                return new FailedResult<OrderVM>("Order not found!");
            }

            var orderStatus = await _dbContext.OrderStatuses.FirstOrDefaultAsync(c => c.ID == changeVM.OrderStatusID);
            if (orderStatus == null)
            {
                return new FailedResult<OrderVM>("OrderStatus not found!");
            }

            var user = _dbContext.AppUsers.Find(vm.AppUserID);
            userDeviceToken = user.DeviceToken;

            vm.OrderStatusID = changeVM.OrderStatusID;
            if (vm.OrderStatusID == OrderStatus.DaNhan)
            {// da nhan hang
                vm.IsPaid = true;
                vm.DatePaid = DateTime.Now;
            }

            if (vm.OrderStatusID == OrderStatus.DaHuy)
            {
                vm.IsPaid = false;
                vm.DatePaid = DateTime.Now;
            }

            pnTitle = orderStatus.PNTitle;
            pnBody = orderStatus.PNBody;

            try
            {
                await _dbContext.SaveChangesAsync();
                if (!string.IsNullOrEmpty(userDeviceToken))
                {
                    await _firebaseServices.SendPNAsync(userDeviceToken, pnTitle, pnBody);
                }
            }
            catch (Exception e)
            {
                _logger.LogError(e.Message);
                return new FailedResult<OrderVM>("Some thing went wrong!");
            }

            return new SuccessedResult<OrderVM>(_mapper.Map<OrderVM>(vm));
        }

        public async Task<ApiResult<bool>> Delete(int id)
        {
            var order = await _dbContext.Orders.FirstOrDefaultAsync(c => c.ID == id);
            if (order == null || order.IsDeleted)
            {
                return new FailedResult<bool>("Order not found!");
            }
            try
            {
                order.IsDeleted = true;
                order.TimeDeleted = DateTime.Now;
                await _dbContext.SaveChangesAsync();
            }
            catch (Exception e)
            {
                _logger.LogError(e.Message);
                return new FailedResult<bool>("Some thing went wrong!");
            }
            return new SuccessedResult<bool>(true);
        }
        public async Task<ApiResult<bool>> DeletePermanently(int id)
        {
            var order = await _dbContext.Orders.FirstOrDefaultAsync(c => c.ID == id);
            if (order == null)
            {
                return new FailedResult<bool>("Order not found!");
            }
            try
            {
                _dbContext.Orders.Remove(order);
                await _dbContext.SaveChangesAsync();
            }
            catch (Exception e)
            {
                _logger.LogError(e.Message);
                return new FailedResult<bool>("Some thing went wrong!");
            }
            return new SuccessedResult<bool>(true);
        }
    }
}

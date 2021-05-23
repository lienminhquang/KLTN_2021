using AutoMapper;
using FoodOrder.Core.Helpers;
using FoodOrder.Core.Inferstructer;
using FoodOrder.Core.Models;
using FoodOrder.Core.ViewModels;
using FoodOrder.Core.ViewModels.Foods;
using FoodOrder.Core.ViewModels.OrderDetails;
using FoodOrder.Core.ViewModels.Orders;
using FoodOrder.Core.ViewModels.OrderStatuses;
using FoodOrder.Core.ViewModels.Users;
using FoodOrder.Data;
using Microsoft.EntityFrameworkCore;
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
        private readonly ApplicationDBContext _dbContext;
        private readonly IMapper _mapper;
        private readonly ILogger<OrderServices> _logger;

        public OrderServices(ApplicationDBContext applicationDBContext, IMapper mapper, ILogger<OrderServices> logger)
        {
            _dbContext = applicationDBContext;
            _mapper = mapper;
            _logger = logger;
        }

        public async Task<ApiResult<PaginatedList<OrderVM>>> GetAllPaging(PagingRequestBase request)
        {
            var orders = (from c in _dbContext.Orders select c)
                .Include(a => a.OrderStatus)
                .Include(a => a.AppUser);

            var sorted = Core.Helpers.Utilities<Order>.Sort(orders, request.SortOrder, "ID");

            var created = await PaginatedList<OrderVM>.CreateAsync(sorted.Select(c => _mapper.Map<Order, OrderVM>(c)), request.PageNumber ?? 1, Core.Helpers.Configs.PageSize);
            //for(int i = 0; i < created.Items.Count; i++)
            //{
            //    created.Items[i].OrderStatusVM = sorted
            //}
            return new SuccessedResult<PaginatedList<OrderVM>>(created);
        }

        public async Task<ApiResult<OrderVM>> GetByID(int id)
        {
            var c = _dbContext.Orders.Find(id);

            if (c == null)
            {
                return new FailedResult<OrderVM>("Order not found!");
            }
            c.OrderStatus = _dbContext.OrderStatuses.Find(c.OrderStatusID);
            

            var orderDetails = (from od in _dbContext.OrderDetails
                               where od.OrderID == id
                               select od).Include(a => a.Food);
            var orderDetailVMs = orderDetails.Select(od => new OrderDetailVM()
            {
                Amount = od.Amount,
                FoodID = od.FoodID,
                OrderID = od.OrderID,
                Price = od.Price,
                FoodVM = _mapper.Map<FoodVM>(od.Food)
            });

            var userVM = _mapper.Map<UserVM>(_dbContext.AppUsers.Find(c.AppUserID));
            var orderVM = _mapper.Map<Order, OrderVM>(c);


            orderVM.OrderStatusVM = _mapper.Map<OrderStatusVM>(c.OrderStatus);
            orderVM.OrderDetailVMs = orderDetailVMs.ToList();
            orderVM.UserVM = userVM;

            return new SuccessedResult<OrderVM>(orderVM);
        }

        public async Task<ApiResult<List<OrderVM>>> GetByUserID(string userID)
        {
            var orders = (from o in _dbContext.Orders
                    where o.AppUserID.ToString() == userID
                    select o)
                    .Include(a => a.OrderDetails)
                    .Include(a => a.OrderStatus)
                    .ToList();
            
          
            var orderVMs = orders.Select(c => _mapper.Map<Order, OrderVM>(c)).ToList();
            for(int i = 0; i < orderVMs.Count(); i++)
            {
                orderVMs[i].OrderStatusVM = _mapper.Map<OrderStatusVM>(orders[i].OrderStatus);
                orderVMs[i].OrderDetailVMs = orders[i].OrderDetails.Select(f => _mapper.Map<OrderDetailVM>(f)).ToList();
                foreach (var detail in orderVMs[i].OrderDetailVMs)
                {
                    //detail.OrderVM = _mapper.Map<OrderVM>(_dbContext.Orders.Find(detail.OrderID));
                    detail.FoodVM = _mapper.Map<FoodVM>(_dbContext.Foods.Find(detail.FoodID));
                }
            }

            return new SuccessedResult<List<OrderVM>>(orderVMs);
            
        }


        public async Task<ApiResult<OrderVM>> Create(OrderCreateVM vm)
        {
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
                _logger.LogInformation("Created Order: " + JsonConvert.SerializeObject(createOrderResult.Entity).ToString());

                var carts = (from c in _dbContext.Carts
                             where c.AppUserId == vm.AppUserID 
                             select c)
                             .Include(a => a.Food);
                if(carts.Count() == 0)
                {
                    return new FailedResult<OrderVM>("Failed to create order. No food in cart!");
                }
                foreach (var cart in carts.ToList())
                {
                    OrderDetailCreateVM orderDetailCreateVM = new OrderDetailCreateVM()
                    {
                        OrderID = createOrderResult.Entity.ID,
                        Amount = cart.Quantity,
                        FoodID = cart.FoodID,
                        Price = cart.Food.Price
                    };
                    _dbContext.OrderDetails.Add(_mapper.Map<OrderDetail>(orderDetailCreateVM));
                    _dbContext.Carts.Remove(cart);
                }

                await _dbContext.SaveChangesAsync();

                transaction.Commit();

                var orderVM = _mapper.Map<OrderVM>(createOrderResult.Entity);
                orderVM.OrderDetailVMs = await (from od in _dbContext.OrderDetails 
                                          where od.OrderID == createOrderResult.Entity.ID 
                                          select _mapper.Map<OrderDetailVM>(od))
                                          .ToListAsync();
                return new SuccessedResult<OrderVM>(orderVM);
            }
            catch (Exception e)
            {
                _logger.LogError(e.ToString());
                return new FailedResult<OrderVM>(e.ToString());
            }
            
        }

        public async Task<ApiResult<OrderVM>> Edit(int id, OrderEditVM editVM)
        {
            var vm = await _dbContext.Orders.FirstOrDefaultAsync(c => c.ID == id);
            if (vm == null)
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
                return new FailedResult<OrderVM>(e.InnerException.ToString());
            }

            return new SuccessedResult<OrderVM>(_mapper.Map<OrderVM>(vm));
        }

        public async Task<ApiResult<OrderVM>> ChangOrderStatus(ChangeOrderStatusVM changeVM)
        {
            var vm = await _dbContext.Orders.FirstOrDefaultAsync(c => c.ID == changeVM.ID);
            if (vm == null)
            {
                return new FailedResult<OrderVM>("Order not found!");
            }

            var orderStatus = await _dbContext.OrderStatuses.FirstOrDefaultAsync(c => c.ID == changeVM.OrderStatusID);
            if (orderStatus == null)
            {
                return new FailedResult<OrderVM>("OrderStatus not found!");
            }

            vm.OrderStatusID = changeVM.OrderStatusID;
            if (vm.OrderStatusID == 4)
            {// da nhan hang
                vm.IsPaid = true;
                vm.DatePaid = DateTime.Now;
            }

            try
            {
                await _dbContext.SaveChangesAsync();
            }
            catch (Exception e)
            {
                return new FailedResult<OrderVM>(e.InnerException.ToString());
            }

            return new SuccessedResult<OrderVM>(_mapper.Map<OrderVM>(vm));
        }

        public async Task<ApiResult<bool>> Delete(int id)
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
                return new FailedResult<bool>(e.InnerException.ToString());
            }
            return new SuccessedResult<bool>(true);
        }
    }
}

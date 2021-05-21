using AutoMapper;
using FoodOrder.Core.Helpers;
using FoodOrder.Core.Inferstructer;
using FoodOrder.Core.Models;
using FoodOrder.Core.ViewModels;
using FoodOrder.Core.ViewModels.Foods;
using FoodOrder.Core.ViewModels.OrderDetails;
using FoodOrder.Core.ViewModels.Orders;
using FoodOrder.Core.ViewModels.OrderStatuses;
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
            var orders = from c in _dbContext.Orders select c;

            // Todo: search cart?
            //if (!String.IsNullOrEmpty(request.SearchString))
            //{
            //    carts = carts.Where(c => c.Username.Contains(request.SearchString)
            //    || c.FirstName.Contains(request.SearchString)
            //    || c.LastName.Contains(request.SearchString)
            //    || c.Email.Contains(request.SearchString));
            //}

            orders = Core.Helpers.Utilities<Order>.Sort(orders, request.SortOrder, "ID");

            var created = await PaginatedList<OrderVM>.CreateAsync(orders.Select(c => _mapper.Map<Order, OrderVM>(c)), request.PageNumber ?? 1, Core.Helpers.Configs.PageSize);

            return new SuccessedResult<PaginatedList<OrderVM>>(created);
        }

        public async Task<ApiResult<OrderVM>> GetByID(int id)
        {
            var c = await _dbContext.Orders.FirstOrDefaultAsync(c => c.ID == id);
            if (c == null)
            {
                return new FailedResult<OrderVM>("Order not found!");
            }

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
            var orderVM = _mapper.Map<Order, OrderVM>(c);
            orderVM.OrderDetailVMs = orderDetailVMs.ToList();

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
            //var created = await PaginatedList<OrderVM>.CreateAsync(orderVMs.Select(a => a),
            //    1, 
            //    Core.Helpers.Configs.PageSize);

            //var orders = c.ToList();
            //var orderVMs = new List<OrderVM>();

            //foreach (var item in orders)
            //{
            //    var orderDetails = (from od in _dbContext.OrderDetails
            //                        where od.OrderID == item.ID
            //                        select od).Include(a => a.Food);
            //    var orderDetailVMs = orderDetails.Select(od => new OrderDetailVM()
            //    {
            //        Amount = od.Amount,
            //        FoodID = od.FoodID,
            //        OrderID = od.OrderID,
            //        Price = od.Price,
            //        FoodVM = _mapper.Map<FoodVM>(od.Food)
            //    });
            //    var orderVM = _mapper.Map<Order, OrderVM>(item);
            //    orderVM.OrderDetailVMs = orderDetailVMs.ToList();
            //    orderVMs.Add(orderVM);
            //}

            //PaginatedList<OrderVM> list = new PaginatedList<OrderVM>();
            //list.Items = orderVMs;
            //list.PageIndex = 1;
            //list.TotalPage = 1;
            //list.HasNextPage = false;
            //list.

            //return new SuccessedResult<PaginatedList<OrderVM>>(created);
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

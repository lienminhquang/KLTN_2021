using AutoMapper;
using FoodOrder.Core.Helpers;
using FoodOrder.Core.Inferstructer;
using FoodOrder.Core.Models;
using FoodOrder.Core.ViewModels;
using FoodOrder.Core.ViewModels.Orders;
using FoodOrder.Data;
using Microsoft.EntityFrameworkCore;
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

        public OrderServices(ApplicationDBContext applicationDBContext, IMapper mapper)
        {
            _dbContext = applicationDBContext;
            _mapper = mapper;
        }

        public async Task<ApiResult<PaginatedList<OrderVM>>> GetAllPaging(PagingRequestBase request)
        {
            var orders = from c in _dbContext.Orders select _mapper.Map<Order, OrderVM>(c);

            // Todo: search cart?
            //if (!String.IsNullOrEmpty(request.SearchString))
            //{
            //    carts = carts.Where(c => c.Username.Contains(request.SearchString)
            //    || c.FirstName.Contains(request.SearchString)
            //    || c.LastName.Contains(request.SearchString)
            //    || c.Email.Contains(request.SearchString));
            //}

            orders = Core.Helpers.Utilities<OrderVM>.Sort(orders, request.SortOrder, "ID");

            var created = await PaginatedList<OrderVM>.CreateAsync(orders, request.PageNumber ?? 1, Core.Helpers.Configs.PageSize);

            return new SuccessedResult<PaginatedList<OrderVM>>(created);
        }

        public async Task<ApiResult<OrderVM>> GetByID(int id)
        {
            var c = await _dbContext.Orders.FirstOrDefaultAsync(c => c.ID == id);
            if (c == null)
            {
                return new FailedResult<OrderVM>("Order not found!");
            }
            return new SuccessedResult<OrderVM>(_mapper.Map<Order, OrderVM>(c));
        }

        public async Task<ApiResult<OrderVM>> Create(OrderCreateVM vm)
        {
            var result = await _dbContext.Orders.AddAsync(_mapper.Map<OrderCreateVM, Order>(vm));
            try
            {
                await _dbContext.SaveChangesAsync();
            }
            catch (Exception e)
            {
                return new FailedResult<OrderVM>(e.InnerException.ToString());
            }
            return new SuccessedResult<OrderVM>(_mapper.Map<OrderVM>(result.Entity));
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

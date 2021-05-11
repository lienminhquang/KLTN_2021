using AutoMapper;
using FoodOrder.Core.Helpers;
using FoodOrder.Core.Inferstructer;
using FoodOrder.Core.Models;
using FoodOrder.Core.ViewModels;
using FoodOrder.Core.ViewModels.OrderDetails;
using FoodOrder.Data;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace FoodOrder.API.Services
{
    public class OrderDetailServices
    {
        private readonly ApplicationDBContext _dbContext;
        private readonly IMapper _mapper;

        public OrderDetailServices(ApplicationDBContext applicationDBContext, IMapper mapper)
        {
            _dbContext = applicationDBContext;
            _mapper = mapper;
        }

        public async Task<ApiResult<PaginatedList<OrderDetailVM>>> GetAllPaging(PagingRequestBase request)
        {
            var odVMs = _dbContext.OrderDetails
               .Include(f => f.Food) //Todo: is this need for paging?
               .Include(f => f.Order)
               .AsNoTracking().Select(f => _mapper.Map<OrderDetail, OrderDetailVM>(f));


            //if (!String.IsNullOrEmpty(request.SearchString))
            //{
            //    odVMs = odVMs.Where(c => c.Name.Contains(request.SearchString)
            //    || c.Description.Contains(request.SearchString));
            //}

            //odVMs = Core.Helpers.Utilities<OrderDetailVM>.Sort(odVMs, request.SortOrder, "FoodID");

            var created = await PaginatedList<OrderDetailVM>.CreateAsync(odVMs, request.PageNumber ?? 1, Core.Helpers.Configs.PageSize);

            return new SuccessedResult<PaginatedList<OrderDetailVM>>(created);
        }

        public async Task<ApiResult<OrderDetailVM>> GetByID(int orderID, int foodID)
        {
            var c = await _dbContext.OrderDetails.FirstOrDefaultAsync(c => c.OrderID == orderID && c.FoodID == foodID);
            if (c == null)
            {
                return new FailedResult<OrderDetailVM>("OrderDetail not found!");
            }
            return new SuccessedResult<OrderDetailVM>(_mapper.Map<OrderDetailVM>(c));
        }

        public async Task<ApiResult<OrderDetailVM>> Create(OrderDetailCreateVM vm)
        {
            Food food = _dbContext.Foods.Find(vm.FoodID);
            if(food == null)
            {
                return new FailedResult<OrderDetailVM>("Food not found!");
            }

            Order order = _dbContext.Orders.Find(vm.OrderID);
            if(order == null)
            {
                return new FailedResult<OrderDetailVM>("Order not found!");
            }

            var result = await _dbContext.OrderDetails.AddAsync(_mapper.Map<OrderDetail>(vm));
            try
            {
                await _dbContext.SaveChangesAsync();
            }
            catch (Exception e)
            {
                return new FailedResult<OrderDetailVM>(e.InnerException.ToString());
            }
            return new SuccessedResult<OrderDetailVM>(_mapper.Map<OrderDetailVM>(result.Entity));
        }

        public async Task<ApiResult<OrderDetailVM>> Edit(int orderID, int foodID, OrderDetailEditVM editVM)
        {
            var od = await _dbContext.OrderDetails.FirstOrDefaultAsync(c => c.OrderID == orderID && c.FoodID == foodID);
            if (od == null)
            {
                return new FailedResult<OrderDetailVM>("OrderDetail not found!");
            }
            od.Amount = editVM.Amount;
            od.Price = editVM.Price;
            try
            {
                await _dbContext.SaveChangesAsync();
            }
            catch (Exception e)
            {
                return new FailedResult<OrderDetailVM>(e.InnerException.ToString());
            }

            return new SuccessedResult<OrderDetailVM>(_mapper.Map<OrderDetailVM>(od));
        }

        public async Task<ApiResult<bool>> Delete(int orderID, int foodID)
        {
            var vm = await _dbContext.OrderDetails.FirstOrDefaultAsync(c => c.OrderID == orderID && c.FoodID == foodID);
            if (vm == null)
            {
                return new FailedResult<bool>("OrderDetail not found!");
            }
            try
            {
                _dbContext.OrderDetails.Remove(vm);
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

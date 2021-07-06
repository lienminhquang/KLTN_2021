using AutoMapper;
using FoodOrder.Core.Helpers;
using FoodOrder.Core.Inferstructer;
using FoodOrder.Core.Models;
using FoodOrder.Core.ViewModels;
using FoodOrder.Core.ViewModels.OrderDetails;
using FoodOrder.Data;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;
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
        private readonly ILogger<OrderDetailServices> _logger;

        public OrderDetailServices(ApplicationDBContext applicationDBContext, IMapper mapper, ILogger<OrderDetailServices> logger)
        {
            _dbContext = applicationDBContext;
            _mapper = mapper;
            _logger = logger;
        }

        public async Task<ApiResult<PaginatedList<OrderDetailVM>>> GetAllPaging(PagingRequestBase request)
        {
            var odVMs = _dbContext.OrderDetails
               .Include(f => f.Food) //Todo: is this need for paging?
               .Include(f => f.Order)
               .AsNoTracking();


            //if (!String.IsNullOrEmpty(request.SearchString))
            //{
            //    odVMs = odVMs.Where(c => c.Name.Contains(request.SearchString)
            //    || c.Description.Contains(request.SearchString));
            //}

            odVMs = Core.Helpers.Utilities<OrderDetail>.Sort(odVMs, request.SortOrder, "FoodID");

            var created = await PaginatedList<OrderDetailVM>.CreateAsync(odVMs.Select(f => _mapper.Map<OrderDetail, OrderDetailVM>(f)), request.PageNumber ?? 1, request.PageSize ?? Core.Helpers.Configs.DefaultPageSize);

            return new SuccessedResult<PaginatedList<OrderDetailVM>>(created);
        }

        public async Task<ApiResult<OrderDetailVM>> GetByID(int orderID, int foodID)
        {
            var c =  _dbContext.OrderDetails.Find(orderID, foodID );
            if (c == null)
            {
                return new FailedResult<OrderDetailVM>("OrderDetail not found!");
            }
            return new SuccessedResult<OrderDetailVM>(_mapper.Map<OrderDetailVM>(c));
        }

        public async Task<ApiResult<OrderDetailVM>> Create(OrderDetailCreateVM vm)
        {
            Food food = _dbContext.Foods.Find(vm.FoodID);
            if (food == null)
            {
                return new FailedResult<OrderDetailVM>("Food not found!");
            }

            Order order = _dbContext.Orders.Find(vm.OrderID);
            if (order == null)
            {
                return new FailedResult<OrderDetailVM>("Order not found!");
            }

            try
            {
                var result = await _dbContext.OrderDetails.AddAsync(_mapper.Map<OrderDetail>(vm));
                await _dbContext.SaveChangesAsync();
                return new SuccessedResult<OrderDetailVM>(_mapper.Map<OrderDetailVM>(result.Entity));
            }
            catch (Exception e)
            {
                _logger.LogError(e.Message);
                return new FailedResult<OrderDetailVM>("Some thing went wrong!");
            }
        }

        public async Task<ApiResult<OrderDetailVM>> Edit(int orderID, int foodID, OrderDetailEditVM editVM)
        {
            var od = await _dbContext.OrderDetails.FindAsync(orderID, foodID);
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
                _logger.LogError(e.Message);
                return new FailedResult<OrderDetailVM>("Some thing went wrong!");
            }

            return new SuccessedResult<OrderDetailVM>(_mapper.Map<OrderDetailVM>(od));
        }

        public async Task<ApiResult<bool>> Delete(int orderID, int foodID)
        {
            var vm = await _dbContext.OrderDetails.FindAsync(orderID,  foodID );
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
                _logger.LogError(e.Message);
                return new FailedResult<bool>("Some thing went wrong!");
            }
            return new SuccessedResult<bool>(true);
        }
    }
}

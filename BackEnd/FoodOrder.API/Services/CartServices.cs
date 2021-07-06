using AutoMapper;
using FoodOrder.Core.Helpers;
using FoodOrder.Core.Inferstructer;
using FoodOrder.Core.Models;
using FoodOrder.Core.ViewModels;
using FoodOrder.Core.ViewModels.Carts;
using FoodOrder.Core.ViewModels.Foods;
using FoodOrder.Core.ViewModels.SaleCampaigns;
using FoodOrder.Data;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace FoodOrder.API.Services
{
    public class CartServices
    {
        private readonly ApplicationDBContext _dbContext;
        private readonly IMapper _mapper;
        private readonly ILogger<CartServices> _logger;

        public CartServices(ApplicationDBContext applicationDBContext, IMapper mapper, ILogger<CartServices> logger)
        {
            _dbContext = applicationDBContext;
            _mapper = mapper;
            _logger = logger;
        }

        public async Task<ApiResult<PaginatedList<CartVM>>> GetCartPaging(PagingRequestBase request)
        {
            var carts = from c in _dbContext.Carts
                        .Include(a => a.Food)
                        select new CartVM()
                        {
                            FoodID = c.FoodID,
                            FoodVM = _mapper.Map<FoodVM>(c.Food),
                            AppUser = c.AppUser,
                            AppUserId = c.AppUserId,
                            Quantity = c.Quantity
                        };
            
            // Todo: search cart?
            //if (!String.IsNullOrEmpty(request.SearchString))
            //{
            //    carts = carts.Where(c => c.Username.Contains(request.SearchString)
            //    || c.FirstName.Contains(request.SearchString)
            //    || c.LastName.Contains(request.SearchString)
            //    || c.Email.Contains(request.SearchString));
            //}

            carts = Core.Helpers.Utilities<CartVM>.Sort(carts, request.SortOrder, "AppUserId");

            var created = await PaginatedList<CartVM>.CreateAsync(carts, request.PageNumber ?? 1, request.PageSize ?? Core.Helpers.Configs.DefaultPageSize);

            return new SuccessedResult<PaginatedList<CartVM>>(created);
        }

        public async Task<ApiResult<PaginatedList<CartVM>>> GetByUserID(string userID, PagingRequestBase request)
        {
            var carts = from c in _dbContext.Carts where c.AppUserId.ToString() == userID
                        select new CartVM()
                        {
                            FoodVM = _mapper.Map<FoodVM>(c.Food),
                            FoodID = c.FoodID,
                            AppUserId = c.AppUserId,
                            Quantity = c.Quantity
                        };

            var created = await PaginatedList<CartVM>.CreateAsync(carts, 1, request.PageSize ?? Core.Helpers.Configs.DefaultPageSize);

            foreach (var item in created.Items)
            {
                var query = from fs in _dbContext.SaleCampaignFoods
                            join f in _dbContext.Foods on fs.FoodID equals f.ID
                            join sc in _dbContext.SaleCampaigns on fs.SaleCampaignID equals sc.ID
                            where f.ID == item.FoodID
                            select sc;
                var list = query.OrderBy(x => x.Priority).ToList();
                if (list.Count > 0)
                {
                    item.FoodVM.SaleCampaignVM = _mapper.Map<SaleCampaignVM>(list.First());
                }
            }

            return new SuccessedResult<PaginatedList<CartVM>>(created);
        }

        public async Task<ApiResult<CartVM>> GetByID(Guid userId, int foodID)
        {
            if (_dbContext.Users.Find(userId) == null)
            {
                return new FailedResult<CartVM>("User not found!");
            }
            if (_dbContext.Foods.Find(foodID) == null)
            {
                return new FailedResult<CartVM>("Food not found!");
            }

            var cart = await _dbContext.Carts.Include(c => c.AppUser).Include(c => c.Food).FirstOrDefaultAsync(c => c.AppUserId == userId && c.FoodID == foodID);
            if(cart == null)
            {
                return new FailedResult<CartVM>("Cart not found!");
            }
            return new SuccessedResult<CartVM>(new CartVM()
            {
                AppUser = cart.AppUser,
                AppUserId = cart.AppUserId,
                FoodVM = _mapper.Map<FoodVM>(cart.Food),
                FoodID = cart.FoodID,
                Quantity = cart.Quantity
            });
        }

        public async Task<ApiResult<CartVM>> Create(CartCreateVM vm)
        {
            if (_dbContext.Users.Find(vm.AppUserId) == null)
            {
                return new FailedResult<CartVM>("User not found!");
            }
            if (_dbContext.Foods.Find(vm.FoodID) == null)
            {
                return new FailedResult<CartVM>("Food not found!");
            }
            if(_dbContext.Carts.Find(vm.FoodID, vm.AppUserId) != null)
            {
                return new FailedResult<CartVM>("Cart already existed!");
            }

           
            try
            {
                var result = await _dbContext.Carts.AddAsync(new Cart
                {
                    FoodID = vm.FoodID,
                    AppUserId = vm.AppUserId,
                    Quantity = vm.Quantity
                });
                await _dbContext.SaveChangesAsync();
                return new SuccessedResult<CartVM>(new CartVM()
                {
                    AppUser = result.Entity.AppUser,
                    AppUserId = result.Entity.AppUserId,
                    FoodVM = _mapper.Map<FoodVM>(result.Entity.Food),
                    FoodID = result.Entity.FoodID,
                    Quantity = result.Entity.Quantity
                });
            }
            catch (Exception e)
            {
                _logger.LogError(e.Message);
                return new FailedResult<CartVM>("Some thing went wrong!");
            }
           
        }

        public async Task<ApiResult<CartVM>> EditOrCreate(CartCreateVM vm)
        {
            if (_dbContext.Users.Find(vm.AppUserId) == null)
            {
                return new FailedResult<CartVM>("User not found!");
            }
            if (_dbContext.Foods.Find(vm.FoodID) == null)
            {
                return new FailedResult<CartVM>("Food not found!");
            }
            if (_dbContext.Carts.Find(vm.FoodID, vm.AppUserId) != null)
            {
                _logger.LogInformation("Cart already existed! => Edit");
                return await this.Edit(vm.AppUserId, vm.FoodID, new CartEditVM() { FoodID = vm.FoodID, AppUserId = vm.AppUserId, Quantity = vm.Quantity });
            }

            _logger.LogInformation("Cart not found => create new one");
            
            try
            {
                var result = await _dbContext.Carts.AddAsync(new Cart
                {
                    FoodID = vm.FoodID,
                    AppUserId = vm.AppUserId,
                    Quantity = vm.Quantity
                });
                await _dbContext.SaveChangesAsync();
                return new SuccessedResult<CartVM>(new CartVM()
                {
                    AppUser = result.Entity.AppUser,
                    AppUserId = result.Entity.AppUserId,
                    FoodVM = _mapper.Map<FoodVM>(result.Entity.Food),
                    FoodID = result.Entity.FoodID,
                    Quantity = result.Entity.Quantity
                });
            }
            catch (Exception e)
            {
                _logger.LogError(e.Message);
                return new FailedResult<CartVM>("Some thing went wrong!");
            }
        }

        public async Task<ApiResult<CartVM>> Edit(Guid userId, int foodID, CartEditVM cartEditVM)
        {
            var cart =  _dbContext.Carts.Find(foodID, userId);
            if (cart == null)
            {
                return new FailedResult<CartVM>("Cart not found!");
            }
            cart.Quantity = cartEditVM.Quantity;
            try
            {
                await _dbContext.SaveChangesAsync();
            }
            catch (Exception e)
            {
                _logger.LogError(e.Message);
                return new FailedResult<CartVM>("Some thing went wrong!");
            }

            return new SuccessedResult<CartVM>(new CartVM()
            {
                AppUser = cart.AppUser,
                AppUserId = cart.AppUserId,
                FoodVM = _mapper.Map<FoodVM>(cart.Food),
                FoodID = cart.FoodID,
                Quantity = cart.Quantity
            });
        }

        public async Task<ApiResult<bool>> Delete(Guid userId, int foodID)
        {
            var cart = await _dbContext.Carts.FindAsync(foodID ,userId);
            if (cart == null)
            {
                return new FailedResult<bool>("Cart not found!");
            }
            try
            {
                _dbContext.Carts.Remove(cart);
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

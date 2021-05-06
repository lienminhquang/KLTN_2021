using FoodOrder.Core.Helpers;
using FoodOrder.Core.Inferstructer;
using FoodOrder.Core.Models;
using FoodOrder.Core.ViewModels;
using FoodOrder.Core.ViewModels.Carts;
using FoodOrder.Data;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace FoodOrder.API.Services
{
    public class CartServices
    {
        private readonly ApplicationDBContext _dbContext;

        public CartServices(ApplicationDBContext applicationDBContext)
        {
            _dbContext = applicationDBContext;
        }

        public async Task<ApiResult<PaginatedList<CartVM>>> GetCartPaging(PagingRequestBase request)
        {
            var carts = from c in _dbContext.Carts
                        select new CartVM()
                        {
                            FoodID = c.FoodID,
                            Food = c.Food,
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

            var created = await PaginatedList<CartVM>.CreateAsync(carts, request.PageNumber ?? 1, Core.Helpers.Configs.PageSize);

            return new SuccessedResult<PaginatedList<CartVM>>(created);
        }

        public async Task<ApiResult<CartVM>> GetByID(Guid userId, int foodID)
        {
            var cart = await _dbContext.Carts.Include(c => c.AppUser).Include(c => c.Food).FirstOrDefaultAsync(c => c.AppUserId == userId && c.FoodID == foodID);
            if(cart == null)
            {
                return new FailedResult<CartVM>("Cart not found!");
            }
            return new SuccessedResult<CartVM>(new CartVM()
            {
                AppUser = cart.AppUser,
                AppUserId = cart.AppUserId,
                Food = cart.Food,
                FoodID = cart.FoodID,
                Quantity = cart.Quantity
            });
        }

        public async Task<ApiResult<CartVM>> Create(CartCreateVM vm)
        {
            var result = await _dbContext.Carts.AddAsync(new Cart
            {
                FoodID = vm.FoodID,
                AppUserId = vm.AppUserId,
                Quantity = vm.Quantity
            });
            try
            {
                await _dbContext.SaveChangesAsync();
            }
            catch (Exception e)
            {
                return new FailedResult<CartVM>(e.InnerException.ToString());
            }
            return new SuccessedResult<CartVM>(new CartVM() 
            { 
                AppUser = result.Entity.AppUser,
                AppUserId = result.Entity.AppUserId,
                Food = result.Entity.Food,
                FoodID = result.Entity.FoodID,
                Quantity = result.Entity.Quantity
            });
        }

        public async Task<ApiResult<CartVM>> Edit(Guid userId, int foodID, CartEditVM cartEditVM)
        {
            var cart = await _dbContext.Carts.FirstOrDefaultAsync(c => c.AppUserId == userId && c.FoodID == foodID);
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
                return new FailedResult<CartVM>(e.InnerException.ToString());
            }

            return new SuccessedResult<CartVM>(new CartVM()
            {
                AppUser = cart.AppUser,
                AppUserId = cart.AppUserId,
                Food = cart.Food,
                FoodID = cart.FoodID,
                Quantity = cart.Quantity
            });
        }

        public async Task<ApiResult<bool>> Delete(Guid userId, int foodID)
        {
            var cart = await _dbContext.Carts.FirstOrDefaultAsync(c => c.AppUserId == userId && c.FoodID == foodID);
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
                return new FailedResult<bool>(e.InnerException.ToString());
            }
            return new SuccessedResult<bool>(true);
        }
    }
}

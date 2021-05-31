using AutoMapper;
using FoodOrder.Core.Helpers;
using FoodOrder.Core.Inferstructer;
using FoodOrder.Core.Models;
using FoodOrder.Core.ViewModels;
using FoodOrder.Core.ViewModels.Ratings;
using FoodOrder.Data;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace FoodOrder.API.Services
{
    public class RatingServices
    {
        private readonly ApplicationDBContext _dbContext;
        private readonly IMapper _mapper;
        private readonly ILogger<RatingServices> _logger;

        public RatingServices(ApplicationDBContext applicationDBContext, IMapper mapper, ILogger<RatingServices> logger)
        {
            _dbContext = applicationDBContext;
            _mapper = mapper;
            _logger = logger;
        }

        public async Task<ApiResult<PaginatedList<RatingVM>>> GetRatingsOfFood(int foodID, PagingRequestBase request)
        {
            var vMs = _dbContext.Ratings.Where(r => r.FoodID == foodID)
               //.Include(f => f.Food) //Todo: is this need for paging?
               //.Include(f => f.Order)
               .AsNoTracking();


            if (!String.IsNullOrEmpty(request.SearchString))
            {
                vMs = vMs.Where(c => c.Comment.Contains(request.SearchString));
            }

            vMs = Core.Helpers.Utilities<Rating>.Sort(vMs, request.SortOrder, "FoodID");

            var created = await PaginatedList<RatingVM>.CreateAsync(vMs.Select(f => _mapper.Map<Rating, RatingVM>(f)), request.PageNumber ?? 1, Core.Helpers.Configs.PageSize);
            foreach (var item in created.Items)
            {
                var user = _dbContext.Users.Find(item.AppUserID);
                item.UserFullName = user.FirstName + " " + user.LastName;
            }

            return new SuccessedResult<PaginatedList<RatingVM>>(created);
        }

        public async Task<ApiResult<PaginatedList<RatingVM>>> GetAllPaging(PagingRequestBase request)
        {
            var vMs = _dbContext.Ratings
               //.Include(f => f.Food) //Todo: is this need for paging?
               //.Include(f => f.Order)
               .AsNoTracking();


            if (!String.IsNullOrEmpty(request.SearchString))
            {
                vMs = vMs.Where(c => c.Comment.Contains(request.SearchString));
            }

            vMs = Core.Helpers.Utilities<Rating>.Sort(vMs, request.SortOrder, "FoodID");

            var created = await PaginatedList<RatingVM>.CreateAsync(vMs.Select(f => _mapper.Map<Rating, RatingVM>(f)), request.PageNumber ?? 1, Core.Helpers.Configs.PageSize);

            return new SuccessedResult<PaginatedList<RatingVM>>(created);
        }

        public async Task<ApiResult<RatingVM>> GetByID(Guid userID, int foodID)
        {
            var c = await _dbContext.Ratings.FirstOrDefaultAsync(c => c.AppUserID == userID && c.FoodID == foodID);
            if (c == null)
            {
                return new FailedResult<RatingVM>("Rating not found!");
            }
            return new SuccessedResult<RatingVM>(_mapper.Map<RatingVM>(c));
        }

        public async Task<ApiResult<RatingVM>> Create(RatingCreateVM vm)
        {
            Food food = _dbContext.Foods.Find(vm.FoodID);
            if (food == null)
            {
                return new FailedResult<RatingVM>("Food not found!");
            }

            AppUser user = _dbContext.Users.Find(vm.AppUserID);
            if (user == null)
            {
                return new FailedResult<RatingVM>("User not found!");
            }

            if(vm.Star > 5)
            {
                vm.Star = 5;
            }
            if (vm.Star < 0)
            {
                vm.Star = 0;
            }
            try
            {
            var result = await _dbContext.Ratings.AddAsync(_mapper.Map<Rating>(vm));
                await _dbContext.SaveChangesAsync();
            return new SuccessedResult<RatingVM>(_mapper.Map<RatingVM>(result.Entity));
            }
            catch (Exception e)
            {
                _logger.LogError(e.Message);
                return new FailedResult<RatingVM>("Some thing went wrong!");
            }
        }

        public async Task<ApiResult<RatingVM>> Edit(Guid userID, int foodID, RatingEditVM editVM)
        {
            var od = await _dbContext.Ratings.FirstOrDefaultAsync(c => c.AppUserID == userID && c.FoodID == foodID);
            if (od == null)
            {
                return new FailedResult<RatingVM>("Rating not found!");
            }
            od.Comment = editVM.Comment;
            od.Star = editVM.Star;
            if (od.Star > 5)
            {
                od.Star = 5;
            }
            if (od.Star < 0)
            {
                od.Star = 0;
            }
            try
            {
                await _dbContext.SaveChangesAsync();
            }
            catch (Exception e)
            {
                _logger.LogError(e.Message);
                return new FailedResult<RatingVM>("Some thing went wrong!");
            }

            return new SuccessedResult<RatingVM>(_mapper.Map<RatingVM>(od));
        }

        public async Task<ApiResult<bool>> Delete(Guid userID, int foodID)
        {
            var vm = await _dbContext.Ratings.FirstOrDefaultAsync(c => c.AppUserID == userID && c.FoodID == foodID);
            if (vm == null)
            {
                return new FailedResult<bool>("Rating not found!");
            }
            try
            {
                _dbContext.Ratings.Remove(vm);
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

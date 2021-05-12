using AutoMapper;
using FoodOrder.Core.Helpers;
using FoodOrder.Core.Inferstructer;
using FoodOrder.Core.Models;
using FoodOrder.Core.ViewModels;
using FoodOrder.Core.ViewModels.Ratings;
using FoodOrder.Data;
using Microsoft.EntityFrameworkCore;
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

        public RatingServices(ApplicationDBContext applicationDBContext, IMapper mapper)
        {
            _dbContext = applicationDBContext;
            _mapper = mapper;
        }

        public async Task<ApiResult<PaginatedList<RatingVM>>> GetAllPaging(PagingRequestBase request)
        {
            var vMs = _dbContext.Ratings
               //.Include(f => f.Food) //Todo: is this need for paging?
               //.Include(f => f.Order)
               .AsNoTracking().Select(f => _mapper.Map<Rating, RatingVM>(f));


            if (!String.IsNullOrEmpty(request.SearchString))
            {
                vMs = vMs.Where(c => c.Comment.Contains(request.SearchString));
            }

            //odVMs = Core.Helpers.Utilities<OrderDetailVM>.Sort(odVMs, request.SortOrder, "FoodID");

            var created = await PaginatedList<RatingVM>.CreateAsync(vMs, request.PageNumber ?? 1, Core.Helpers.Configs.PageSize);

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

            var result = await _dbContext.Ratings.AddAsync(_mapper.Map<Rating>(vm));
            try
            {
                await _dbContext.SaveChangesAsync();
            }
            catch (Exception e)
            {
                return new FailedResult<RatingVM>(e.InnerException.ToString());
            }
            return new SuccessedResult<RatingVM>(_mapper.Map<RatingVM>(result.Entity));
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
            
            try
            {
                await _dbContext.SaveChangesAsync();
            }
            catch (Exception e)
            {
                return new FailedResult<RatingVM>(e.InnerException.ToString());
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
                return new FailedResult<bool>(e.InnerException.ToString());
            }
            return new SuccessedResult<bool>(true);
        }
    }
}

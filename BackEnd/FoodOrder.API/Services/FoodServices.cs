using AutoMapper;
using FoodOrder.Core.Helpers;
using FoodOrder.Core.Inferstructer;
using FoodOrder.Core.Models;
using FoodOrder.Core.ViewModels;
using FoodOrder.Core.ViewModels.Categories;
using FoodOrder.Core.ViewModels.Foods;
using FoodOrder.Data;
using Microsoft.EntityFrameworkCore;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace FoodOrder.API.Services
{
    public class FoodServices
    {
        private readonly ApplicationDBContext _dbContext;
        private readonly IMapper _mapper;
        private readonly FileServices _fileServices;

        public FoodServices(ApplicationDBContext applicationDBContext, IMapper mapper, FileServices fileServices)
        {
            _dbContext = applicationDBContext;
            _mapper = mapper;
            _fileServices = fileServices;
        }

        public async Task<ApiResult<PaginatedList<FoodVM>>> GetAllPaging(PagingRequestBase request)
        {
            var food = _dbContext.Foods
               //.Include(f => f.Ratings) //Todo: is this need for paging?
               //.Include(f => f.Images)
               //.Include(f => f.FoodCategories)
               .AsNoTracking();
            


            if (!String.IsNullOrEmpty(request.SearchString))
            {
                food = food.Where(c => c.Name.Contains(request.SearchString)
                || c.Description.Contains(request.SearchString));
            }

            if (!String.IsNullOrEmpty(request.SortOrder))
            {
                food = Core.Helpers.Utilities<Food>.Sort(food, request.SortOrder, "Name");
            }

            var created = await PaginatedList<FoodVM>.CreateAsync(food.Select(f => _mapper.Map<Food, FoodVM>(f)), request.PageNumber ?? 1, Core.Helpers.Configs.PageSize);

            return new SuccessedResult<PaginatedList<FoodVM>>(created);
        }

        public async Task<ApiResult<bool>> AddFoodToCategories(List<string> categoryIDs, int foodID)
        {
            var food = _dbContext.Foods.Find(foodID);
            if(food == null)
            {
                return new FailedResult<bool>("Food not found!");
            }
            foreach (var cID in categoryIDs)
            {
                int id = 0;
                if(int.TryParse(cID, out id) == false)
                {
                    return new FailedResult<bool>("Category not found!");
                }
                _dbContext.FoodCategories.Add(new FoodCategory() { FoodID = foodID, CategoryID = id });
            }
            await _dbContext.SaveChangesAsync();

            return new SuccessedResult<bool>(true);
        }
        
        public async Task<ApiResult<bool>> DeleteFoodFromAllCategory(int foodID)
        {
            var food = _dbContext.Foods.Find(foodID);
            if (food == null)
            {
                return new FailedResult<bool>("Food not found!");
            }

            var listFC = await (from fc in _dbContext.FoodCategories
                     where fc.FoodID == foodID
                     select fc).ToListAsync();
            _dbContext.FoodCategories.RemoveRange(listFC);

            try
            {
                await _dbContext.SaveChangesAsync();
            }
            catch (Exception e)
            {
                return new FailedResult<bool>(e.Message);
            }


            return new SuccessedResult<bool>(true);
        }
        public async Task<ApiResult<FoodVM>> GetByID(int id)
        {
            var food = await _dbContext.Foods.FirstOrDefaultAsync(c => c.ID == id);
            if (food == null)
            {
                return new FailedResult<FoodVM>("Food not found!");
            }

            var foodVM = _mapper.Map<FoodVM>(food);

            // Get categories
            var categories = from c in _dbContext.Categories
                             join fc in _dbContext.FoodCategories on c.ID equals fc.CategoryID
                             join f in _dbContext.Foods on fc.FoodID equals f.ID
                             where f.ID == id
                             select _mapper.Map<CategoryVM>(c);
            foodVM.CategoryVMs = await categories.ToListAsync();

            // Get ratings
            var ratings = from r in _dbContext.Ratings
                          where r.FoodID == id
                          select r;
            if(ratings != null && ratings.Count() > 0)
            {
                foodVM.AgvRating = ratings.Average(a => a.Star);
                foodVM.TotalRating = ratings.Count();
            }
            else
            {
                foodVM.AgvRating = 0;
                foodVM.TotalRating = 0;
            }

            return new SuccessedResult<FoodVM>(foodVM);
        }

        public async Task<ApiResult<FoodVM>> Create(FoodCreateVM vm)
        {
            if(vm.ImageData == null)
            {
                return new FailedResult<FoodVM>("Invalid image!");
            }
            var result = await _dbContext.Foods.AddAsync(_mapper.Map<Food>(vm));
            
            try
            {
                result.Entity.ImagePath = await _fileServices.SaveFile(vm.ImageData);

                await _dbContext.SaveChangesAsync();
            }
            catch (Exception e)
            {
                return new FailedResult<FoodVM>(e.InnerException.ToString());
            }
            return new SuccessedResult<FoodVM>(_mapper.Map<FoodVM>(result.Entity));
        }

        public async Task<ApiResult<FoodVM>> Edit(int id, FoodEditVM foodVM)
        {
            var food = await _dbContext.Foods.FirstOrDefaultAsync(c => c.ID == id);
            if (food == null)
            {
                return new FailedResult<FoodVM>("Food not found!");
            }
            food.Name = foodVM.Name;
            food.Description = foodVM.Description;
            food.Price = foodVM.Price;
            food.Count = foodVM.Count;
            //food.Ratings = foodVM.Ratings;
            //food.OrderDetails = foodVM.OrderDetails;
            //food.Images = foodVM.Images;
            //food.FoodCategories = foodVM.FoodCategories; // Todo: we need to use categories here, not foodcategories
            try
            {
                if(foodVM.ImageData!=null)
                {
                    await _fileServices.DeleteFileAsync(food.ImagePath);
                    food.ImagePath = await _fileServices.SaveFile(foodVM.ImageData);
                }
                await _dbContext.SaveChangesAsync();
            }
            catch (Exception e)
            {
                return new FailedResult<FoodVM>(e.InnerException.ToString());
            }

            return new SuccessedResult<FoodVM>(_mapper.Map<FoodVM>(food));
        }

        public async Task<ApiResult<bool>> Delete(int id)
        {
            var food = await _dbContext.Foods.FirstOrDefaultAsync(c => c.ID == id);
            if (food == null)
            {
                return new FailedResult<bool>("Food not found!");
            }
            try
            {
                await _fileServices.DeleteFileAsync(food.ImagePath);
                var listFC = await (from fc in _dbContext.FoodCategories
                                    where fc.FoodID == id
                                    select fc).ToListAsync();
                _dbContext.FoodCategories.RemoveRange(listFC);
                _dbContext.Foods.Remove(food);
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

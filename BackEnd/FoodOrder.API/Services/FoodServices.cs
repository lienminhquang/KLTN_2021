using AutoMapper;
using FoodOrder.Core.Helpers;
using FoodOrder.Core.Inferstructer;
using FoodOrder.Core.Models;
using FoodOrder.Core.ViewModels;
using FoodOrder.Core.ViewModels.Categories;
using FoodOrder.Core.ViewModels.Foods;
using FoodOrder.Core.ViewModels.SaleCampaigns;
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
    public class FoodServices
    {
        private readonly ApplicationDBContext _dbContext;
        private readonly IMapper _mapper;
        private readonly FileServices _fileServices;
        private readonly ILogger<FoodServices> _logger;

        public FoodServices(ApplicationDBContext applicationDBContext, IMapper mapper, FileServices fileServices, ILogger<FoodServices> logger)
        {
            _dbContext = applicationDBContext;
            _mapper = mapper;
            _fileServices = fileServices;
            _logger = logger;
        }

        public async Task<ApiResult<PaginatedList<FoodVM>>> GetAllPaging(PagingRequestBase request)
        {
            var food = _dbContext.Foods
               //.Include(f => f.Ratings) //Todo: is this need for paging?
               //.Include(f => f.Images)
               //.Include(f => f.FoodCategories)
               .AsNoTracking()
               .Where(x => x.IsDeleted == false)
               ;



            if (!String.IsNullOrEmpty(request.SearchString))
            {
                food = food.Where(c => c.Name.Contains(request.SearchString)
                || c.Description.Contains(request.SearchString));
            }

            if (!String.IsNullOrEmpty(request.SortOrder))
            {
                food = Core.Helpers.Utilities<Food>.Sort(food, request.SortOrder, "Name");
            }

            var created = await PaginatedList<FoodVM>.CreateAsync(food.Select(f => _mapper.Map<Food, FoodVM>(f)), request.PageNumber ?? 1, request.PageSize ?? Core.Helpers.Configs.DefaultPageSize);

            // get sale campaign for each food
            foreach (var item in created.Items)
            {
                var ratings = from r in _dbContext.Ratings
                              where r.FoodID == item.ID && r.IsDeleted == false
                              select r;
                if (ratings != null && ratings.Count() > 0)
                {
                    item.AgvRating = ratings.Average(a => a.Star);
                    item.TotalRating = ratings.Count();
                }

                var query = from cf in _dbContext.SaleCampaignFoods
                            join c in _dbContext.SaleCampaigns on cf.SaleCampaignID equals c.ID
                            where (cf.FoodID == item.ID) && c.IsDeleted == false
                            && (c.Enabled == true)
                            && (c.StartDate <= DateTime.Now)
                            && (c.EndDate >= DateTime.Now)
                            select c;
                query = query.OrderBy(x => x.Priority);
                if (query.Count() > 0)
                {
                    item.SaleCampaignVM = _mapper.Map<SaleCampaignVM>(query.First());
                }
                else
                {
                    item.SaleCampaignVM = null;
                }
            }


            return new SuccessedResult<PaginatedList<FoodVM>>(created);
        }

        public async Task<ApiResult<PaginatedList<FoodVM>>> GetBestSellingAsync(PagingRequestBase request)
        {
            var food = from f in _dbContext.Foods
                       where f.IsDeleted == false
                       join od in _dbContext.OrderDetails on f.ID equals od.FoodID
                       group f by f.ID into g
                       select new { id = g.Key, count = g.Count() };


            var listFood = from f in _dbContext.Foods
                           join fid in food on f.ID equals fid.id
                           orderby fid.count descending
                           select f;

            var created = await PaginatedList<FoodVM>.CreateAsync(
                listFood.Select(x => _mapper.Map<FoodVM>(x)),
                request.PageNumber ?? 1,
                request.PageSize?? -1);

            
            // get sale campaign for each food
            foreach (var item in created.Items)
            {
                var ratings = from r in _dbContext.Ratings
                              where r.FoodID == item.ID && r.IsDeleted == false
                              select r;
                if (ratings != null && ratings.Count() > 0)
                {
                    item.AgvRating = ratings.Average(a => a.Star);
                    item.TotalRating = ratings.Count();
                }


                var query = from cf in _dbContext.SaleCampaignFoods
                            join c in _dbContext.SaleCampaigns on cf.SaleCampaignID equals c.ID
                            where (cf.FoodID == item.ID) && c.IsDeleted == false
                            && (c.Enabled == true)
                            && (c.StartDate <= DateTime.Now)
                            && (c.EndDate >= DateTime.Now)
                            select c;
                query = query.OrderBy(x => x.Priority);
                if (query.Count() > 0)
                {
                    item.SaleCampaignVM = _mapper.Map<SaleCampaignVM>(query.First());
                }
                else
                {
                    item.SaleCampaignVM = null;
                }
            }

            return new SuccessedResult<PaginatedList<FoodVM>>(created);
        }

        public ApiResult<PaginatedList<FoodVM>> GetMostDiscounted(PagingRequestBase request)
        {
            var food = from f in _dbContext.Foods.Where(x => x.IsDeleted == false)
                       join fsc in _dbContext.SaleCampaignFoods on f.ID equals fsc.FoodID
                       join sc in _dbContext.SaleCampaigns on fsc.SaleCampaignID equals sc.ID
                       where (sc.Enabled == true)
                            && (sc.StartDate <= DateTime.Now)
                            && (sc.EndDate >= DateTime.Now)
                            && sc.IsDeleted == false
                       select new { f, sc };
            food.ToList().Sort( (x ,y) => { return (int)(y.sc.Percent - x.sc.Percent); });
            var listFoodVM = food.Select(x => _mapper.Map<FoodVM>(x.f)).ToList();

            var created = PaginatedList<FoodVM>.CreateFromList(listFoodVM, request.PageNumber ?? 1, request.PageSize ?? Core.Helpers.Configs.DefaultPageSize);

            // get sale campaign for each food
            foreach (var item in created.Items)
            {
                var ratings = from r in _dbContext.Ratings
                              where r.FoodID == item.ID && r.IsDeleted == false
                              select r;
                if (ratings != null && ratings.Count() > 0)
                {
                    item.AgvRating = ratings.Average(a => a.Star);
                    item.TotalRating = ratings.Count();
                }

                var query = from cf in _dbContext.SaleCampaignFoods
                            join c in _dbContext.SaleCampaigns on cf.SaleCampaignID equals c.ID
                            where (cf.FoodID == item.ID) && c.IsDeleted == false
                            && (c.Enabled == true)
                            && (c.StartDate <= DateTime.Now)
                            && (c.EndDate >= DateTime.Now)
                            select c;
                query = query.OrderBy(x => x.Priority);
                if (query.Count() > 0)
                {
                    item.SaleCampaignVM = _mapper.Map<SaleCampaignVM>(query.First());
                }
                else
                {
                    item.SaleCampaignVM = null;
                }
            }

            return new SuccessedResult<PaginatedList<FoodVM>>(created);
        }

        public async Task<ApiResult<bool>> AddFoodToCategories(List<string> categoryIDs, int foodID)
        {
            var food = _dbContext.Foods.Find(foodID);
            if (food == null || food.IsDeleted)
            {
                return new FailedResult<bool>("Food not found!");
            }
            foreach (var cID in categoryIDs)
            {
                int id = 0;
                if (int.TryParse(cID, out id) == false)
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
            if (food == null || food.IsDeleted)
            {
                return new FailedResult<bool>("Food not found!");
            }

            try
            {
                var listFC = await (from fc in _dbContext.FoodCategories
                                    where fc.FoodID == foodID
                                    select fc).ToListAsync();
                _dbContext.FoodCategories.RemoveRange(listFC);
                await _dbContext.SaveChangesAsync();
            }
            catch (Exception e)
            {
                _logger.LogError(e.Message);
                return new FailedResult<bool>("Some thing went wrong!");
            }


            return new SuccessedResult<bool>(true);
        }
        public async Task<ApiResult<FoodVM>> GetByID(int id)
        {
            var food = await _dbContext.Foods.FirstOrDefaultAsync(c => c.ID == id);
            if (food == null || food.IsDeleted)
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
            if (ratings != null && ratings.Count() > 0)
            {
                foodVM.AgvRating = ratings.Average(a => a.Star);
                foodVM.TotalRating = ratings.Count();
            }
            else
            {
                foodVM.AgvRating = 0;
                foodVM.TotalRating = 0;
            }

            var query = from cf in _dbContext.SaleCampaignFoods
                        join c in _dbContext.SaleCampaigns on cf.SaleCampaignID equals c.ID
                        where (cf.FoodID == foodVM.ID)
                        && (c.Enabled == true)
                        && (c.StartDate <= DateTime.Now)
                        && (c.EndDate >= DateTime.Now)
                        select c;

            // Only lowest priority campaign be display
            query = query.OrderBy(x => x.Priority);
            if (query.Count() > 0)
            {
                foodVM.SaleCampaignVM = _mapper.Map<SaleCampaignVM>(query.First());
            }
            else
            {
                foodVM.SaleCampaignVM = null;
            }

            return new SuccessedResult<FoodVM>(foodVM);
        }

        public async Task<ApiResult<FoodVM>> Create(FoodCreateVM vm)
        {
            if (vm.ImageData == null)
            {
                return new FailedResult<FoodVM>("Invalid image!");
            }

            try
            {
                var result = await _dbContext.Foods.AddAsync(_mapper.Map<Food>(vm));
                result.Entity.ImagePath = await _fileServices.SaveFile(vm.ImageData);
                await _dbContext.SaveChangesAsync();
                return new SuccessedResult<FoodVM>(_mapper.Map<FoodVM>(result.Entity));
            }
            catch (Exception e)
            {
                _logger.LogError(e.Message);
                return new FailedResult<FoodVM>("Some thing went wrong!");
            }
            
        }

        public async Task<ApiResult<FoodVM>> Edit(int id, FoodEditVM foodVM)
        {
            var food = await _dbContext.Foods.FirstOrDefaultAsync(c => c.ID == id);
            if (food == null || food.IsDeleted)
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
                if (foodVM.ImageData != null)
                {
                    await _fileServices.DeleteFileAsync(food.ImagePath);
                    food.ImagePath = await _fileServices.SaveFile(foodVM.ImageData);
                }
                await _dbContext.SaveChangesAsync();
            }
            catch (Exception e)
            {
                _logger.LogError(e.Message);
                return new FailedResult<FoodVM>("Some thing went wrong!");
            }

            return new SuccessedResult<FoodVM>(_mapper.Map<FoodVM>(food));
        }

        public async Task<ApiResult<bool>> Delete(int id)
        {
            var food = await _dbContext.Foods.FirstOrDefaultAsync(c => c.ID == id);
            if (food == null || food.IsDeleted)
            {
                return new FailedResult<bool>("Food not found!");
            }
            try
            {
                var listCart = _dbContext.Carts.Where(x => x.FoodID == id);
                _dbContext.Carts.RemoveRange(listCart);
                var listFC = _dbContext.FoodCategories.Where(x => x.FoodID == id);
                await listFC.ForEachAsync(x => { x.IsDeleted = true; x.TimeDeleted = DateTime.Now; });
                food.IsDeleted = true;
                food.TimeDeleted = DateTime.Now;
                await _dbContext.SaveChangesAsync();
            }
            catch (Exception e)
            {
                _logger.LogError(e.Message);
                return new FailedResult<bool>("Some thing went wrong!");
            }
            return new SuccessedResult<bool>(true);
        }

        public async Task<ApiResult<bool>> DeletePermanently(int id)
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
                _logger.LogError(e.Message);
                return new FailedResult<bool>("Some thing went wrong!");
            }
            return new SuccessedResult<bool>(true);
        }
    }
}

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
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace FoodOrder.API.Services
{
    public class CategoryServices
    {
        private readonly ApplicationDBContext _dbContext;
        private readonly IMapper _mapper;
        private readonly FileServices _fileServices;
        private readonly ILogger<CategoryServices> _logger;

        public CategoryServices(ApplicationDBContext applicationDBContext, IMapper mapper, FileServices fileServices, ILogger<CategoryServices> logger)
        {
            _dbContext = applicationDBContext;
            _mapper = mapper;
            _fileServices = fileServices;
            _logger = logger;
        }

        public async Task<ApiResult<PaginatedList<CategoryVM>>> GetAllPaging(PagingRequestBase request)
        {
            var categoryVMs = from c in _dbContext.Categories
                              select c;

            if (!String.IsNullOrEmpty(request.SearchString))
            {
                categoryVMs = categoryVMs.Where(c => c.Name.Contains(request.SearchString)
                || c.Description.Contains(request.SearchString));
            }

            categoryVMs = Core.Helpers.Utilities<Category>.Sort(categoryVMs, request.SortOrder, "ID");

            var created = await PaginatedList<CategoryVM>.CreateAsync(categoryVMs.Select(a => _mapper.Map<CategoryVM>(a)), request.PageNumber ?? 1, request.PageSize ?? Core.Helpers.Configs.DefaultPageSize);

            return new SuccessedResult<PaginatedList<CategoryVM>>(created);
        }

        public async Task<ApiResult<PaginatedList<FoodVM>>> GetFoodInCategory(int id, PagingRequestBase request)
        {
            var category = await _dbContext.Categories.FirstOrDefaultAsync(c => c.ID == id);
            if (category == null)
            {
                return new FailedResult<PaginatedList<FoodVM>>("Category not found!");
            }

            var foods = from c in _dbContext.Categories
                        join fc in _dbContext.FoodCategories
                        on c.ID equals fc.CategoryID
                        join f in _dbContext.Foods
                        on fc.FoodID equals f.ID
                        where c.ID == id
                        select f;


            var created = await PaginatedList<FoodVM>.CreateAsync(foods.Select(f => _mapper.Map<Food, FoodVM>(f)), request.PageNumber ?? 1, request.PageSize ?? Core.Helpers.Configs.DefaultPageSize);

            foreach (var item in created.Items)
            {
                // get rating
                var ratings = from r in _dbContext.Ratings
                              where r.FoodID == item.ID
                              select r;
                if (ratings != null && ratings.Count() > 0)
                {
                    item.AgvRating = ratings.Average(a => a.Star);
                    item.TotalRating = ratings.Count();
                }

                // get sale campaign
                var query = from fs in _dbContext.SaleCampaignFoods
                            join f in _dbContext.Foods on fs.FoodID equals f.ID
                            join sc in _dbContext.SaleCampaigns on fs.SaleCampaignID equals sc.ID
                            where f.ID == item.ID
                            select sc;
                var list = query.OrderBy(x => x.Priority).ToList();
                if (list.Count > 0)
                {
                    item.SaleCampaignVM = _mapper.Map<SaleCampaignVM>(list.First());
                }
            }

            return new SuccessedResult<PaginatedList<FoodVM>>(created);
        }

        public async Task<ApiResult<PaginatedList<FoodVM>>> GetBestSellingInCategory(int id, PagingRequestBase request)
        {
            var category = await _dbContext.Categories.FirstOrDefaultAsync(c => c.ID == id);
            if (category == null)
            {
                return new FailedResult<PaginatedList<FoodVM>>("Category not found!");
            }

            var food = from f in _dbContext.Foods
                       join od in _dbContext.OrderDetails on f.ID equals od.FoodID 
                       join fc in _dbContext.FoodCategories on f.ID equals fc.FoodID
                       where fc.CategoryID == id
                       group f by f.ID into g
                       
                       select new { id = g.Key, count = g.Count()};

           
            var listFood = from f in _dbContext.Foods
                           join fid in food on f.ID equals fid.id
                           orderby fid.count descending
                           select f;

            var created = await PaginatedList<FoodVM>.CreateAsync(
                listFood.Select(x => _mapper.Map<FoodVM>(x)), 
                request.PageNumber ?? 1,
                request.PageSize ?? -1);

            // now the size of list is small
            foreach (var item in created.Items)
            {
                // get rating
                var ratings = from r in _dbContext.Ratings
                              where r.FoodID == item.ID
                              select r;
                if (ratings != null && ratings.Count() > 0)
                {
                    item.AgvRating = ratings.Average(a => a.Star);
                    item.TotalRating = ratings.Count();
                }

                // get sale campaign
                var query = from fs in _dbContext.SaleCampaignFoods
                            join f in _dbContext.Foods on fs.FoodID equals f.ID
                            join sc in _dbContext.SaleCampaigns on fs.SaleCampaignID equals sc.ID
                            where f.ID == item.ID
                            select sc;
                var list = query.OrderBy(x => x.Priority).ToList();
                if (list.Count > 0)
                {
                    item.SaleCampaignVM = _mapper.Map<SaleCampaignVM>(list.First());
                }
            }

            return new SuccessedResult<PaginatedList<FoodVM>>(created);
        }

        public async Task<ApiResult<PaginatedList<FoodVM>>> GetPromotingInCategory(int id, PagingRequestBase request)
        {
            var category = await _dbContext.Categories.FirstOrDefaultAsync(c => c.ID == id);
            if (category == null)
            {
                return new FailedResult<PaginatedList<FoodVM>>("Category not found!");
            }

            var food = from f in _dbContext.Foods
                       join fsc in _dbContext.SaleCampaignFoods on f.ID equals fsc.FoodID
                       join sc in _dbContext.SaleCampaigns on fsc.SaleCampaignID equals sc.ID
                       where (sc.Enabled == true)
                            && (sc.StartDate <= DateTime.Now)
                            && (sc.EndDate >= DateTime.Now)
                       select new { f, sc };
            food = from f in food
                   join fc in _dbContext.FoodCategories on f.f.ID equals fc.FoodID
                   select f;

            food.ToList().Sort((x, y) => { return (int)(y.sc.Percent - x.sc.Percent); });
            var listFoodVM = food.Select(x => _mapper.Map<FoodVM>(x.f)).ToList();

            var created = PaginatedList<FoodVM>.CreateFromList(listFoodVM, request.PageNumber ?? 1, request.PageSize ?? Core.Helpers.Configs.DefaultPageSize);

            foreach (var item in created.Items)
            {
                // get rating
                var ratings = from r in _dbContext.Ratings
                              where r.FoodID == item.ID
                              select r;
                if (ratings != null && ratings.Count() > 0)
                {
                    item.AgvRating = ratings.Average(a => a.Star);
                    item.TotalRating = ratings.Count();
                }

                // get sale campaign
                var query = from fs in _dbContext.SaleCampaignFoods
                            join f in _dbContext.Foods on fs.FoodID equals f.ID
                            join sc in _dbContext.SaleCampaigns on fs.SaleCampaignID equals sc.ID
                            where f.ID == item.ID
                            select sc;
                var list = query.OrderBy(x => x.Priority).ToList();
                if (list.Count > 0)
                {
                    item.SaleCampaignVM = _mapper.Map<SaleCampaignVM>(list.First());
                }
            }

            return new SuccessedResult<PaginatedList<FoodVM>>(created);
        }

        public async Task<ApiResult<CategoryVM>> GetByID(int id)
        {
            var c = await _dbContext.Categories.FirstOrDefaultAsync(c => c.ID == id);
            if (c == null)
            {
                return new FailedResult<CategoryVM>("Category not found!");
            }
            return new SuccessedResult<CategoryVM>(_mapper.Map<CategoryVM>(c));
        }

        public async Task<ApiResult<CategoryVM>> Create(CategoryCreateVM vm)
        {
            if (vm.ImageBinary == null)
            {
                return new FailedResult<CategoryVM>("Invalid image!");
            }
           
            try
            {
                var result = await _dbContext.Categories.AddAsync(new Category
                {
                    Description = vm.Description,
                    Name = vm.Name
                });
                result.Entity.ImagePath = await _fileServices.SaveFile(vm.ImageBinary);
                await _dbContext.SaveChangesAsync();
                return new SuccessedResult<CategoryVM>(new CategoryVM()
                {
                    Description = result.Entity.Description,
                    ID = result.Entity.ID,
                    Name = result.Entity.Name,
                    ImagePath = result.Entity.ImagePath
                });
            }
            catch (Exception e)
            {
                _logger.LogError(e.Message);
                return new FailedResult<CategoryVM>("Some thing went wrong");
            }
           
        }

        public async Task<ApiResult<CategoryVM>> Edit(int id, CategoryEditVM categoryVM)
        {
            var category = await _dbContext.Categories.FirstOrDefaultAsync(c => c.ID == id);
            if (category == null)
            {
                return new FailedResult<CategoryVM>("Category not found!");
            }
            category.Name = categoryVM.Name;
            category.Description = categoryVM.Description;
            try
            {
                if (categoryVM.ImageBinary != null)
                {
                    if (category.ImagePath != null)
                    {
                        await _fileServices.DeleteFileAsync(category.ImagePath);
                    }
                    category.ImagePath = await _fileServices.SaveFile(categoryVM.ImageBinary);
                }
                await _dbContext.SaveChangesAsync();
            }
            catch (Exception e)
            {
                _logger.LogError(e.Message);
                return new FailedResult<CategoryVM>("Some thing went wrong!");
            }

            return new SuccessedResult<CategoryVM>(_mapper.Map<CategoryVM>(category));
        }

        public async Task<ApiResult<bool>> Delete(int id)
        {
            var category = await _dbContext.Categories.FirstOrDefaultAsync(c => c.ID == id);
            if (category == null)
            {
                return new FailedResult<bool>("Category not found!");
            }
            try
            {
                await _fileServices.DeleteFileAsync(category.ImagePath);
                _dbContext.Categories.Remove(category);
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

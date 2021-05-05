using FoodOrder.Core.Helpers;
using FoodOrder.Core.Inferstructer;
using FoodOrder.Core.Models;
using FoodOrder.Core.ViewModels;
using FoodOrder.Core.ViewModels.Categories;
using FoodOrder.Data;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace FoodOrder.API.Services
{
    public class CategoryServices
    {
        private readonly ApplicationDBContext _dbContext;

        public CategoryServices(ApplicationDBContext applicationDBContext)
        {
            _dbContext = applicationDBContext;
        }

        public async Task<ApiResult<PaginatedList<CategoryVM>>> GetAllPaging(PagingRequestBase request)
        {
            var categoryVMs = from c in _dbContext.Categories
                        select new CategoryVM()
                        {
                            Description = c.Description,
                            ID = c.ID,
                            Name = c.Name
                        };
            if (!String.IsNullOrEmpty(request.SearchString))
            {
                request.PageNumber = 1;
            }
            else
            {
                request.SearchString = request.CurrentFilter;
            }

            if (!String.IsNullOrEmpty(request.SearchString))
            {
                categoryVMs = categoryVMs.Where(c => c.Name.Contains(request.SearchString)
                || c.Description.Contains(request.SearchString));
            }

            categoryVMs = Core.Helpers.Utilities<CategoryVM>.Sort(categoryVMs, request.SortOrder, "ID");

            var created = await PaginatedList<CategoryVM>.CreateAsync(categoryVMs, request.PageNumber ?? 1, Core.Helpers.Configs.PageSize);

            return new SuccessedResult<PaginatedList<CategoryVM>>(created);
        }

        public async Task<ApiResult<CategoryVM>> GetByID(int id)
        {
            var c = await _dbContext.Categories.FirstOrDefaultAsync(c => c.ID == id);
            if (c == null)
            {
                return new FailedResult<CategoryVM>("Category not found!");
            }
            return new SuccessedResult<CategoryVM>(new CategoryVM()
            {
                Description = c.Description,
                ID = c.ID,
                Name = c.Name
            });
        }

        public async Task<ApiResult<CategoryVM>> Create(CategoryCreateVM vm)
        {
            var result = await _dbContext.Categories.AddAsync(new Category
            {
                Description = vm.Description,
                Name = vm.Name
            });
            try
            {
                await _dbContext.SaveChangesAsync();
            }
            catch (Exception e)
            {
                return new FailedResult<CategoryVM>(e.InnerException.ToString());
            }
            return new SuccessedResult<CategoryVM>(new CategoryVM()
            {
                Description = result.Entity.Description,
                ID = result.Entity.ID,
                Name = result.Entity.Name
            });
        }

        public async Task<ApiResult<CategoryVM>> Edit(int id, CategoryVM categoryVM)
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
                await _dbContext.SaveChangesAsync();
            }
            catch (Exception e)
            {
                return new FailedResult<CategoryVM>(e.InnerException.ToString());
            }

            return new SuccessedResult<CategoryVM>(categoryVM);
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
                _dbContext.Categories.Remove(category);
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

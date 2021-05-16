using AutoMapper;
using FoodOrder.Core.Helpers;
using FoodOrder.Core.Inferstructer;
using FoodOrder.Core.Models;
using FoodOrder.Core.ViewModels;
using FoodOrder.Core.ViewModels.Foods;
using FoodOrder.Data;
using Microsoft.EntityFrameworkCore;
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
               .Include(f => f.Ratings) //Todo: is this need for paging?
               .Include(f => f.Images)
               .Include(f => f.FoodCategories)
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

        public async Task<ApiResult<FoodVM>> GetByID(int id)
        {
            var c = await _dbContext.Foods.FirstOrDefaultAsync(c => c.ID == id);
            if (c == null)
            {
                return new FailedResult<FoodVM>("Food not found!");
            }
            return new SuccessedResult<FoodVM>(_mapper.Map<FoodVM>(c));
        }

        public async Task<ApiResult<FoodVM>> Create(FoodCreateVM vm)
        {
            var result = await _dbContext.Foods.AddAsync(_mapper.Map<Food>(vm));
            try
            {
                var image = _mapper.Map<Image>(vm);
                image.ImagePath = await _fileServices.SaveFile(vm.ImageData);

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
                await _fileServices.DeleteFileAsync(food.ImagePath);
                food.ImagePath = await _fileServices.SaveFile(foodVM.ImageData);
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

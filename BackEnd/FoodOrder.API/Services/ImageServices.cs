using AutoMapper;
using FoodOrder.Core.Helpers;
using FoodOrder.Core.Inferstructer;
using FoodOrder.Core.Models;
using FoodOrder.Core.ViewModels;
using FoodOrder.Core.ViewModels.Images;
using FoodOrder.Data;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace FoodOrder.API.Services
{
    public class ImageServices
    {
        private readonly ApplicationDBContext _dbContext;
        private readonly IMapper _mapper;

        public ImageServices(ApplicationDBContext applicationDBContext, IMapper mapper)
        {
            _dbContext = applicationDBContext;
            _mapper = mapper;
        }

        public async Task<ApiResult<PaginatedList<ImageVM>>> GetAllPaging(PagingRequestBase request)
        {
            var vms = from c in _dbContext.Images select c;

            if (!String.IsNullOrEmpty(request.SearchString))
            {
                vms = vms.Where(c => c.Caption.Contains(request.SearchString));
            }

            vms = Core.Helpers.Utilities<Image>.Sort(vms, request.SortOrder, "ID");

            var created = await PaginatedList<ImageVM>.CreateAsync(vms.Select(i => _mapper.Map<ImageVM>(i)), request.PageNumber ?? 1, Core.Helpers.Configs.PageSize);

            return new SuccessedResult<PaginatedList<ImageVM>>(created);
        }

        public async Task<ApiResult<ImageVM>> GetByID(int id)
        {
            var c = await _dbContext.Images.FirstOrDefaultAsync(c => c.ID == id);
            if (c == null)
            {
                return new FailedResult<ImageVM>("Image not found!");
            }
            return new SuccessedResult<ImageVM>(_mapper.Map<ImageVM>(c));
        }

        public async Task<ApiResult<ImageVM>> Create(ImageCreateVM vm)
        {
            var result = await _dbContext.Images.AddAsync(_mapper.Map<Image>(vm));
            try
            {
                await _dbContext.SaveChangesAsync();
            }
            catch (Exception e)
            {
                return new FailedResult<ImageVM>(e.InnerException.ToString());
            }
            return new SuccessedResult<ImageVM>(_mapper.Map<ImageVM>(result.Entity));
        }

        public async Task<ApiResult<ImageVM>> Edit(int id, ImageVM editVM)
        {
            var vm = await _dbContext.Images.FirstOrDefaultAsync(c => c.ID == id);
            if (vm == null)
            {
                return new FailedResult<ImageVM>("Image not found!");
            }
            vm.IsDefault = editVM.IsDefault;
            vm.Caption = editVM.Caption;
            vm.SortOrder = editVM.SortOrder;
            vm.FoodID = editVM.FoodID;
            vm.ImagePath = editVM.ImagePath;
            
            try
            {
                await _dbContext.SaveChangesAsync();
            }
            catch (Exception e)
            {
                return new FailedResult<ImageVM>(e.InnerException.ToString());
            }

            return new SuccessedResult<ImageVM>(editVM);
        }

        public async Task<ApiResult<bool>> Delete(int id)
        {
            var image = await _dbContext.Images.FirstOrDefaultAsync(c => c.ID == id);
            if (image == null)
            {
                return new FailedResult<bool>("Image not found!");
            }
            try
            {
                _dbContext.Images.Remove(image);
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


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
        private readonly FileServices _fileServices;

        public ImageServices(ApplicationDBContext applicationDBContext, IMapper mapper, FileServices fileServices)
        {
            _dbContext = applicationDBContext;
            _mapper = mapper;
            _fileServices = fileServices;
        }

        public async Task<ApiResult<PaginatedList<ImageVM>>> GetAllPaging(PagingRequestBase request)
        {
            var vms = from c in _dbContext.Images select c;

            if (!String.IsNullOrEmpty(request.SearchString))
            {
                vms = vms.Where(c => c.Caption.Contains(request.SearchString));
            }

            vms = Core.Helpers.Utilities<Image>.Sort(vms, request.SortOrder, "ID");
            var mapped = vms.Select(i => _mapper.Map<ImageVM>(i));

            var created = await PaginatedList<ImageVM>.CreateAsync(mapped, request.PageNumber ?? 1, Core.Helpers.Configs.PageSize);
            
            return new SuccessedResult<PaginatedList<ImageVM>>(created);
        }

        public async Task<ApiResult<ImageVM>> GetByID(int id)
        {
            var c = await _dbContext.Images.FirstOrDefaultAsync(c => c.ID == id);
            if (c == null)
            {
                return new FailedResult<ImageVM>("Image not found!");
            }
            var image = _mapper.Map<ImageVM>(c);
            
            return new SuccessedResult<ImageVM>(image);
        }

        public async Task<ApiResult<ImageVM>> Create(ImageCreateVM vm)
        {
            try
            {
                var image = _mapper.Map<Image>(vm);
                image.ImagePath = await _fileServices.SaveFile(vm.ImageData);
                var result = await _dbContext.Images.AddAsync(image);
                await _dbContext.SaveChangesAsync();
                return new SuccessedResult<ImageVM>(_mapper.Map<ImageVM>(result.Entity));
            }
            catch (Exception e)
            {
                return new FailedResult<ImageVM>(e.Message.ToString());
            }
        }

        public async Task<ApiResult<ImageVM>> Edit(int id, ImageEditVM editVM)
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
            
            try
            {
                await _fileServices.DeleteFileAsync(vm.ImagePath);
                vm.ImagePath =  await _fileServices.SaveFile(editVM.ImageData);
                await _dbContext.SaveChangesAsync();
            }
            catch (Exception e)
            {
                return new FailedResult<ImageVM>(e.InnerException.ToString());
            }

            return new SuccessedResult<ImageVM>(_mapper.Map<ImageVM>(vm));
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
                await _fileServices.DeleteFileAsync(image.ImagePath);
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


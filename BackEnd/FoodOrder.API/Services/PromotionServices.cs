using AutoMapper;
using FoodOrder.Core.Helpers;
using FoodOrder.Core.Inferstructer;
using FoodOrder.Core.Models;
using FoodOrder.Core.ViewModels;
using FoodOrder.Core.ViewModels.Promotions;
using FoodOrder.Data;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace FoodOrder.API.Services
{
    public class PromotionServices
    {
        private readonly ApplicationDBContext _dbContext;
        private readonly IMapper _mapper;

        public PromotionServices(ApplicationDBContext applicationDBContext, IMapper mapper)
        {
            _dbContext = applicationDBContext;
            _mapper = mapper;
        }

        public async Task<ApiResult<PaginatedList<PromotionVM>>> GetAllPaging(PagingRequestBase request)
        {
            var vMs = from c in _dbContext.Promotions select _mapper.Map<Promotion, PromotionVM>(c);

            if (!String.IsNullOrEmpty(request.SearchString))
            {
                vMs = vMs.Where(c => c.Name.Contains(request.SearchString)
                || c.Desciption.Contains(request.SearchString)
                || c.Code.Contains(request.SearchString));
            }

            vMs = Core.Helpers.Utilities<PromotionVM>.Sort(vMs, request.SortOrder, "ID");

            var created = await PaginatedList<PromotionVM>.CreateAsync(vMs, request.PageNumber ?? 1, Core.Helpers.Configs.PageSize);

            return new SuccessedResult<PaginatedList<PromotionVM>>(created);
        }

        public async Task<ApiResult<PromotionVM>> GetByID(int id)
        {
            var c = await _dbContext.Promotions.FirstOrDefaultAsync(c => c.ID == id);
            if (c == null)
            {
                return new FailedResult<PromotionVM>("Order not found!");
            }
            return new SuccessedResult<PromotionVM>(_mapper.Map<Promotion, PromotionVM>(c));
        }

        public async Task<ApiResult<PromotionVM>> Create(PromotionCreateVM vm)
        {
            var result = await _dbContext.Promotions.AddAsync(_mapper.Map<PromotionCreateVM, Promotion>(vm));
            try
            {
                await _dbContext.SaveChangesAsync();
            }
            catch (Exception e)
            {
                return new FailedResult<PromotionVM>(e.InnerException.ToString());
            }
            return new SuccessedResult<PromotionVM>(_mapper.Map<PromotionVM>(result.Entity));
        }

        public async Task<ApiResult<PromotionVM>> Edit(int id, PromotionEditVM editVM)
        {
            var vm = await _dbContext.Promotions.FirstOrDefaultAsync(c => c.ID == id);
            if (vm == null)
            {
                return new FailedResult<PromotionVM>("Promotion not found!");
            }
            vm.Name = editVM.Name;
            vm.Desciption = editVM.Desciption;
            vm.Code = editVM.Code;
            vm.Amount = editVM.Amount;
            vm.EndDate = editVM.EndDate;
            vm.Enabled = editVM.Enabled;
            vm.StartDate = editVM.StartDate;
            vm.Max = editVM.Max;
            vm.MinPrice = editVM.MinPrice;
            vm.Percent = editVM.Percent;

            try
            {
                await _dbContext.SaveChangesAsync();
            }
            catch (Exception e)
            {
                return new FailedResult<PromotionVM>(e.InnerException.ToString());
            }

            return new SuccessedResult<PromotionVM>(_mapper.Map<PromotionVM>(vm));
        }

        public async Task<ApiResult<bool>> Delete(int id)
        {
            var vm = await _dbContext.Promotions.FirstOrDefaultAsync(c => c.ID == id);
            if (vm == null)
            {
                return new FailedResult<bool>("Promotion not found!");
            }
            try
            {
                _dbContext.Promotions.Remove(vm);
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

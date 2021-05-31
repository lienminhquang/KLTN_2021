using AutoMapper;
using FoodOrder.Core.Helpers;
using FoodOrder.Core.Inferstructer;
using FoodOrder.Core.Models;
using FoodOrder.Core.ViewModels;
using FoodOrder.Core.ViewModels.Foods;
using FoodOrder.Core.ViewModels.Promotions;
using FoodOrder.Data;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;
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
        private readonly ILogger<PromotionServices> _logger;

        public PromotionServices(ApplicationDBContext applicationDBContext, IMapper mapper, ILogger<PromotionServices> logger)
        {
            _dbContext = applicationDBContext;
            _mapper = mapper;
            _logger = logger;
        }

        public async Task<ApiResult<PaginatedList<PromotionVM>>> GetAllValidPaging(PagingRequestBase request, String userID)
        {
            var user = _dbContext.AppUsers.Find(new Guid(userID));
            if(user == null)
            {
                return new  FailedResult<PaginatedList<PromotionVM>>("User not found!");
            }

            var vMs = (from c in _dbContext.Promotions
                      where (c.Enabled == true)
                      && (c.StartDate <= DateTime.Now)
                      && (c.EndDate >= DateTime.Now)
                      select c);

            if (!String.IsNullOrEmpty(request.SearchString))
            {
                vMs = vMs.Where(c => c.Name.Contains(request.SearchString)
                || c.Desciption.Contains(request.SearchString)
                || c.Code.Contains(request.SearchString));
            }

            var vmList = await Core.Helpers.Utilities<Promotion>.Sort(vMs, request.SortOrder, "Priority").ToListAsync();
            // 
            var a = vmList.Where(x => {
                var timeUsed = (from o in _dbContext.Orders
                                where o.AppUserID.ToString().Equals(userID) && o.PromotionID == x.ID
                                select o).Count();
                return timeUsed < x.UseTimes;
            });

            var created = PaginatedList<PromotionVM>.CreateFromList(a.Select(c => _mapper.Map<Promotion, PromotionVM>(c)).ToList(), 
                request.PageNumber ?? 1, Core.Helpers.Configs.PageSize);
            
            return new SuccessedResult<PaginatedList<PromotionVM>>(created);
        }

        public async Task<ApiResult<PaginatedList<PromotionVM>>> GetAllPaging(PagingRequestBase request)
        {
            var vMs = from c in _dbContext.Promotions select c;

            if (!String.IsNullOrEmpty(request.SearchString))
            {
                vMs = vMs.Where(c => c.Name.Contains(request.SearchString)
                || c.Desciption.Contains(request.SearchString)
                || c.Code.Contains(request.SearchString));
            }

            vMs = Core.Helpers.Utilities<Promotion>.Sort(vMs, request.SortOrder, "Priority");

            var created = await PaginatedList<PromotionVM>.CreateAsync(vMs.Select(c => _mapper.Map<Promotion, PromotionVM>(c)), request.PageNumber ?? 1, Core.Helpers.Configs.PageSize);

            return new SuccessedResult<PaginatedList<PromotionVM>>(created);
        }

        public async Task<ApiResult<PromotionVM>> GetByID(int id)
        {
            var c = await _dbContext.Promotions.FirstOrDefaultAsync(c => c.ID == id);
            if (c == null)
            {
                return new FailedResult<PromotionVM>("Order not found!");
            }
           
            var vm = _mapper.Map<Promotion, PromotionVM>(c);
           

            return new SuccessedResult<PromotionVM>(vm);
        }

        public async Task<ApiResult<PromotionVM>> Create(PromotionCreateVM vm)
        {
            using var transaction = _dbContext.Database.BeginTransaction();

            try
            {
                var result = await _dbContext.Promotions.AddAsync(_mapper.Map<PromotionCreateVM, Promotion>(vm));
                await _dbContext.SaveChangesAsync();

               
                transaction.Commit();

                var promotionVM = _mapper.Map<PromotionVM>(result.Entity);
               
                return new SuccessedResult<PromotionVM>(promotionVM);
            }
            catch (Exception e)
            {
                _logger.LogError(e.Message);
                return new FailedResult<PromotionVM>("Some thing went wrong!");
            }

        }

        public async Task<ApiResult<PromotionVM>> Edit(int id, PromotionEditVM editVM)
        {
            using var transaction = _dbContext.Database.BeginTransaction();
            try
            {
                var promotion = await _dbContext.Promotions.FirstOrDefaultAsync(c => c.ID == id);
                if (promotion == null)
                {
                    return new FailedResult<PromotionVM>("Promotion not found!");
                }
                promotion.Name = editVM.Name;
                promotion.Desciption = editVM.Desciption;
                promotion.Code = editVM.Code;
                promotion.UseTimes = editVM.UseTimes;
                promotion.EndDate = editVM.EndDate;
                promotion.Enabled = editVM.Enabled;
                promotion.StartDate = editVM.StartDate;
                promotion.Max = editVM.Max;
                promotion.MinPrice = editVM.MinPrice;
                promotion.Percent = editVM.Percent;
                promotion.IsGlobal = editVM.IsGlobal;
                promotion.Priority = editVM.Priority;

                await _dbContext.SaveChangesAsync();
                transaction.Commit();

                var promotionVM = _mapper.Map<PromotionVM>(promotion);
               
                return new SuccessedResult<PromotionVM>(promotionVM);
            }
            catch (Exception e)
            {
                _logger.LogError(e.Message);
                return new FailedResult<PromotionVM>("Some thing went wrong!");
            }
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
                _logger.LogError(e.Message);
                return new FailedResult<bool>("Some thing went wrong!");
            }
            return new SuccessedResult<bool>(true);
        }
    }
}

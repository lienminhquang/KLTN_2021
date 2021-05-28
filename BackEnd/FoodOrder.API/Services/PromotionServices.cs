using AutoMapper;
using FoodOrder.Core.Helpers;
using FoodOrder.Core.Inferstructer;
using FoodOrder.Core.Models;
using FoodOrder.Core.ViewModels;
using FoodOrder.Core.ViewModels.Foods;
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
            var vMs = from c in _dbContext.Promotions select c;

            if (!String.IsNullOrEmpty(request.SearchString))
            {
                vMs = vMs.Where(c => c.Name.Contains(request.SearchString)
                || c.Desciption.Contains(request.SearchString)
                || c.Code.Contains(request.SearchString));
            }

            vMs = Core.Helpers.Utilities<Promotion>.Sort(vMs, request.SortOrder, "Priority_desc");

            var created = await PaginatedList<PromotionVM>.CreateAsync(vMs.Select(c => _mapper.Map<Promotion, PromotionVM>(c)), request.PageNumber ?? 1, Core.Helpers.Configs.PageSize);

            foreach (var item in created.Items)
            {
                var foodVMs = await (from f in _dbContext.Foods
                                     join fp in _dbContext.PromotionFoods on f.ID equals fp.FoodID
                                     where fp.PromotionID == item.ID
                                     select _mapper.Map<FoodVM>(f)).ToListAsync();
              
                item.FoodVMs = foodVMs;
            }

            return new SuccessedResult<PaginatedList<PromotionVM>>(created);
        }

        public async Task<ApiResult<PromotionVM>> GetByID(int id)
        {
            var c = await _dbContext.Promotions.FirstOrDefaultAsync(c => c.ID == id);
            if (c == null)
            {
                return new FailedResult<PromotionVM>("Order not found!");
            }
            var foodVMs = await (from f in _dbContext.Foods
                                 join fp in _dbContext.PromotionFoods on f.ID equals fp.FoodID
                                 where fp.PromotionID == id
                                 select _mapper.Map<FoodVM>(f)).ToListAsync();
           

            var vm = _mapper.Map<Promotion, PromotionVM>(c);
            vm.FoodVMs = foodVMs;

            return new SuccessedResult<PromotionVM>(vm);
        }

        public async Task<ApiResult<PromotionVM>> Create(PromotionCreateVM vm)
        {
            using var transaction = _dbContext.Database.BeginTransaction();

            try
            {
                var result = await _dbContext.Promotions.AddAsync(_mapper.Map<PromotionCreateVM, Promotion>(vm));
                await _dbContext.SaveChangesAsync();

                List<FoodVM> foodVMs = new List<FoodVM>();
                foreach (var item in vm.FoodIDs)
                {
                    var food = await _dbContext.Foods.FindAsync(item);
                    if (food == null)
                    {
                        transaction.Rollback();
                        return new FailedResult<PromotionVM>("Food not found!");
                    }
                    var rs = _dbContext.PromotionFoods.Add(new PromotionFood { FoodID = item, PromotionID = result.Entity.ID });
                    await _dbContext.SaveChangesAsync();
                    foodVMs.Add(_mapper.Map<FoodVM>(food));
                }
                transaction.Commit();

                var promotionVM = _mapper.Map<PromotionVM>(result.Entity);
                promotionVM.FoodVMs = foodVMs;
                return new SuccessedResult<PromotionVM>(promotionVM);
            }
            catch (Exception e)
            {
                return new FailedResult<PromotionVM>(e.Message.ToString());
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
                promotion.Amount = editVM.Amount;
                promotion.EndDate = editVM.EndDate;
                promotion.Enabled = editVM.Enabled;
                promotion.StartDate = editVM.StartDate;
                promotion.Max = editVM.Max;
                promotion.MinPrice = editVM.MinPrice;
                promotion.Percent = editVM.Percent;
                promotion.IsGlobal = editVM.IsGlobal;
                promotion.Priority = editVM.Priority;

                var pf = _dbContext.PromotionFoods.Where(x => x.PromotionID == editVM.ID).ToList();
                _dbContext.PromotionFoods.RemoveRange(pf);
                _dbContext.SaveChanges();

                List<FoodVM> foodVMs = new List<FoodVM>();
                if (editVM.FoodIDs != null)
                {
                    foreach (var item in editVM.FoodIDs)
                    {
                        var food = await _dbContext.Foods.FindAsync(item);
                        if (food == null)
                        {
                            transaction.Rollback();
                            return new FailedResult<PromotionVM>("Food not found!");
                        }
                        var rs = _dbContext.PromotionFoods.Add(new PromotionFood { FoodID = item, PromotionID = promotion.ID });
                        var writed = await _dbContext.SaveChangesAsync();
                        foodVMs.Add(_mapper.Map<FoodVM>(food));
                    }
                }

                await _dbContext.SaveChangesAsync();
                transaction.Commit();

                var promotionVM = _mapper.Map<PromotionVM>(promotion);
                promotionVM.FoodVMs = foodVMs;
                return new SuccessedResult<PromotionVM>(promotionVM);
            }
            catch (Exception e)
            {
                return new FailedResult<PromotionVM>(e.Message.ToString());
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
                return new FailedResult<bool>(e.InnerException.ToString());
            }
            return new SuccessedResult<bool>(true);
        }
    }
}

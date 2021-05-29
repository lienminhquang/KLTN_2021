using AutoMapper;
using FoodOrder.Core.Helpers;
using FoodOrder.Core.Inferstructer;
using FoodOrder.Core.Models;
using FoodOrder.Core.ViewModels;
using FoodOrder.Core.ViewModels.Foods;
using FoodOrder.Core.ViewModels.SaleCampaigns;
using FoodOrder.Data;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace FoodOrder.API.Services
{
    public class SaleCampaignServices
    {
        private readonly ApplicationDBContext _dbContext;
        private readonly IMapper _mapper;

        public SaleCampaignServices(ApplicationDBContext applicationDBContext, IMapper mapper)
        {
            _dbContext = applicationDBContext;
            _mapper = mapper;
        }

        public async Task<ApiResult<PaginatedList<SaleCampaignVM>>> GetAllPaging(PagingRequestBase request)
        {
            var vMs = from c in _dbContext.SaleCampaigns select c;

            if (!String.IsNullOrEmpty(request.SearchString))
            {
                vMs = vMs.Where(c => c.Name.Contains(request.SearchString)
                || c.Desciption.Contains(request.SearchString));
            }

            vMs = Core.Helpers.Utilities<SaleCampaign>.Sort(vMs, request.SortOrder, "Priority_desc");

            var created = await PaginatedList<SaleCampaignVM>.CreateAsync(vMs.Select(c => _mapper.Map<SaleCampaign, SaleCampaignVM>(c)), request.PageNumber ?? 1, Core.Helpers.Configs.PageSize);

            foreach (var item in created.Items)
            {
                var foodVMs = await (from f in _dbContext.Foods
                                     join fp in _dbContext.SaleCampaignFoods on f.ID equals fp.FoodID
                                     where fp.SaleCampaignID == item.ID
                                     select _mapper.Map<FoodVM>(f)).ToListAsync();


                item.FoodVMs = foodVMs;
            }


            return new SuccessedResult<PaginatedList<SaleCampaignVM>>(created);
        }

        public async Task<ApiResult<PaginatedList<SaleCampaignVM>>> GetAllValidPaging(PagingRequestBase request)
        {
            var vMs = from c in _dbContext.SaleCampaigns
                      where (c.Enabled == true)
                            && (c.StartDate <= DateTime.Now)
                            && (c.EndDate >= DateTime.Now)
                      select c;

            if (!String.IsNullOrEmpty(request.SearchString))
            {
                vMs = vMs.Where(c => c.Name.Contains(request.SearchString)
                || c.Desciption.Contains(request.SearchString));
            }

            vMs = Core.Helpers.Utilities<SaleCampaign>.Sort(vMs, request.SortOrder, "Priority");

            var created = await PaginatedList<SaleCampaignVM>.CreateAsync(vMs.Select(c => _mapper.Map<SaleCampaign, SaleCampaignVM>(c)), request.PageNumber ?? 1, Core.Helpers.Configs.PageSize);

            foreach (var item in created.Items)
            {
                var foodVMs = await (from f in _dbContext.Foods
                                     join fp in _dbContext.SaleCampaignFoods on f.ID equals fp.FoodID
                                     where fp.SaleCampaignID == item.ID
                                     select _mapper.Map<FoodVM>(f)).ToListAsync();


                item.FoodVMs = foodVMs;
            }


            return new SuccessedResult<PaginatedList<SaleCampaignVM>>(created);
        }

        public async Task<ApiResult<SaleCampaignVM>> GetByID(int id)
        {
            var c = _dbContext.SaleCampaigns.Find(id);
            if (c == null)
            {
                return new FailedResult<SaleCampaignVM>("SaleCampaign not found!");
            }

            var vm = _mapper.Map<SaleCampaign, SaleCampaignVM>(c);

            var foodVMs = await (from f in _dbContext.Foods
                                 join fp in _dbContext.SaleCampaignFoods on f.ID equals fp.FoodID
                                 where fp.SaleCampaignID == id
                                 select _mapper.Map<FoodVM>(f)).ToListAsync();
            vm.FoodVMs = foodVMs;

            return new SuccessedResult<SaleCampaignVM>(vm);
        }

        public async Task<ApiResult<SaleCampaignVM>> Create(SaleCampaignCreateVM vm)
        {
            using var transaction = _dbContext.Database.BeginTransaction();


            var result = await _dbContext.SaleCampaigns.AddAsync(_mapper.Map<SaleCampaignCreateVM, SaleCampaign>(vm));
            await _dbContext.SaveChangesAsync();

            List<FoodVM> foodVMs = new List<FoodVM>();
            foreach (var item in vm.FoodIDs)
            {
                var food = await _dbContext.Foods.FindAsync(item);
                if (food == null)
                {
                    transaction.Rollback();
                    return new FailedResult<SaleCampaignVM>("Food not found!");
                }
                var rs = _dbContext.SaleCampaignFoods.Add(new SaleCampaignFood { FoodID = item, SaleCampaignID = result.Entity.ID });
                await _dbContext.SaveChangesAsync();
                foodVMs.Add(_mapper.Map<FoodVM>(food));
            }

            transaction.Commit();

            var saleVM = _mapper.Map<SaleCampaignVM>(result.Entity);
            saleVM.FoodVMs = foodVMs;

            return new SuccessedResult<SaleCampaignVM>(saleVM);

        }

        public async Task<ApiResult<SaleCampaignVM>> Edit(int id, SaleCampaignEditVM editVM)
        {
            using var transaction = _dbContext.Database.BeginTransaction();
            try
            {
                var sale = _dbContext.SaleCampaigns.Find(id);
                if (sale == null)
                {
                    return new FailedResult<SaleCampaignVM>("SaleCampaign not found!");
                }
                sale.Name = editVM.Name;
                sale.Desciption = editVM.Desciption;
                sale.EndDate = editVM.EndDate;
                sale.Enabled = editVM.Enabled;
                sale.StartDate = editVM.StartDate;
                sale.Percent = editVM.Percent;
                sale.Priority = editVM.Priority;

                var pf = _dbContext.SaleCampaignFoods.Where(x => x.SaleCampaignID == editVM.ID).ToList();
                _dbContext.SaleCampaignFoods.RemoveRange(pf);
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
                            return new FailedResult<SaleCampaignVM>("Food not found!");
                        }
                        var rs = _dbContext.SaleCampaignFoods.Add(new SaleCampaignFood { FoodID = item, SaleCampaignID = sale.ID });
                        var writed = await _dbContext.SaveChangesAsync();
                        foodVMs.Add(_mapper.Map<FoodVM>(food));
                    }
                }

                await _dbContext.SaveChangesAsync();
                transaction.Commit();

                var saleVM = _mapper.Map<SaleCampaignVM>(sale);
                saleVM.FoodVMs = foodVMs;

                return new SuccessedResult<SaleCampaignVM>(saleVM);
            }
            catch (Exception e)
            {
                return new FailedResult<SaleCampaignVM>(e.Message.ToString());
            }
        }

        public async Task<ApiResult<bool>> Delete(int id)
        {
            var vm = _dbContext.SaleCampaigns.Find(id);
            using var transaction = _dbContext.Database.BeginTransaction();
            if (vm == null)
            {
                return new FailedResult<bool>("SaleCampaign not found!");
            }
            try
            {
                var pf = _dbContext.SaleCampaignFoods.Where(x => x.SaleCampaignID == id).ToList();
                _dbContext.SaleCampaignFoods.RemoveRange(pf);
                _dbContext.SaveChanges();

                _dbContext.SaleCampaigns.Remove(vm);
                await _dbContext.SaveChangesAsync();
                transaction.Commit();
                return new SuccessedResult<bool>(true);
            }
            catch (Exception e)
            {
                return new FailedResult<bool>(e.InnerException.ToString());
            }
        }
    }
}

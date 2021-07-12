using AutoMapper;
using FoodOrder.Core.Inferstructer;
using FoodOrder.Core.Models;
using FoodOrder.Core.ViewModels.Homes;
using FoodOrder.Data;
using Microsoft.Extensions.Logging;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace FoodOrder.API.Services
{
    public class HomeServices
    {
        private readonly ApplicationDBContext _dbContext;
        private readonly IMapper _mapper;
        private readonly ILogger<HomeServices> _logger;
        private readonly FoodServices _foodServices;
        private readonly PromotionServices _promotionServices;
        private readonly SaleCampaignServices _saleCampaignServices;

        public HomeServices(ApplicationDBContext applicationDBContext, IMapper mapper, ILogger<HomeServices> logger
            , FoodServices foodServices
            , PromotionServices promotionServices
            , SaleCampaignServices saleCampaignServices
            )
        {
            _dbContext = applicationDBContext;
            _mapper = mapper;
            _logger = logger;
            _foodServices = foodServices;
            _promotionServices = promotionServices;
            _saleCampaignServices = saleCampaignServices;
        }

        public async Task<ApiResult<HomeVM>> Get()
        {
            HomeVM homeVM = new HomeVM();
            var salePerDay = getTotalSalePerDay(DateTime.Now.AddDays(-30), 30);
            var salePerMonth = getTotalSalePerMonth(DateTime.Now.AddMonths(-6), 6);

            homeVM.TotalSaleToday = (int)(from o in _dbContext.Orders
                                          where o.IsPaid && o.DatePaid.Value.Date == DateTime.Now.Date
                                          select o.FinalTotalPrice).Sum();
            homeVM.TotalOrderToday = (from o in _dbContext.Orders
                                      where o.CreatedDate.Date == DateTime.Now.Date
                                      select o).Count();
            homeVM.TotalDeliveredToday = (from o in _dbContext.Orders
                                          where o.OrderStatusID == OrderStatus.DaNhan && o.DatePaid.Value.Date == DateTime.Now.Date
                                          select o).Count();
            homeVM.TotalCanceledToday = (from o in _dbContext.Orders
                                         where o.OrderStatusID == OrderStatus.DaHuy && o.DatePaid.Value.Date == DateTime.Now.Date
                                         select o).Count();
            homeVM.ListBestSellingFood = (await _foodServices.GetBestSellingAsync(new Core.ViewModels.PagingRequestBase() { PageNumber = 1, PageSize = -1 })).PayLoad.Items;

            homeVM.ListValidPromotion =(await _promotionServices.GetAllValid(new Core.ViewModels.PagingRequestBase() { PageNumber = 1, PageSize = -1 }, "")).PayLoad.Items;

            homeVM.ListSaleCampaign = (await _saleCampaignServices.GetAllValidPaging(new Core.ViewModels.PagingRequestBase() { PageNumber = 1, PageSize = -1 })).PayLoad.Items;

            if (salePerDay.IsSuccessed == true && salePerMonth.IsSuccessed)
            {
                homeVM.TotalSaleLast30Days = salePerDay.PayLoad;
                homeVM.TotalSaleLast6Months = salePerMonth.PayLoad;
                return new SuccessedResult<HomeVM>(homeVM);
            }

            return new FailedResult<HomeVM>("Some thing went wrong!");
        }

        private ApiResult<List<int>> getTotalSalePerDay(DateTime start, int count)
        {
            List<int> values = new List<int>();
            DateTime date = start;
            for (int i = 0; i < count; i++)
            {
                date = date.AddDays(1);
                var query = from o in _dbContext.Orders
                            where o.IsPaid == true && o.DatePaid.Value.Date == date.Date
                            select o.FinalTotalPrice;
                if (query.Count() > 0)
                {
                    values.Add((int)query.Sum());
                }
                else
                {
                    values.Add(0);
                }
            }
            return new SuccessedResult<List<int>>(values);
        }
        private ApiResult<List<int>> getTotalSalePerMonth(DateTime start, int count)
        {
            List<int> values = new List<int>();
            DateTime date = start;
            for (int i = 0; i < count; i++)
            {
                date = date.AddMonths(1);
                var query = from o in _dbContext.Orders
                            where o.IsPaid == true && o.DatePaid.Value.Year == date.Year && o.DatePaid.Value.Month == date.Month
                            select o.FinalTotalPrice;
                if (query.Count() > 0)
                {
                    values.Add((int)query.Sum());
                }
                else
                {
                    values.Add(0);
                }
            }
            return new SuccessedResult<List<int>>(values);
        }
    }
}

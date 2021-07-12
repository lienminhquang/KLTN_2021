using FoodOrder.Core.ViewModels.Foods;
using FoodOrder.Core.ViewModels.Promotions;
using FoodOrder.Core.ViewModels.SaleCampaigns;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FoodOrder.Core.ViewModels.Homes
{
    public class HomeVM
    {
        public List<int> TotalSaleLast30Days { get; set; }
        public List<int> TotalSaleLast6Months { get; set; }
        public int TotalOrderToday { get; set; }
        public int TotalSaleToday { get; set; }
        public int TotalDeliveredToday { get; set; }
        public int TotalCanceledToday { get; set; }
        public List<FoodVM> ListBestSellingFood { get; set; }
        public List<PromotionVM> ListValidPromotion { get; set; }
        public List<SaleCampaignVM> ListSaleCampaign { get; set; }
    }
}

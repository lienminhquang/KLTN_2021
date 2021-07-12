using FoodOrder.Core.Models;
using FoodOrder.Core.ViewModels.Foods;
using FoodOrder.Core.ViewModels.Orders;
using FoodOrder.Core.ViewModels.Ratings;
using FoodOrder.Core.ViewModels.SaleCampaigns;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FoodOrder.Core.ViewModels.OrderDetails
{
    public class OrderDetailVM
    {
        public int OrderID { get; set; }
        public int FoodID { get; set; }
        public int Amount { get; set; }
        public double Price { get; set; }
        public int? SaleCampaignID { get; set; }
        public float? SalePercent { get; set; }

        public bool IsDeleted { get; set; }
        public DateTime? TimeDeleted { get; set; }

        public SaleCampaignVM SaleCampaign { get; set; }
        public OrderVM OrderVM { get; set; }
        public FoodVM FoodVM { get; set; }
        public RatingVM RatingVM { get; set; }
    }
}

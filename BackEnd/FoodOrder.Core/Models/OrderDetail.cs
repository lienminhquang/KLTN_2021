using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace FoodOrder.Core.Models
{
    public class OrderDetail
    {
        public int OrderID { get; set; }
        public int FoodID { get; set; }
        public int Amount { get; set; }
        public double Price { get; set; } // Price before apply sale
        public int? SaleCampaignID { get; set; }
        public float? SalePercent { get; set; }

        public bool IsDeleted { get; set; }
        public DateTime? TimeDeleted { get; set; }

        public SaleCampaign SaleCampaign { get; set; }
        public Order Order { get; set; }
        public Food Food { get; set; }
    }
}

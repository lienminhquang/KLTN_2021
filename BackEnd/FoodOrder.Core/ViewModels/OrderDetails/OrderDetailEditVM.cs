using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FoodOrder.Core.ViewModels.OrderDetails
{
    public class OrderDetailEditVM
    {
        public int OrderID { get; set; }
        public int FoodID { get; set; }
        public int Amount { get; set; }
        public double Price { get; set; }
        public float? SalePercent { get; set; }
        public int? SaleCampaignID { get; set; }
    }
}

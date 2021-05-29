using FoodOrder.Core.ViewModels.Foods;
using FoodOrder.Core.ViewModels.Orders;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FoodOrder.Core.ViewModels.SaleCampaigns
{
    public class SaleCampaignVM
    {
        public int ID { get; set; }
        public string Name { get; set; }
        public string Desciption { get; set; }
        public DateTime StartDate { get; set; }
        public DateTime EndDate { get; set; }
        public float Percent { get; set; }
        public bool Enabled { get; set; }
        public int Priority { get; set; }

        public List<OrderVM> OrderVMs { get; set; }
        public List<FoodVM> FoodVMs { get; set; }
    }
}

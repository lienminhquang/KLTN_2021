using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FoodOrder.Core.Models
{
    public class SaleCampaign
    {
        public int ID { get; set; }
        public string Name { get; set; }
        public string Desciption { get; set; }
        public DateTime StartDate { get; set; }
        public DateTime EndDate { get; set; }
        public float Percent { get; set; }
        public bool Enabled { get; set; }
        public int Priority { get; set; }

        public List<Order> Orders { get; set; }
        public List<Food> SaleCampaignFoods { get; set; }
    }
}

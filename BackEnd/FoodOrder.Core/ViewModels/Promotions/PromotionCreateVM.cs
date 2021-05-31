using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FoodOrder.Core.ViewModels.Promotions
{
    public class PromotionCreateVM
    {
        public string Name { get; set; }
        public string Code { get; set; }
        public string Desciption { get; set; }
        public DateTime StartDate { get; set; }
        public DateTime EndDate { get; set; }
        public int UseTimes { get; set; }
        public float Percent { get; set; }
        public bool Enabled { get; set; }
        public double Max { get; set; }
        public double MinPrice { get; set; }
        public bool IsGlobal { get; set; }
        public int Priority { get; set; }

    }
}

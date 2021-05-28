using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FoodOrder.Core.ViewModels.Promotions
{
    public class PromotionEditVM
    {
        public int ID { get; set; }
        public string Name { get; set; }
        public string Code { get; set; }
        public string Desciption { get; set; }
        public DateTime StartDate { get; set; }
        public DateTime EndDate { get; set; }
        public int Amount { get; set; }
        public float Percent { get; set; }
        public bool Enabled { get; set; }
        public int Max { get; set; }
        public int MinPrice { get; set; }
        public bool IsGlobal { get; set; }


        public List<int> FoodIDs { get; set; }

    }
}

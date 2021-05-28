using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FoodOrder.Core.Models
{
    public class PromotionFood
    {
        public int FoodID { get; set; }
        public int PromotionID { get; set; }

        public Promotion Promotion { get; set; }
        public Food Food { get; set; }
    }
}

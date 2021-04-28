using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace FoodOrder.Core.Models
{
    public class FoodCategory
    {
        public int FoodID { get; set; }
        public int CategoryID { get; set; }

        public Food Food { get; set; }
        public Category Category { get; set; }
    }
}

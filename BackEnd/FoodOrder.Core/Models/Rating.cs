using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace FoodOrder.Core.Models
{
    public class Rating
    {
        public int OrderID { get; set; }
        public int FoodID { get; set; }
        public int Star { get; set; }
        public string Comment { get; set; }
        public DateTime TimeCreate { get; set; }

        public AppUser AppUser { get; set; }
        public Food Food { get; set; }
        public Order Order { get; set; }
    }
}

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
        public decimal Price { get; set; }

        public Order Order { get; set; }
        public Food Food { get; set; }
    }
}

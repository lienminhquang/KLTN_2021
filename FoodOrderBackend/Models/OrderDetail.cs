using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace FoodOrderBackend.Models
{
    public class OrderDetail
    {
        public int OrderId { get; set; }
        public int FoodId { get; set; }
        public int Amount { get; set; }
        public decimal Price { get; set; }
    }
}

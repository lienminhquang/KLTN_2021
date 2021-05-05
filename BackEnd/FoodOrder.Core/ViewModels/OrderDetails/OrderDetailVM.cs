using FoodOrder.Core.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FoodOrder.Core.ViewModels.OrderDetails
{
    public class OrderDetailVM
    {
        public int OrderID { get; set; }
        public int FoodID { get; set; }
        public int Amount { get; set; }
        public decimal Price { get; set; }

        public Order Order { get; set; }
        public Food Food { get; set; }
    }
}

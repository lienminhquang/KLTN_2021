using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FoodOrder.Core.ViewModels.Carts
{
    public class CartCreateVM
    {
        public Guid AppUserId { get; set; }
        public int FoodID { get; set; }
        public int Quantity { get; set; }
    }
}

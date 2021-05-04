using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FoodOrder.Core.ViewModels.Carts
{
    public class CartEditVM
    {
        // Todo: we need to replace the id with name here
        public Guid AppUserId { get; set; }
        public int FoodID { get; set; }
        public int Quantity { get; set; }
    }
}

using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace FoodOrderBackend.Models
{
    public class Cart
    {
        public Guid AppUserId { get; set; }
        public int FoodID { get; set; }
        public int Quantity { get; set; }

        public AppUser AppUser { get; set; }
        public Food Food { get; set; }
    }
}

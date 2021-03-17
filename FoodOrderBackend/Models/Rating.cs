using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace FoodOrderBackend.Models
{
    public class Rating
    {
        public Guid AppUserID { get; set; }
        public int FoodID { get; set; }
        public int Star { get; set; }
        public string Comment { get; set; }
        public DateTime LastCreatedTime { get; set; }

        public AppUser AppUser { get; set; }
        public Food Food { get; set; }
    }
}

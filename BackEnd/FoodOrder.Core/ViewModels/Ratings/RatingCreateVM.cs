using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FoodOrder.Core.ViewModels.Ratings
{
    public class RatingCreateVM
    {
        public Guid AppUserID { get; set; }
        public int FoodID { get; set; }
        public int Star { get; set; }
        public string Comment { get; set; }
    }
}

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FoodOrder.Core.ViewModels.Ratings
{
    public class RatingEditVM
    {
        public int OrderID { get; set; }
        
        public int FoodID { get; set; }
        public int Star { get; set; }
        public string Comment { get; set; }
    }
}

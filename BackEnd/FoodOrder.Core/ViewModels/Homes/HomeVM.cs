using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FoodOrder.Core.ViewModels.Homes
{
    public class HomeVM
    {
        public List<int> TotalSaleLast30Days { get; set; }
        public List<int> TotalSaleLast6Months { get; set; }
        public int TotalOrderToday { get; set; }
        public int TotalSaleToday { get; set; }
        public int TotalDeliveredToday { get; set; }
        public int TotalCanceledToday { get; set; }
    }
}

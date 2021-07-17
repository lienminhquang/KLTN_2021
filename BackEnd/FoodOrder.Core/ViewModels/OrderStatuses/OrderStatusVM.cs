using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FoodOrder.Core.ViewModels.OrderStatuses
{
    public class OrderStatusVM
    {
        public int ID { get; set; }
        [Display(Name ="Order Status")]
        public string Name { get; set; }
        public string Description { get; set; }

        public string PNTitle { get; set; }
        public string PNBody { get; set; }
    }
}

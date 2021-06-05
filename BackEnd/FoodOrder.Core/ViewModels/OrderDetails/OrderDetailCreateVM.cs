using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FoodOrder.Core.ViewModels.OrderDetails
{
    public class OrderDetailCreateVM
    {
        [Required]
        public int OrderID { get; set; }
        [Required]
        public int FoodID { get; set; }
        [Required]
        public int Amount { get; set; }
        public int? SaleCampaignID { get; set; }
    }
}

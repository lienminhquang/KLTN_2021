using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FoodOrder.Core.ViewModels.Orders
{
    public class OrderCreateVM
    {
        [Required(ErrorMessage = "AppUserID is requied")]
        public Guid AppUserID { get; set; }
      
        public bool IsPaid { get; set; }
        public DateTime? DatePaid { get; set; }
        public int OrderStatusID { get; set; }
        public int? PromotionID { get; set; }
        public decimal? PromotionAmount { get; set; }

        public string AddressString { get; set; }
        public string AddressName { get; set; }

        //public List<int> CartIDs { get; set; }
    }
}

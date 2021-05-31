using FoodOrder.Core.ViewModels.OrderDetails;
using FoodOrder.Core.ViewModels.OrderStatuses;
using FoodOrder.Core.ViewModels.Users;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FoodOrder.Core.ViewModels.Orders
{
    public class OrderVM
    {
        public int ID { get; set; }
        public Guid AppUserID { get; set; }
        public DateTime CreatedDate { get; set; }
        public bool IsPaid { get; set; }
        public DateTime? DatePaid { get; set; }
        public int OrderStatusID { get; set; }
        public int? PromotionID { get; set; }
        public double? PromotionAmount { get; set; }

        public string AddressString { get; set; }
        public string AddressName { get; set; }

        public UserVM UserVM { get; set; }

        public OrderStatusVM OrderStatusVM { get; set; }
        public List<OrderDetailVM> OrderDetailVMs { get; set; }
    }
}

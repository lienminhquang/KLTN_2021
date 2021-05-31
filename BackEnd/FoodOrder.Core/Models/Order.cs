using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace FoodOrder.Core.Models
{
    public class Order
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

        public List<OrderDetail> OrderDetails { get; set; }
        public Promotion Promotion { get; set; }
        public AppUser AppUser { get; set; }
        public OrderStatus OrderStatus { get; set; }
    }
}

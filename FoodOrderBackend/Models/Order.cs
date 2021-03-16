using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace FoodOrderBackend.Models
{
    public class Order
    {
        public Guid UserId { get; set; }
        public int FoodId { get; set; }
        public DateTime CreatedDate { get; set; }
        public int IsPaid { get; set; }
        public DateTime DatePaid { get; set; }
        public int OrderStatusId { get; set; }
        public int PromotionId { get; set; }
    }
}

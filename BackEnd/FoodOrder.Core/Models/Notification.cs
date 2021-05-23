using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FoodOrder.Core.Models
{
    public enum NotificationType
    {
        Message = 0,
        OrderDelivered = 1,
    }

    public class Notification
    {
        public int ID { get; set; }
        public Guid UserID { get; set; }
        public string Title { get; set; }
        public string Message { get; set; }
        public DateTime TimeCreated { get; set; }
        public NotificationType Type { get; set; }
        public bool UserReceived { get; set; }

        public AppUser AppUser { get; set; }
    }
}

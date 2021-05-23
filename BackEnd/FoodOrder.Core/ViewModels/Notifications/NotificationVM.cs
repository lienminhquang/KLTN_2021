using FoodOrder.Core.Models;
using FoodOrder.Core.ViewModels.Users;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FoodOrder.Core.ViewModels.Notifications
{
    public class NotificationVM
    {
        public int ID { get; set; }
        public Guid UserID { get; set; }
        public string Title { get; set; }
        public string Message { get; set; }
        public DateTime TimeCreated { get; set; }
        public NotificationType Type { get; set; }
        public bool UserReceived { get; set; }

        public UserVM AppUser { get; set; }
    }
}

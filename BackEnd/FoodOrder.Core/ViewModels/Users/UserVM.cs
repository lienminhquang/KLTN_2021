using FoodOrder.Core.ViewModels.AppRoles;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FoodOrder.Core.ViewModels.Users
{
    public class UserVM
    {
        [Display(Name = "User ID")]
        public Guid ID { get; set; }
        public string Username { get; set; }
       // public string FirstName { get; set; }
        public string Name { get; set; }
        public DateTime DateOfBirth { get; set; }
        public string Email { get; set; }

        public bool IsDeleted { get; set; }
        public DateTime? TimeDeleted { get; set; }
        public string DeviceToken { get; set; }

        public List<string> AppRoles { get; set; }
    }
}

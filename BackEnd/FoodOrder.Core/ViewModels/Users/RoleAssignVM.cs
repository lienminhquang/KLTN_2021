using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FoodOrder.Core.ViewModels.Users
{
    public class RoleAssignVM
    {
        [Display(Name ="User ID")]
        public String userID { get; set; }
        public List<String> roles { get; set; }
    }
}

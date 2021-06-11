using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FoodOrder.Core.ViewModels.Users
{
    public class ResetPassword
    {
        public string Username { get; set; }
        public string NewPassword { get; set; }
        // Todo: check OTP 
    }
}

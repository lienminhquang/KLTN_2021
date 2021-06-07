using Microsoft.AspNetCore.Authorization;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace FoodOrder.Admin.Identity
{
    public class CustomClaimRequirement : IAuthorizationRequirement
    {
        public string Role { get; set; }
        public CustomClaimRequirement(string role)
        {
            this.Role = role;
        }
    }
}

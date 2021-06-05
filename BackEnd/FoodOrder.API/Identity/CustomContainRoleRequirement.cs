using Microsoft.AspNetCore.Authorization;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace FoodOrder.API.Identity
{
    public class CustomContainRoleRequirement : IAuthorizationRequirement
    {
        public string claim { get; }
        public CustomContainRoleRequirement(string claim)
        {
            this.claim = claim;
        }
    }
}

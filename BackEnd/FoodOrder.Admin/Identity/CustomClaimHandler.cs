using Microsoft.AspNetCore.Authorization;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace FoodOrder.Admin.Identity
{
    public class CustomClaimHandler : AuthorizationHandler<CustomClaimRequirement>
    {
        protected override Task HandleRequirementAsync(AuthorizationHandlerContext context, CustomClaimRequirement requirement)
        {
            return Task.CompletedTask;
        }
    }
}

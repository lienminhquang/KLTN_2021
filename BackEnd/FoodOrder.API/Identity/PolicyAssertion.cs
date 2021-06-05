using Microsoft.AspNetCore.Authorization;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Claims;
using System.Threading.Tasks;

namespace FoodOrder.API.Identity
{
    public class PolicyAssertion
    {
       public  static bool RolesContainAnyOf( AuthorizationHandlerContext context, List<string> role)
        {

            if (!context.User.HasClaim(c => c.Type == ClaimTypes.Role))
            {
                return false;
            }

            var claimsString = context.User.FindFirst(c => c.Type == ClaimTypes.Role).Value;
            var claims = claimsString.Split(';');
            var intersect = role.Intersect(claims);
            if (intersect.Count() > 0)
            {
                return true;
            }
            return false;
        }
    }
}

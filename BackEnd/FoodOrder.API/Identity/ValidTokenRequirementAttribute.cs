using FoodOrder.Core.Models;
using FoodOrder.Data;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Filters;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Claims;
using System.Threading.Tasks;

namespace FoodOrder.API.Identity
{

    public class ValidTokenRequirementAttribute : TypeFilterAttribute
    {
        public ValidTokenRequirementAttribute() : base(typeof(ValidTokenRequirementFilter))
        {

        }
    }

    public class ValidTokenRequirementFilter : IAuthorizationFilter
    {
        
        private readonly ApplicationDBContext _applicationDBContext;

        public ValidTokenRequirementFilter( ApplicationDBContext applicationDBContext)
        { 
            _applicationDBContext = applicationDBContext;
        }

        public void OnAuthorization(AuthorizationFilterContext context)
        {
            var hasClaim = context.HttpContext.User.Claims.Any(c => c.Type == "TimeCreateJWT");
            if (!hasClaim)
            {
                context.Result = new UnauthorizedResult();
                return;
            }

            var timeCreateJWT = context.HttpContext.User.FindFirst("TimeCreateJWT").Value;
            var user = _applicationDBContext.AppUsers.Where(
                a => a.UserName == context.HttpContext.User.FindFirstValue(ClaimTypes.Name)
                ).FirstOrDefault();

            //var user = await _userManager.FindByNameAsync(context.HttpContext.User.FindFirstValue(ClaimTypes.Name));
            if (user.TimeCreateJWT.ToString() != timeCreateJWT)
            {
                context.Result = new UnauthorizedResult();
                return;
            }


        }
    }
}

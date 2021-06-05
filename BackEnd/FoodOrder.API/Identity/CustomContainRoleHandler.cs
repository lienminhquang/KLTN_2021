using Microsoft.AspNetCore.Authorization;
using Microsoft.Extensions.Configuration;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Claims;
using System.Threading.Tasks;

namespace FoodOrder.API.Identity
{
    public class CustomContainRoleHandler : AuthorizationHandler<CustomContainRoleRequirement>
    {
        private readonly IConfiguration _config;

        public CustomContainRoleHandler(IConfiguration configuration)
        {
            _config = configuration;
        }
        protected override Task HandleRequirementAsync(AuthorizationHandlerContext context, CustomContainRoleRequirement requirement)
        {
            
            if (!context.User.HasClaim(c => c.Type == ClaimTypes.Role && c.Issuer == _config["Tokens:Issuer"]))
            {
                return Task.CompletedTask;
            }

            var claimsString = context.User.FindFirst(c => c.Type == ClaimTypes.Role && c.Issuer == _config["Tokens:Issuer"]).Value;
            var claims = claimsString.Split(';');
            if (claims.Contains(requirement.claim))
            {
                context.Succeed(requirement);
            }
            return Task.CompletedTask;
        }
    }
}

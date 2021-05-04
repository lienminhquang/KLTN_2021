using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace FoodOrder.Admin.Extensions
{
    public static class ControllerValidateJWTTokenInCookieExtention
    {
        public static bool ValidateTokenInCookie(this Controller controller)
        {
            string token;
            return controller.HttpContext.Request.Cookies.TryGetValue("Token", out token);
        }
    }
}

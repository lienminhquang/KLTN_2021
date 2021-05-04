using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace FoodOrder.Admin.Extensions
{
    public static class ControllerExtentions
    {
        public static string GetTokenFromCookie(this Controller controller)
        {
            string token = "";
            controller.HttpContext.Request.Cookies.TryGetValue("Token", out token);
            return token;
        }
    }

    
}

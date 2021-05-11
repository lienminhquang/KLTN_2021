using FoodOrder.Admin.Configs;
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

        public static ActionResult RedirectToLoginPage(this Controller controller, string returnUrl=null)
        {
            if(returnUrl != null)
            {
                return controller.RedirectToAction("Login", "User", new { returnUrl = returnUrl });
            }
            return controller.RedirectToAction("Login", "User");
        }

        public static ActionResult RedirectToErrorPage(this Controller controller, string errorMessage)
        {
            controller.TempData[AppConfigs.ErrorMessageString] = errorMessage;
            return controller.RedirectToAction("Error", "Home");
        }
    }

    
}

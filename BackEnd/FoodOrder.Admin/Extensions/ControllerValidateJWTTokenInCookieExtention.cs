using FoodOrder.Admin.Services;
using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Authentication.Cookies;
using Microsoft.AspNetCore.Mvc;
using Microsoft.IdentityModel.Logging;
using Microsoft.IdentityModel.Tokens;
using System;
using System.Collections.Generic;
using System.IdentityModel.Tokens.Jwt;
using System.Linq;
using System.Security.Claims;
using System.Text;
using System.Threading.Tasks;

namespace FoodOrder.Admin.Extensions
{
    public static class ControllerValidateJWTTokenInCookieExtention
    {
        private static ClaimsPrincipal ValidateToken(string jwt)
        {
            IdentityModelEventSource.ShowPII = true;

            SecurityToken validatedToken;
            TokenValidationParameters validationParameters = new TokenValidationParameters();

            validationParameters.ValidateLifetime = true;
            validationParameters.ValidIssuer = "https://localhost:6001";
            validationParameters.ValidAudience = "https://localhost:6001";
            validationParameters.IssuerSigningKey = new SymmetricSecurityKey(Encoding.UTF8.GetBytes("123456?aaaaaaaaaaaa"));
            ClaimsPrincipal principal = new JwtSecurityTokenHandler().ValidateToken(jwt, validationParameters, out validatedToken);

            return principal;
        }

        public static async Task<bool> ValidateTokenInCookie(this Controller controller, AdminUserService userService)
        {
            string token;
            controller.HttpContext.Request.Cookies.TryGetValue("Token", out token);
            string refreshToken;
            controller.HttpContext.Request.Cookies.TryGetValue("RefreshToken", out refreshToken);

            var handler = new JwtSecurityTokenHandler();
            string authHeader = token;
            authHeader = authHeader.Replace("Bearer ", "");
            var jsonToken = handler.ReadToken(authHeader);
            var tokenS = handler.ReadToken(authHeader) as JwtSecurityToken;

            if (!(tokenS.ValidTo <= DateTime.UtcNow))
            {
                var loginResponse = await userService.RefreshToken(authHeader, refreshToken);
                if (loginResponse.IsSuccessed)
                {
                    var userPrincipal = ValidateToken(loginResponse.PayLoad.AccessToken);
                    var authProperties = new AuthenticationProperties()
                    {
                        ExpiresUtc = DateTime.MaxValue,
                        IsPersistent = true
                    };

                    await controller.HttpContext.SignInAsync(
                        CookieAuthenticationDefaults.AuthenticationScheme,
                        userPrincipal,
                        authProperties
                        );
                    //HttpContext.Session.Set("Token", Encoding.UTF8.GetBytes(token.PayLoad));
                    controller.HttpContext.Response.Cookies.Delete("Token");
                    controller.HttpContext.Response.Cookies.Delete("RefreshToken");
                    controller.HttpContext.Response.Cookies.Append("Token", loginResponse.PayLoad.AccessToken, new Microsoft.AspNetCore.Http.CookieOptions()
                    {
                        Expires = DateTime.MaxValue
                    });
                    controller.HttpContext.Response.Cookies.Append("RefreshToken", loginResponse.PayLoad.RefreshToken, new Microsoft.AspNetCore.Http.CookieOptions()
                    {
                        Expires = loginResponse.PayLoad.RefreshTokenExpire
                    });


                    controller.HttpContext.Items["Token"] = loginResponse.PayLoad.AccessToken;
                    controller.HttpContext.Items["RefreshToken"] = loginResponse.PayLoad.RefreshToken;
                    return true;
                }
                else
                {
                    return false;
                }
            }

            controller.HttpContext.Items["Token"] = authHeader;
            controller.HttpContext.Items["RefreshToken"] = refreshToken;
            return true;
        }
    }
}

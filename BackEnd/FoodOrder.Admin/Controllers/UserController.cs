using FoodOrder.Admin.Services;
using FoodOrder.Core.ViewModels;
using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Authentication.Cookies;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;
using Microsoft.IdentityModel.Logging;
using Microsoft.IdentityModel.Tokens;
using System;
using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Text;
using System.Threading.Tasks;

namespace FoodOrder.Admin.Controllers
{
    public class UserController : Controller
    {
        private readonly AdminUserService _adminUserService;
        private readonly IConfiguration _config;

        public UserController(AdminUserService adminUserService, IConfiguration configuration)
        {
            _adminUserService = adminUserService;
            _config = configuration;
        }

        public async Task<IActionResult> IndexAsync([FromQuery] PagingRequestBase request)
        {
            byte[] tokenByte;
            string token="";
            if (HttpContext.Session.TryGetValue("Token", out tokenByte))
            {
                token = Encoding.UTF8.GetString(tokenByte);
            }

            var users = await _adminUserService.GetUserPaging(request, token);

            return View(users);
        }

        [HttpPost]
        public IActionResult Logout()
        {
            //await HttpContext.SignOutAsync(CookieAuthenticationDefaults.AuthenticationScheme);
            return RedirectToAction("Login", "User");
        }

        [HttpGet]
        public async Task<IActionResult> Login()
        {
            await HttpContext.SignOutAsync(CookieAuthenticationDefaults.AuthenticationScheme);

            return View();
        }

        [HttpPost]
        public async Task<IActionResult> Login(LoginRequest loginRequest)
        {
            if(!ModelState.IsValid)
            {
                return View(ModelState.IsValid);
            }

            var token = await _adminUserService.Authenticate(loginRequest);

            var userPrincipal = this.ValidateToken(token);
            var authProperties = new AuthenticationProperties()
            {
                ExpiresUtc = DateTimeOffset.UtcNow.AddMinutes(10),
                IsPersistent = true
            };

            await HttpContext.SignInAsync(
                CookieAuthenticationDefaults.AuthenticationScheme,
                userPrincipal,
                authProperties
                );
            HttpContext.Session.Set("Token", Encoding.UTF8.GetBytes(token));

            return RedirectToAction("Index", "Home");
        }

        private ClaimsPrincipal ValidateToken(string jwt)
        {
            IdentityModelEventSource.ShowPII = true;

            SecurityToken validatedToken;
            TokenValidationParameters validationParameters = new TokenValidationParameters();
            validationParameters.ValidateLifetime = true;
            validationParameters.ValidIssuer = _config["Tokens:Issuer"];
            validationParameters.ValidAudience = _config["Tokens:Issuer"];
            validationParameters.IssuerSigningKey = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(_config["Tokens:Key"]));
            ClaimsPrincipal principal = new JwtSecurityTokenHandler().ValidateToken(jwt, validationParameters,out validatedToken);

            return principal;
        }

        
    }
}

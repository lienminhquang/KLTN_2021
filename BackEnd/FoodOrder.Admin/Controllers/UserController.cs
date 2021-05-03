using FoodOrder.Admin.Services;
using FoodOrder.Core.ViewModels;
using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Authentication.Cookies;
using Microsoft.AspNetCore.Authorization;
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
    [Authorize]
    public class UserController : Controller
    {
        private readonly AdminUserService _adminUserService;
        private readonly IConfiguration _config;

        public bool ValidateTokenInCookie()
        {
            string token;
            return HttpContext.Request.Cookies.TryGetValue("Token", out token);
        }

        public UserController(AdminUserService adminUserService, IConfiguration configuration)
        {
            _adminUserService = adminUserService;
            _config = configuration;
        }

        [HttpGet]
        public async Task<IActionResult> IndexAsync([FromQuery] PagingRequestBase request)
        {
            if (!ValidateTokenInCookie())
            {
                return RedirectToAction("Login", "User");
            }

            var users = await _adminUserService.GetUserPaging(request, GetToken());

            if (!users.IsSuccessed)
            {
                return View(users.ErrorMessage);
            }

            return View(users.PayLoad);
        }

        [HttpGet]
        public IActionResult Create()
        {
            if (!ValidateTokenInCookie())
            {
                return RedirectToAction("Login", "User");
            }

            return View();
        }

        [HttpPost]
        public async Task<IActionResult> Create([FromForm] RegisterRequest request)
        {
            if (!ValidateTokenInCookie())
            {
                return RedirectToAction("Login", "User");
            }

            if (!ModelState.IsValid)
            {
                // Todo: catch error ?? can we return apiresult as model and check success in view ?
                return View(ModelState);
            }

            var rs = await _adminUserService.CreateUser(request, GetToken());
            if (rs.IsSuccessed)
            {
                return RedirectToAction("Index", "User");
            }

            // Todo: catch error ??
            return View(rs.ErrorMessage);
        }

        [HttpPost]
        public async Task<IActionResult> Edit([FromForm] UserUpdateRequest request)
        {
            if (!ValidateTokenInCookie())
            {
                return RedirectToAction("Login", "User");
            }

            if (!ModelState.IsValid)
            {
                // Todo: catch error ?? can we return apiresult as model and check success in view ?
                return View(ModelState);
            }

            var rs = await _adminUserService.EditUser(request, GetToken());
            if (rs.IsSuccessed)
            {
                return View(rs.PayLoad);
            }

            // Todo: catch error ??
            return View(rs.ErrorMessage);
        }

        [HttpGet]
        public async Task<IActionResult> Edit(string id)
        {
            if (!ValidateTokenInCookie())
            {
                return RedirectToAction("Login", "User");
            }

            var result = await _adminUserService.GetUserByID(id, GetToken());
            if(!result.IsSuccessed)
            {
                return View(result.ErrorMessage);
            }

            UserVM userVM = result.PayLoad;

            return View(new UserUpdateRequest()
            {
                Dob = userVM.DateOfBirth,
                Email = userVM.Email,
                FirstName = userVM.FirstName,
                LastName = userVM.LastName,
                UserID = userVM.ID
            });
        }

        [HttpPost]
        public IActionResult Logout()
        {
            //await HttpContext.SignOutAsync(CookieAuthenticationDefaults.AuthenticationScheme);
            return RedirectToAction("Login", "User");
        }

        [HttpGet]
        [AllowAnonymous]
        public async Task<IActionResult> Login()
        {
            await HttpContext.SignOutAsync(CookieAuthenticationDefaults.AuthenticationScheme);
           
            return View();
        }

        [HttpPost]
        [AllowAnonymous]
        public async Task<IActionResult> Login(LoginRequest loginRequest)
        {
            if(!ModelState.IsValid)
            {
                return View(ModelState.IsValid);
            }

            var token = await _adminUserService.Authenticate(loginRequest);

            if(!token.IsSuccessed)
            {
                return View(token.ErrorMessage);
            }

            var userPrincipal = this.ValidateToken(token.PayLoad);
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
            //HttpContext.Session.Set("Token", Encoding.UTF8.GetBytes(token.PayLoad));

            HttpContext.Response.Cookies.Append("Token", token.PayLoad, new Microsoft.AspNetCore.Http.CookieOptions()
            {
                Expires = DateTime.Now.AddMinutes(10)
            });

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

        private string GetToken()
        {
            string token = "";
            HttpContext.Request.Cookies.TryGetValue("Token", out token);
            return token;
        }
    }
}

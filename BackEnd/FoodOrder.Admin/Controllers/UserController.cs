using FoodOrder.Admin.Extensions;
using FoodOrder.Admin.Services;
using FoodOrder.Core.ViewModels;
using FoodOrder.Core.ViewModels.Users;
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

        public UserController(AdminUserService adminUserService, IConfiguration configuration)
        {
            _adminUserService = adminUserService;
            _config = configuration;
        }

        [HttpGet]
        public async Task<IActionResult> IndexAsync([FromQuery] PagingRequestBase request)
        {
            if (!this.ValidateTokenInCookie())
            {
                return RedirectToAction("Login", "User");
            }

            var users = await _adminUserService.GetUserPaging(request, this.GetTokenFromCookie());

            if (!users.IsSuccessed)
            {
                return View(users.ErrorMessage);
            }

            return View(users.PayLoad);
        }

        [HttpGet]
        public IActionResult Create()
        {
            if (!this.ValidateTokenInCookie())
            {
                return RedirectToAction("Login", "User");
            }

            return View();
        }

        [HttpPost]
        public async Task<IActionResult> Create([FromForm] RegisterRequest request)
        {
            if (!this.ValidateTokenInCookie())
            {
                return RedirectToAction("Login", "User");
            }

            if (!ModelState.IsValid)
            {
                // Todo: catch error ?? can we return apiresult as model and check success in view ?
                return View(ModelState);
            }

            var rs = await _adminUserService.CreateUser(request, this.GetTokenFromCookie());
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
            if (!this.ValidateTokenInCookie())
            {
                return RedirectToAction("Login", "User");
            }

            if (!ModelState.IsValid)
            {
                // Todo: catch error ?? can we return apiresult as model and check success in view ?
                return View(ModelState);
            }

            var rs = await _adminUserService.EditUser(request, this.GetTokenFromCookie());
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
            if (!this.ValidateTokenInCookie())
            {
                return RedirectToAction("Login", "User");
            }

            var result = await _adminUserService.GetUserByID(id, this.GetTokenFromCookie());
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

        [HttpPost]
        public async Task<IActionResult> Delete(string id, [FromBody] UserDeleteVM userDeleteVM)
        {
            if (!this.ValidateTokenInCookie())
            {
                return RedirectToAction("Login", "User");
            }

            var result = await _adminUserService.DeleteUser(id, this.GetTokenFromCookie());
            if (!result.IsSuccessed)
            {
                return View(result.ErrorMessage);
            }

            return RedirectToAction("Index", "User");
        }

        [HttpGet]
        [AllowAnonymous]
        public async Task<IActionResult> Delete(string id)
        {
            if (!this.ValidateTokenInCookie())
            {
                return RedirectToAction("Login", "User");
            }
            var result = await _adminUserService.GetUserByID(id, this.GetTokenFromCookie());
            if (!result.IsSuccessed)
            {
                return View(result.ErrorMessage);
            }

            var userDeleteVM = new UserDeleteVM()
            {
                Dob = /*new DateTime(),//*/ result.PayLoad.DateOfBirth,
                Email= /*"test@gmail.com", //*/ result.PayLoad.Email,
                UserID = /*new Guid(), //*/result.PayLoad.ID,
                FirstName = /*"test", //*/result.PayLoad.FirstName,
                LastName = /*"test", //*/result.PayLoad.LastName
            };
            return View(userDeleteVM);
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

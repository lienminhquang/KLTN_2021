using FoodOrder.Admin.Configs;
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
using System.Linq;
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
        private readonly OrderServices _orderServices;
        private readonly CartServices _cartServices;
        private readonly AddressServices _addressServices;
        private readonly AppRoleServices _roleServices;

        public UserController(AdminUserService adminUserService, IConfiguration configuration, OrderServices orderServices, CartServices cartServices, AddressServices addressServices, AppRoleServices appRoleServices)
        {
            _adminUserService = adminUserService;
            _config = configuration;
            _orderServices = orderServices;
            _cartServices = cartServices;
            _addressServices = addressServices;
            _roleServices = appRoleServices;
        }

        [HttpGet]
        public async Task<IActionResult> Index([FromQuery] PagingRequestBase request)
        {
            if (!this.ValidateTokenInCookie())
            {
                return RedirectToAction("Login", "User");
            }

            var users = await _adminUserService.GetUserPaging(request, this.GetTokenFromCookie());

            if (!users.IsSuccessed)
            {
                return this.RedirectToErrorPage(users.ErrorMessage);
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
                return View(request);
            }

            var rs = await _adminUserService.CreateUser(request, this.GetTokenFromCookie());
            if (rs.IsSuccessed)
            {
                TempData[AppConfigs.SuccessMessageString] = "User create succesed!";
                return RedirectToAction("Index", "User");
            }

            TempData[AppConfigs.ErrorMessageString] = rs.ErrorMessage;
            return View(request);
        }

        // GET: CartsController/Details/5
        [HttpGet]
        public async Task<ActionResult> DetailsAsync(string id)
        {
            if (!this.ValidateTokenInCookie())
            {
                return RedirectToAction("Login", "User");
            }
            var user = await _adminUserService.GetUserByID(id, this.GetTokenFromCookie());

            if (!user.IsSuccessed)
            {
                return this.RedirectToErrorPage(user.ErrorMessage);
            }

            var orders = await _orderServices.GetByUserID(new Guid(id), new PagingRequestBase(), this.GetTokenFromCookie());
            if (orders.IsSuccessed == false)
            {
                TempData[AppConfigs.ErrorMessageString] = orders.ErrorMessage;
            }
            ViewBag.OrderVMs = orders.PayLoad;

            var cartVMs = await _cartServices.GetByUserID(id, this.GetTokenFromCookie());
            if (cartVMs.IsSuccessed == false)
            {
                TempData[AppConfigs.ErrorMessageString] = cartVMs.ErrorMessage;
            }
            ViewBag.CartVMs = cartVMs.PayLoad;

            var addresses = await _addressServices.GetByUserID(id, new PagingRequestBase(), this.GetTokenFromCookie());
            if (addresses.IsSuccessed == false)
            {
                TempData[AppConfigs.ErrorMessageString] = addresses.ErrorMessage;
            }
            ViewBag.AddressVMs = addresses.PayLoad;

            return View(user.PayLoad);
        }

        [HttpGet()]
        public async Task<IActionResult> AssignRoleToUser([FromRoute] string id)
        {
            if (!this.ValidateTokenInCookie())
            {
                return RedirectToAction("Login", "User");
            }


            var rs = await _adminUserService.GetRolesOfUser(id, this.GetTokenFromCookie());
            if (rs.IsSuccessed)
            {
                var roles = await _roleServices.GetAllPaging(new PagingRequestBase(), this.GetTokenFromCookie());
                ViewBag.Roles = roles.PayLoad.Items;
                RoleAssignVM roleAssignVM = new RoleAssignVM()
                {
                    roles = rs.PayLoad,
                    userID = id
                };

                return View(roleAssignVM);
            }

            TempData[AppConfigs.ErrorMessageString] = rs.ErrorMessage;
            return View();
        }
        [HttpPost()]
        public async Task<IActionResult> AssignRoleToUser([FromRoute] string id, [FromForm] RoleAssignVM roleAssignVM)
        {
            if (!this.ValidateTokenInCookie())
            {
                return RedirectToAction("Login", "User");
            }


            var rs = await _adminUserService.AssignRoleToUser(roleAssignVM.roles, roleAssignVM.userID, this.GetTokenFromCookie());
            if (rs.IsSuccessed)
            {
                
                TempData[AppConfigs.SuccessMessageString] = "Role assigned!";
               
            }
            var roles = await _roleServices.GetAllPaging(new PagingRequestBase(), this.GetTokenFromCookie());
            ViewBag.Roles = roles.PayLoad.Items;

            TempData[AppConfigs.ErrorMessageString] = rs.ErrorMessage;
            return View(roleAssignVM);
        }

        [HttpPost]
        public async Task<IActionResult> Edit([FromForm] UserUpdateRequest request)
        {
            if (!this.ValidateTokenInCookie())
            {
                return this.RedirectToLoginPage();
            }

            if (!ModelState.IsValid)
            {
                return View(request);
            }

            var rs = await _adminUserService.EditUser(request, this.GetTokenFromCookie());
            if (rs.IsSuccessed)
            {
                return RedirectToAction("Details", new { id = rs.PayLoad.UserID });
            }

            TempData[AppConfigs.ErrorMessageString] = rs.ErrorMessage;
            return View(request);
        }

        [HttpGet]
        public async Task<IActionResult> Edit(string id)
        {
            if (!this.ValidateTokenInCookie())
            {
                return this.RedirectToLoginPage();
            }

            var result = await _adminUserService.GetUserByID(id, this.GetTokenFromCookie());
            if (!result.IsSuccessed)
            {
                return this.RedirectToErrorPage(result.ErrorMessage);
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
        
        public async Task<IActionResult> Login([FromQuery] string returnUrl)
        {
            await HttpContext.SignOutAsync(CookieAuthenticationDefaults.AuthenticationScheme);

            return View(new LoginRequest() { });
        }

        [HttpPost]
        
        public async Task<IActionResult> Login(LoginRequest loginRequest)
        {
            if (!ModelState.IsValid)
            {
                return View(loginRequest);
            }

            var token = await _adminUserService.Authenticate(loginRequest);

            if (!token.IsSuccessed)
            {
                TempData[AppConfigs.ErrorMessageString] = token.ErrorMessage;
                return View(loginRequest);
            }

            var userPrincipal = this.ValidateToken(token.PayLoad);
            var authProperties = new AuthenticationProperties()
            {
                ExpiresUtc = DateTimeOffset.UtcNow.AddHours(1),
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
                Expires = DateTime.Now.AddHours(1)
            });

            //if (!String.IsNullOrEmpty(loginRequest.ReturnUrl))
            //{
            //    return Redirect(loginRequest.ReturnUrl);
            //}
            return RedirectToAction("Index", "Home");
        }

        [HttpPost]
        public async Task<IActionResult> Delete(string id, [FromForm] UserDeleteVM userDeleteVM)
        {
            if (!this.ValidateTokenInCookie())
            {
                return this.RedirectToLoginPage();
            }

            var result = await _adminUserService.DeleteUser(id, this.GetTokenFromCookie());
            if (!result.IsSuccessed)
            {
                this.RedirectToErrorPage(result.ErrorMessage);
            }

            TempData[AppConfigs.SuccessMessageString] = "User delete succesed!";
            return RedirectToAction("Index", "User");
        }

        [HttpGet]
        public async Task<IActionResult> Delete(string id)
        {
            if (!this.ValidateTokenInCookie())
            {
                return this.RedirectToLoginPage();
            }
            var result = await _adminUserService.GetUserByID(id, this.GetTokenFromCookie());
            if (!result.IsSuccessed)
            {
                return this.RedirectToErrorPage(result.ErrorMessage);
            }

            var userDeleteVM = new UserDeleteVM()
            {
                Dob = /*new DateTime(),//*/ result.PayLoad.DateOfBirth,
                Email = /*"test@gmail.com", //*/ result.PayLoad.Email,
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
            ClaimsPrincipal principal = new JwtSecurityTokenHandler().ValidateToken(jwt, validationParameters, out validatedToken);

            return principal;
        }
    }
}

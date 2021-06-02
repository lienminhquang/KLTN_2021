using FoodOrder.Core.Helpers;
using FoodOrder.Core.Inferstructer;
using FoodOrder.Core.Models;
using FoodOrder.Core.ViewModels;
using FoodOrder.Core.ViewModels.Users;
using FoodOrder.Data;
using Microsoft.AspNetCore.Identity;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.Logging;
using Microsoft.IdentityModel.Tokens;
using System;
using System.Collections.Generic;
using System.IdentityModel.Tokens.Jwt;
using System.Linq;
using System.Security.Claims;
using System.Text;
using System.Threading.Tasks;

namespace FoodOrder.API.Services
{
    public class UserServices
    {
        private readonly UserManager<AppUser> _userManager;
        private readonly SignInManager<AppUser> _signInManager;
        private readonly RoleManager<AppRole> _roleManager;
        private readonly IConfiguration _config;
        private readonly ApplicationDBContext _dbContext;
        private readonly ILogger<UserServices> _logger;

        public UserServices(UserManager<AppUser> userManager
            , SignInManager<AppUser> signInManager
            , RoleManager<AppRole> roleManager
            , IConfiguration configuration
            , ApplicationDBContext applicationDBContext
            , ILogger<UserServices> logger)
        {
            _userManager = userManager;
            _signInManager = signInManager;
            _roleManager = roleManager;
            _config = configuration;
            _dbContext = applicationDBContext;
            _logger = logger;
        }

        public async Task<ApiResult<string>> Authenticate(LoginRequest loginRequest)
        {
            var user = await _userManager.FindByNameAsync(loginRequest.Username);
            if(user == null)
            {
                return new FailedResult<string>("Username or password is incorrect!");
            }

            var signinResult = await _signInManager.PasswordSignInAsync(user, loginRequest.Password, loginRequest.RememberMe, true);
            if(!signinResult.Succeeded)
            {
                return new FailedResult<string>("Username or password is incorrect!");
            }
            var roles = await _userManager.GetRolesAsync(user);
            var claims = new[]
            {
                new Claim("UserID", user.Id.ToString()),
                new Claim(ClaimTypes.Email, user.Email),
                new Claim(ClaimTypes.Name, user.UserName),
                new Claim(ClaimTypes.GivenName, user.FirstName),
                new Claim(ClaimTypes.Role, string.Join(";", roles))
            };

            var key = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(_config["Tokens:Key"]));
            var creds = new SigningCredentials(key, SecurityAlgorithms.HmacSha256);

            var token = new JwtSecurityToken(_config["Tokens:Issuer"],
                    _config["Tokens:Issuer"],
                    claims,
                    expires: DateTime.Now.AddHours(1),
                    signingCredentials: creds
                );

            string tokenString = new JwtSecurityTokenHandler().WriteToken(token);

            return new SuccessedResult<string>(tokenString);
        }

        //public async Task<ApiResult<UserVM>> GetUserInfo()

        public async Task<ApiResult<bool>> Register(RegisterRequest registerRequest)
        {
            var user = new AppUser()
            {
                DateOfBirth = registerRequest.Dob,
                Email = registerRequest.Email,
                FirstName = registerRequest.FirstName,
                LastName = registerRequest.LastName,
                UserName = registerRequest.Username,
            };

            var rs = await _userManager.CreateAsync(user, registerRequest.Password);

            if (!rs.Succeeded)
            {
                String error = "";
                foreach (var item in rs.Errors)
                {
                    error += item.Description + "\n";
                }
                return new FailedResult<bool>(error);
            }

            return new SuccessedResult<bool>(true);
        }

        public async Task<ApiResult<UserUpdateRequest>> EditUser(string id, UserUpdateRequest request)
        {
            AppUser user = await _userManager.FindByIdAsync(id);
            if(user == null)
            {
                return new FailedResult<UserUpdateRequest>("User not found!");
            }
            user.FirstName = request.FirstName;
            user.LastName = request.LastName;
            user.Email = request.Email;
            user.DateOfBirth = request.Dob;
            IdentityResult rs = await _userManager.UpdateAsync(user);

            if(!rs.Succeeded)
            {
                String error = "";
                foreach (var item in rs.Errors)
                {
                    error += item.Description + "\n";
                }
                return new FailedResult<UserUpdateRequest>(error);
            }

            return new SuccessedResult<UserUpdateRequest>(request);
        }

        public async Task<ApiResult<PaginatedList<UserVM>>> GetAllPaging(PagingRequestBase request)
        {
            var users = from c in _dbContext.AppUsers select new UserVM() { 
                Username = c.UserName,
                FirstName = c.FirstName,
                LastName = c.LastName,
                DateOfBirth = c.DateOfBirth,
                
                Email = c.Email,
                ID = c.Id
            };

            if (!String.IsNullOrEmpty(request.SearchString))
            {
                users = users.Where(c => c.Username.Contains(request.SearchString)
                || c.FirstName.Contains(request.SearchString)
                || c.LastName.Contains(request.SearchString)
                || c.Email.Contains(request.SearchString));
            }

            users = Core.Helpers.Utilities<UserVM>.Sort(users, request.SortOrder, "Username");

            var created = await PaginatedList<UserVM>.CreateAsync(users, request.PageNumber ?? 1, Core.Helpers.Configs.PageSize);

            return new SuccessedResult<PaginatedList<UserVM>>(created);
        }

        public async Task<ApiResult<UserVM>> GetUserByID(string id)
        {
            var user = await _userManager.FindByIdAsync(id);
            if(user == null)
            {
                return new FailedResult<UserVM>("User not found!");
            }
            return new SuccessedResult<UserVM>(new UserVM()
            {
                ID = user.Id,
                Username = user.UserName,
                DateOfBirth = user.DateOfBirth,
                Email = user.Email,
                FirstName = user.FirstName,
                LastName = user.LastName
            });
        }

        public async Task<ApiResult<bool>> DeleteUser(string id)
        {
            var user = await _userManager.FindByIdAsync(id);
            if (user == null)
            {
                return new FailedResult<bool>("User not found!");
            }

            var result = await _userManager.DeleteAsync(user);
            if (!result.Succeeded)
            {
                String error = "";
                foreach (var item in result.Errors)
                {
                    error += item.Description + "\n";
                }
                return new FailedResult<bool>(error);
            }

            return new SuccessedResult<bool>(true);
        }
    }
}

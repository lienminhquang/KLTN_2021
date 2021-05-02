using FoodOrder.Core.Helpers;
using FoodOrder.Core.Models;
using FoodOrder.Core.ViewModels;
using FoodOrder.Data;
using Microsoft.AspNetCore.Identity;
using Microsoft.Extensions.Configuration;
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

        public UserServices(UserManager<AppUser> userManager
            , SignInManager<AppUser> signInManager
            , RoleManager<AppRole> roleManager
            , IConfiguration configuration
            , ApplicationDBContext applicationDBContext)
        {
            _userManager = userManager;
            _signInManager = signInManager;
            _roleManager = roleManager;
            _config = configuration;
            _dbContext = applicationDBContext;
        }

        public async Task<string> Authenticate(LoginRequest loginRequest)
        {
            var user = await _userManager.FindByNameAsync(loginRequest.Username);
            if(user == null)
            {
                return null;
            }

            var signinResult = await _signInManager.PasswordSignInAsync(user, loginRequest.Password, loginRequest.RememberMe, true);
            if(!signinResult.Succeeded)
            {
                return null;
            }
            var roles = await _userManager.GetRolesAsync(user);
            var claims = new[]
            {
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

            return new JwtSecurityTokenHandler().WriteToken(token);
        }

        public async Task<bool> Register(RegisterRequest registerRequest)
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
            return rs.Succeeded;
        }

        public async Task<PaginatedList<UserVM>> GetUserPaging(PagingRequestBase request)
        {
            var users = from c in _dbContext.AppUsers select new UserVM() { 
                Username = c.UserName,
                FirstName = c.FirstName,
                LastName = c.LastName,
                DateOfBirth = c.DateOfBirth,
                Address = c.Address,
                Email = c.Email
            };
            if (!String.IsNullOrEmpty(request.SearchString))
            {
                request.PageNumber = 1;
            }
            else
            {
                request.SearchString = request.CurrentFilter;
            }

            if (!String.IsNullOrEmpty(request.SearchString))
            {
                users = users.Where(c => c.Username.Contains(request.SearchString)
                || c.FirstName.Contains(request.SearchString)
                || c.LastName.Contains(request.SearchString)
                || c.Email.Contains(request.SearchString));
            }

            users = Core.Helpers.Utilities<UserVM>.Sort(users, request.SortOrder, "Username");

            return await PaginatedList<UserVM>.CreateAsync(users, request.PageNumber ?? 1, Core.Helpers.Configs.PageSize);
        }
    }
}

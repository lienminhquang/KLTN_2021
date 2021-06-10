using AutoMapper;
using FoodOrder.API.Identity;
using FoodOrder.Core.Helpers;
using FoodOrder.Core.Inferstructer;
using FoodOrder.Core.Models;
using FoodOrder.Core.ViewModels;
using FoodOrder.Core.ViewModels.AppRoles;
using FoodOrder.Core.ViewModels.Users;
using FoodOrder.Data;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Identity;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Primitives;
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
        private readonly IMapper _mapper;

        public UserServices(UserManager<AppUser> userManager
            , SignInManager<AppUser> signInManager
            , RoleManager<AppRole> roleManager
            , IConfiguration configuration
            , ApplicationDBContext applicationDBContext
            , ILogger<UserServices> logger
            , IMapper mapper)
        {
            _userManager = userManager;
            _signInManager = signInManager;
            _roleManager = roleManager;
            _config = configuration;
            _dbContext = applicationDBContext;
            _logger = logger;
            _mapper = mapper;
        }

        public async Task<bool> ValidateJWTAsync(ClaimsPrincipal claims)
        {
            var timeCreateJWT = claims.FindFirstValue("TimeCreateJWT");
            var user = await _userManager.FindByNameAsync(claims.FindFirstValue(ClaimTypes.Name));
            if(user.TimeCreateJWT.ToString() != timeCreateJWT)
            {
                return false;
            }
            return true;
        }

        public async Task<ApiResult<string>> Authenticate(LoginRequest loginRequest)
        {
            var user = await _userManager.FindByNameAsync(loginRequest.Username);
            
            if (user == null)
            {
                return new FailedResult<string>("Phone number or password is incorrect!");
            }

            //if (user.IsBanned)
            //{
            //    return new FailedResult<string>("Login failed, account is banned!");
            //}

            var signinResult = await _signInManager.PasswordSignInAsync(user, loginRequest.Password, loginRequest.RememberMe, true);
            if (!signinResult.Succeeded)
            {
                return new FailedResult<string>("Phone number or password is incorrect!");
            }
            user.TimeCreateJWT = DateTime.Now;
            var claims = new List<Claim>
            {
                new Claim("UserID", user.Id.ToString()),
                new Claim(ClaimTypes.MobilePhone, user.UserName),
                new Claim(ClaimTypes.Name, user.UserName),
                new Claim(ClaimTypes.GivenName, user.FirstName + " " + user.LastName),
                new Claim("TimeCreateJWT", user.TimeCreateJWT.ToString())
            };
            var roles = await _userManager.GetRolesAsync(user);
            claims.AddRange(roles.Select(x => new Claim(ClaimTypes.Role, x)));

            var key = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(_config["Tokens:Key"]));
            var creds = new SigningCredentials(key, SecurityAlgorithms.HmacSha256);

            var token = new JwtSecurityToken(_config["Tokens:Issuer"],
                    _config["Tokens:Issuer"],
                    claims,
                    expires: DateTime.Now.AddHours(1),
                    signingCredentials: creds
                );

            string tokenString = new JwtSecurityTokenHandler().WriteToken(token);
            //user.JWT = tokenString;
            await _dbContext.SaveChangesAsync();

            return new SuccessedResult<string>(tokenString);
        }

        //public async Task<ApiResult<UserVM>> GetUserInfo()

        public async Task<ApiResult<bool>> Register(RegisterRequest registerRequest)
        {
            var user = new AppUser()
            {
                //DateOfBirth = registerRequest.Dob,
                //Email = registerRequest.Email,
                FirstName = registerRequest.FirstName,
                LastName = registerRequest.LastName,
                UserName = registerRequest.PhoneNumber,
                SecurityStamp = new Guid().ToString()
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
            await _userManager.AddToRoleAsync(user, PolicyType.User);

            return new SuccessedResult<bool>(true);
        }

        public async Task<ApiResult<UserUpdateRequest>> EditUser(string id, UserUpdateRequest request)
        {
            AppUser user = await _userManager.FindByIdAsync(id);
            if (user == null)
            {
                return new FailedResult<UserUpdateRequest>("User not found!");
            }
            user.FirstName = request.FirstName;
            user.LastName = request.LastName;
            user.Email = request.Email;
            user.DateOfBirth = request.Dob;

            if (!String.IsNullOrEmpty(request.NewPassword))
            {
                if(request.NewPassword != request.ConfirmPassword)
                {
                    return new FailedResult<UserUpdateRequest>("Confirm password is not match!");
                }

                foreach (var item in _userManager.PasswordValidators)
                {
                    var validateResult = await item.ValidateAsync(_userManager, user, request.NewPassword);
                    if (validateResult.Succeeded == false)
                    {
                        return new FailedResult<UserUpdateRequest>(string.Join('\n', validateResult.Errors.Select(x => x.Description).ToList()));
                    }
                }

                await _userManager.RemovePasswordAsync(user);
                await _userManager.AddPasswordAsync(user, request.NewPassword);
                await _userManager.UpdateSecurityStampAsync(user);
                //user.JWT = null;
                await _dbContext.SaveChangesAsync();
               
            }
            IdentityResult rs = await _userManager.UpdateAsync(user);

            if (!rs.Succeeded)
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

        public async Task<ApiResult<bool>> ChangePassword(ChangePasswordVM request)
        {
            AppUser user = await _userManager.FindByIdAsync(request.UserID);
            if (user == null)
            {
                return new FailedResult<bool>("User not found!");
            }
            
            if (!String.IsNullOrEmpty(request.NewPassword))
            {
                if (request.NewPassword != request.ConfirmPassword)
                {
                    return new FailedResult<bool>("Confirm password is not match!");
                }

                foreach (var item in _userManager.PasswordValidators)
                {
                    var validateResult = await item.ValidateAsync(_userManager, user, request.NewPassword);
                    if (validateResult.Succeeded == false)
                    {
                        return new FailedResult<bool>(string.Join('\n', validateResult.Errors.Select(x => x.Description).ToList()));
                    }
                }

                await _userManager.RemovePasswordAsync(user);
                await _userManager.AddPasswordAsync(user, request.NewPassword);
                await _userManager.UpdateSecurityStampAsync(user);
                //user.JWT = null;
                await _dbContext.SaveChangesAsync();
            }
            IdentityResult rs = await _userManager.UpdateAsync(user);

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

        public async Task<ApiResult<List<string>>> GetRolesOfUser(string userID)
        {
            var user = await _userManager.FindByIdAsync(userID);
            if (user == null)
            {
                return new FailedResult<List<string>>("User not found!");
            }
            var listRoleString = await _userManager.GetRolesAsync(user);

            return new SuccessedResult<List<string>>(listRoleString.ToList());
        }

        public async Task<ApiResult<bool>> AssignRoleToUser(String userID, List<String> roles)
        {
            var user = await _userManager.FindByIdAsync(userID.ToString());
            if (user == null)
            {
                return new FailedResult<bool>("User not found!");
            }

            using var transaction = _dbContext.Database.BeginTransaction();
            try
            {

                var currentRole = (from ur in _dbContext.UserRoles
                                   where ur.UserId.ToString().Equals(userID)
                                   join r in _dbContext.Roles on ur.RoleId equals r.Id
                                   select r.Name).ToList();
                //_dbContext.UserRoles.RemoveRange(currentRole);
                var removeResult = await _userManager.RemoveFromRolesAsync(user, currentRole);

                if(roles != null)
                {
                    foreach (var role in roles)
                    {
                        await _userManager.AddToRoleAsync(user, role);
                    }
                }
                
                transaction.Commit();
                return new SuccessedResult<bool>(true);
            }
            catch (Exception e)
            {
                _logger.LogError("Can't assign role to user: " + e.Message);
            }
            return new FailedResult<bool>("Some thing when wrong!");
        }

        public async Task<ApiResult<PaginatedList<UserVM>>> GetAllPaging(PagingRequestBase request)
        {
            var users = from c in _dbContext.AppUsers
                        select new UserVM()
                        {
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
            if (user == null)
            {
                return new FailedResult<UserVM>("User not found!");
            }
            var userVM = new UserVM()
            {
                ID = user.Id,
                Username = user.UserName,
                DateOfBirth = user.DateOfBirth,
                Email = user.Email,
                FirstName = user.FirstName,
                LastName = user.LastName
            };
            var roles = await GetRolesOfUser(id);
            userVM.AppRoles = roles.PayLoad;
            return new SuccessedResult<UserVM>(userVM);
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

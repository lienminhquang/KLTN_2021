using FoodOrder.API.Identity;
using FoodOrder.API.Services;
using FoodOrder.Core.Inferstructer;
using FoodOrder.Core.Models;
using FoodOrder.Core.ViewModels;
using FoodOrder.Core.ViewModels.Users;
using FoodOrder.Data;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

// For more information on enabling Web API for empty projects, visit https://go.microsoft.com/fwlink/?LinkID=397860

namespace FoodOrder.API.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    [Authorize]
    public class UsersController : ControllerBase
    {
        private readonly UserServices _userService;
        private readonly UserManager<AppUser> _userManager;
        private readonly ApplicationDBContext _dbContext;

        public UsersController(UserServices userServices, UserManager<AppUser> userManager, ApplicationDBContext applicationDBContext)
        {
            _userService = userServices;
            _userManager = userManager;
            _dbContext = applicationDBContext;
        }

        [HttpPost("Login")]
        [AllowAnonymous]
        public async Task<IActionResult> Login([FromBody] LoginRequest loginRequest)
        {
            if (!ModelState.IsValid)
            {
                return Ok(new FailedResult<LoginResponse>(ModelState.ToString()));
            }
            ApiResult<LoginResponse> rs = await _userService.Authenticate(loginRequest);
            if (!rs.IsSuccessed)
            {
                return BadRequest(rs);
            }
            return Ok(rs);
        }

        [HttpPost("RefreshToken")]
        [AllowAnonymous]
        public async Task<IActionResult> RefreshToken([FromBody] RefreshTokenRequest refreshTokenRequest)
        {
            if (!ModelState.IsValid)
            {
                return Ok(new FailedResult<LoginResponse>(ModelState.ToString()));
            }
            ApiResult<LoginResponse> rs = await _userService.RefreshToken(refreshTokenRequest);
            if (!rs.IsSuccessed)
            {
                return BadRequest(rs);
            }
            return Ok(rs);
        }

        [HttpPost("Register")]
        [AllowAnonymous]
        public async Task<IActionResult> Register([FromBody] RegisterRequest registerRequest)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(new FailedResult<string>(ModelState.ToString()));
            }
            var rs = await _userService.Register(registerRequest);
            if (!rs.IsSuccessed)
            {
                return BadRequest(rs);
            }
            return Ok(rs);
        }

        // GET: api/<UsersController>
        [HttpGet]
        [Authorize(Roles = PolicyType.Manager + "," + PolicyType.Admin)]
        //[Authorize(Roles = "user")]
        [ValidTokenRequirement]
        public async Task<IActionResult> Get([FromQuery] PagingRequestBase request)
        {
            var rs = await _userService.GetAllPaging(request);
            if (!rs.IsSuccessed)
            {
                return BadRequest(rs);
            }
            return Ok(rs);
        }

        [HttpGet("userinrole/{role}")]
        [Authorize(Roles = PolicyType.Manager + "," + PolicyType.Admin)]
        //[Authorize(Roles = "user")]
        [ValidTokenRequirement]
        public async Task<IActionResult> GetUserInRole([FromQuery] PagingRequestBase request, [FromRoute] string role)
        {
            var rs = await _userService.GetAllInRolePaging(request, role);
            if (!rs.IsSuccessed)
            {
                return BadRequest(rs);
            }
            return Ok(rs);
        }

        [HttpGet("role/{id}")]
        [Authorize(Roles = PolicyType.Manager + "," + PolicyType.Admin + "," + PolicyType.User)]
        [ValidTokenRequirement]
        public async Task<IActionResult> GetRolesOfUser(string id)
        {
            if (!(HttpContext.User.IsInRole(PolicyType.Manager) || HttpContext.User.IsInRole(PolicyType.Admin)))
            {
                var userIDInClaim = HttpContext.User.Claims.First(x => x.Type == "UserID").Value;
                if (userIDInClaim != id.ToString())
                {
                    return Forbid();
                }
            }
            var result = await _userService.GetRolesOfUser(id);
            if (!result.IsSuccessed)
            {
                return BadRequest(result);
            }

            return Ok(result);
        }

        [HttpPost("role/{userID}")]
        [Authorize(Roles = PolicyType.Admin)]
        [ValidTokenRequirement]
        public async Task<IActionResult> ChangeUserRoles(string userID, [FromBody] RoleAssignVM roleAssignVM)
        {
            var result = await _userService.AssignRoleToUser(userID, roleAssignVM.roles);
            if (!result.IsSuccessed)
            {
                return BadRequest(result);
            }

            return Ok(result);
        }


        [HttpPost("password")]
        //[Authorize(Roles = PolicyType.Manager + "," + PolicyType.Admin + "," + PolicyType.User)]
        [Authorize(Roles = PolicyType.User)]
        [ValidTokenRequirement]
        public async Task<IActionResult> ChangePassword([FromBody] ChangePasswordVM changePasswordVM)
        {
            var userID = HttpContext.User.Claims.First(x => x.Type == "UserID").Value;
            var user = await _userService.GetUserByID(userID);
            if(user.IsSuccessed == false || user.PayLoad.Username != changePasswordVM.Username)
            {
                return Forbid();
            }

            var result = await _userService.ChangePassword(changePasswordVM);
            if (!result.IsSuccessed)
            {
                return BadRequest(result);
            }

            return Ok(result);
        }

        [HttpPost("reset_password")]
        //[Authorize(Roles = PolicyType.Manager + "," + PolicyType.Admin + "," + PolicyType.User)]
        [AllowAnonymous]
        public async Task<IActionResult> ResetPassword([FromBody] ResetPassword resetPassword)
        {
            var result = await _userService.ResetPassword(resetPassword);
            if (!result.IsSuccessed)
            {
                return BadRequest(result);
            }

            return Ok(result);
        }

        // GET api/<UsersController>/5
        [HttpGet("{id}")]
        [Authorize(Roles = PolicyType.Manager + "," + PolicyType.Admin + "," + PolicyType.User)]
        [ValidTokenRequirement]
        public async Task<IActionResult> Get(string id)
        {
            if (!(HttpContext.User.IsInRole(PolicyType.Manager) || HttpContext.User.IsInRole(PolicyType.Admin)))
            {
                var userIDInClaim = HttpContext.User.Claims.First(x => x.Type == "UserID").Value;
                if (userIDInClaim != id.ToString())
                {
                    return Forbid();
                }
            }
            var result = await _userService.GetUserByID(id);
            if (!result.IsSuccessed)
            {
                return BadRequest(result);
            }

            return Ok(result);
        }

        // POST api/<UsersController>
        [HttpPost]
        [ValidTokenRequirement]
        public void Post([FromBody] string value)
        {
        }

        // PUT api/<UsersController>/5
        [HttpPut("{id}")]
        [Authorize(Roles = PolicyType.Manager + "," + PolicyType.Admin + "," + PolicyType.User)]
        [ValidTokenRequirement]
        public async Task<IActionResult> Put(string id, [FromBody] UserUpdateRequest request)
        {
            if (!(HttpContext.User.IsInRole(PolicyType.Manager) || HttpContext.User.IsInRole(PolicyType.Admin)))
            {
                var userIDInClaim = HttpContext.User.Claims.First(x => x.Type == "UserID").Value;
                if (userIDInClaim != id.ToString())
                {
                    return Forbid();
                }
            }
            var result = await _userService.EditUser(id, request);
            if (!result.IsSuccessed)
            {
                return BadRequest(result);
            }

            return Ok(result);
        }

        // DELETE api/<UsersController>/5
        [HttpDelete("{id}")]
        [Authorize(Roles = PolicyType.Admin)]
        [ValidTokenRequirement]
        public async Task<IActionResult> Delete(string id)
        {
            var result = await _userService.DeleteUser(id);
            if (!result.IsSuccessed)
            {
                return BadRequest(result);
            }

            return Ok(result);
        }

        [HttpDelete("permanently/{id}")]
        [Authorize(Roles = PolicyType.Admin)]
        [ValidTokenRequirement]
        public async Task<IActionResult> DeletePermanently(string id)
        {
            var result = await _userService.DeleteUserPermanently(id);
            if (!result.IsSuccessed)
            {
                return BadRequest(result);
            }

            return Ok(result);
        }
    }
}

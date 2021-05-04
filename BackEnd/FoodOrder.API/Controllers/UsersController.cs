using FoodOrder.API.Services;
using FoodOrder.Core.Inferstructer;
using FoodOrder.Core.Models;
using FoodOrder.Core.ViewModels;
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
            if(!ModelState.IsValid)
            {
                return BadRequest(new FailedResult<string>(ModelState.ToString()));
            }
            ApiResult<string> rs = await _userService.Authenticate(loginRequest);
            if(!rs.IsSuccessed)
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
            if(!rs.IsSuccessed)
            {
                return BadRequest(rs);
            }
            return Ok(rs);
        }

        // GET: api/<UsersController>
        [HttpGet]
        public async Task<IActionResult> Get([FromQuery] PagingRequestBase request)
        {
            var rs = await _userService.GetUserPaging(request);
            if (!rs.IsSuccessed)
            {
                return BadRequest(rs);
            }
            return Ok(rs);
        }

        // GET api/<UsersController>/5
        [HttpGet("{id}")]
        public async Task<IActionResult> Get(string id)
        {
            var result = await _userService.GetUserByID(id);
            if(!result.IsSuccessed)
            {
                return BadRequest(result);
            }

            return Ok(result);
        }

        // POST api/<UsersController>
        [HttpPost]
        public void Post([FromBody] string value)
        {
        }

        // PUT api/<UsersController>/5
        [HttpPut("{id}")]
        public async Task<IActionResult> Put(string id, [FromBody] UserUpdateRequest request)
        {
            var result = await _userService.EditUser(id, request);
            if (!result.IsSuccessed)
            {
                return BadRequest(result);
            }

            return Ok(result);
        }

        // DELETE api/<UsersController>/5
        [HttpDelete("{id}")]
        public async Task<IActionResult> Delete(string id)
        {
            var result = await _userService.DeleteUser(id);
            if (!result.IsSuccessed)
            {
                return BadRequest(result);
            }

            return Ok(result);
        }
    }
}

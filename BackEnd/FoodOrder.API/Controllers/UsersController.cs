using FoodOrder.API.Services;
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
                return BadRequest("Internal server error!");
            }
            var rs = await _userService.Authenticate(loginRequest);
            if(string.IsNullOrEmpty(rs))
            {
                return BadRequest("Login fail, check your username or password!");
            }
            return Ok(rs);
        }

        [HttpPost("Register")]
        [AllowAnonymous]
        public async Task<IActionResult> Register([FromBody] RegisterRequest registerRequest)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest("Internal server error!");
            }
            var rs = await _userService.Register(registerRequest);
            if(rs == false)
            {
                return BadRequest("Could not create user!");
            }
            return Ok();
        }

        // GET: api/<UsersController>
        [HttpGet]
        public async Task<IActionResult> Get([FromQuery] PagingRequestBase request)
        {
            return Ok(await _userService.GetUserPaging(request));
        }

        // GET api/<UsersController>/5
        [HttpGet("{id}")]
        public string Get(int id)
        {
            return "value";
        }

        // POST api/<UsersController>
        [HttpPost]
        public void Post([FromBody] string value)
        {
        }

        // PUT api/<UsersController>/5
        [HttpPut("{id}")]
        public void Put(int id, [FromBody] string value)
        {
        }

        // DELETE api/<UsersController>/5
        [HttpDelete("{id}")]
        public void Delete(int id)
        {
        }
    }
}

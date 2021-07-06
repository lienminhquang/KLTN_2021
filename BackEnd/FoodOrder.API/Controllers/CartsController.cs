using FoodOrder.Core.Models;
using FoodOrder.Data;
using FoodOrder.Core.Helpers;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using FoodOrder.Core.ViewModels;
using FoodOrder.Core.Inferstructer;
using FoodOrder.API.Services;
using FoodOrder.Core.ViewModels.Carts;
using Microsoft.AspNetCore.Authorization;
using FoodOrder.API.Identity;

// For more information on enabling Web API for empty projects, visit https://go.microsoft.com/fwlink/?LinkID=397860

namespace FoodOrder.API.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    [Authorize]
    [ValidTokenRequirement]
    public class CartsController : ControllerBase
    {
        private readonly CartServices _cartServices;

        public CartsController(CartServices cartServices)
        {
            _cartServices = cartServices;
        }
        // GET: api/<ValuesController>
        [HttpGet]
        [Authorize(Roles = PolicyType.Manager + "," + PolicyType.Admin)]
        public async Task<IActionResult> GetAsync([FromQuery] PagingRequestBase request)
        {
            var result = await _cartServices.GetCartPaging(request);
            if (!result.IsSuccessed)
            {
                return BadRequest(result);
            }
            return Ok(result);
        }

        [HttpGet("user")]
        [Authorize(Roles = PolicyType.Manager + "," + PolicyType.Admin + "," + PolicyType.User)]
        public async Task<IActionResult> GetAsync([FromQuery] string userID, [FromQuery] PagingRequestBase request)
        {
            if (!(HttpContext.User.IsInRole(PolicyType.Manager) || HttpContext.User.IsInRole(PolicyType.Admin)))
            {
                var userIDInClaim = HttpContext.User.Claims.First(x => x.Type == "UserID").Value;
                if (userIDInClaim != userID)
                {
                    return Forbid();
                }
            }

            var result = await _cartServices.GetByUserID(userID, request);
            if (!result.IsSuccessed)
            {
                return BadRequest(result);
            }
            return Ok(result);
        }

        // GET api/<ValuesController>/details?
        [HttpGet("details")]
        [Authorize(Roles = PolicyType.Manager + "," + PolicyType.Admin + "," + PolicyType.User)]
        public async Task<IActionResult> Get([FromQuery] Guid userId, [FromQuery] int foodID)
        {
            if (!(HttpContext.User.IsInRole(PolicyType.Manager) || HttpContext.User.IsInRole(PolicyType.Admin)))
            {
                var userIDInClaim = HttpContext.User.Claims.First(x => x.Type == "UserID").Value;
                if (userIDInClaim != userId.ToString())
                {
                    return Forbid();
                }
            }

            var result = await _cartServices.GetByID(userId, foodID);
            if (!result.IsSuccessed)
            {
                return BadRequest(result);
            }
            return Ok(result);
        }

        // POST api/<ValuesController>
        [HttpPost]
        [Authorize(Roles = PolicyType.Manager + "," + PolicyType.Admin + "," + PolicyType.User)]
        public async Task<IActionResult> Post([FromBody] CartCreateVM cart)
        {
            if (!(HttpContext.User.IsInRole(PolicyType.Manager) || HttpContext.User.IsInRole(PolicyType.Admin)))
            {
                var userIDInClaim = HttpContext.User.Claims.First(x => x.Type == "UserID").Value;
                if (userIDInClaim != cart.AppUserId.ToString())
                {
                    return Forbid();
                }
            }

            var result = await _cartServices.Create(cart);
            if (!result.IsSuccessed)
            {
                return BadRequest(result);
            }
            return CreatedAtAction(nameof(Get)
                , new { userId = result.PayLoad.AppUserId, foodID = result.PayLoad.FoodID }
            , result);
        }

        // POST api/<ValuesController>
        [HttpPost("edit_or_create")]
        [Authorize(Roles = PolicyType.Manager + "," + PolicyType.Admin + "," + PolicyType.User)]
        public async Task<IActionResult> EditOrCreate([FromBody] CartCreateVM cart)
        {
            if (!(HttpContext.User.IsInRole(PolicyType.Manager) || HttpContext.User.IsInRole(PolicyType.Admin)))
            {
                var userIDInClaim = HttpContext.User.Claims.First(x => x.Type == "UserID").Value;
                if (userIDInClaim != cart.AppUserId.ToString())
                {
                    return Forbid();
                }
            }

            var result = await _cartServices.EditOrCreate(cart);
            if (!result.IsSuccessed)
            {
                return BadRequest(result);
            }
            return Ok(result);
        }

        // PUT api/<ValuesController>/5
        [HttpPut]
        [Authorize(Roles = PolicyType.Manager + "," + PolicyType.Admin + "," + PolicyType.User)]
        public async Task<IActionResult> PutAsync(Guid userId, int foodID, [FromBody] CartEditVM value)
        {
            if (!(HttpContext.User.IsInRole(PolicyType.Manager) || HttpContext.User.IsInRole(PolicyType.Admin)))
            {
                var userIDInClaim = HttpContext.User.Claims.First(x => x.Type == "UserID").Value;
                if (userIDInClaim != value.AppUserId.ToString())
                {
                    return Forbid();
                }
            }

            var result = await _cartServices.Edit(userId, foodID, value);
            if (!result.IsSuccessed)
            {
                return BadRequest(result);
            }
            return Ok(result);
        }

        // DELETE api/<ValuesController>/5
        [HttpDelete]
        [Authorize(Roles = PolicyType.Manager + "," + PolicyType.Admin + "," + PolicyType.User)]
        public async Task<IActionResult> Delete(Guid userId, int foodID)
        {
            if (!(HttpContext.User.IsInRole(PolicyType.Manager) || HttpContext.User.IsInRole(PolicyType.Admin)))
            {
                var userIDInClaim = HttpContext.User.Claims.First(x => x.Type == "UserID").Value;
                if (userIDInClaim != userId.ToString())
                {
                    return Forbid();
                }
            }

            var result = await _cartServices.Delete(userId, foodID);
            if (!result.IsSuccessed)
            {
                return BadRequest(result);
            }
            return Ok(result);
        }
    }
}

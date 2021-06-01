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

// For more information on enabling Web API for empty projects, visit https://go.microsoft.com/fwlink/?LinkID=397860

namespace FoodOrder.API.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class CartsController : ControllerBase
    {
        private readonly CartServices _cartServices;

        public CartsController(CartServices cartServices)
        {
            _cartServices = cartServices;
        }
        // GET: api/<ValuesController>
        [HttpGet]
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
        public async Task<IActionResult> GetAsync([FromQuery] string userID)
        {
            var result = await _cartServices.GetByUserID(userID);
            if (!result.IsSuccessed)
            {
                return BadRequest(result);
            }
            return Ok(result);
        }

        // GET api/<ValuesController>/details?
        [HttpGet("details")]
        public async Task<IActionResult> Get([FromQuery] Guid userId, [FromQuery] int foodID)
        {
            var result = await _cartServices.GetByID(userId, foodID);
            if (!result.IsSuccessed)
            {
                return BadRequest(result);
            }
            return Ok(result);
        }

        // POST api/<ValuesController>
        [HttpPost]
        public async Task<IActionResult> Post([FromBody] CartCreateVM cart)
        {
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
        public async Task<IActionResult> EditOrCreate([FromBody] CartCreateVM cart)
        {
            var result = await _cartServices.EditOrCreate(cart);
            if (!result.IsSuccessed)
            {
                return BadRequest(result);
            }
            return Ok(result);
        }

        // PUT api/<ValuesController>/5
        [HttpPut]
        public async Task<IActionResult> PutAsync(Guid userId, int foodID, [FromBody] CartEditVM value)
        {
            var result = await _cartServices.Edit(userId, foodID, value);
            if (!result.IsSuccessed)
            {
                return BadRequest(result);
            }
            return Ok(result);
        }

        // DELETE api/<ValuesController>/5
        [HttpDelete]
        public async Task<IActionResult> Delete(Guid userId, int foodID)
        {
            var result = await _cartServices.Delete(userId, foodID);
            if (!result.IsSuccessed)
            {
                return BadRequest(result);
            }
            return Ok(result);
        }
    }
}

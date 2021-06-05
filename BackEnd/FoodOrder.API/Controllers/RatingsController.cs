using FoodOrder.API.Identity;
using FoodOrder.API.Services;
using FoodOrder.Core.Helpers;
using FoodOrder.Core.Models;
using FoodOrder.Core.ViewModels;
using FoodOrder.Core.ViewModels.Ratings;
using FoodOrder.Data;
using Microsoft.AspNetCore.Authorization;
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
    public class RatingsController : ControllerBase
    {
        private readonly RatingServices _ratingServices;

        public RatingsController(RatingServices services)
        {
            _ratingServices = services;
        }
        // GET: api/<ValuesController>
        [HttpGet]
        [AllowAnonymous]
        public async Task<IActionResult> GetAsync([FromQuery] PagingRequestBase request)
        {
            var result = await _ratingServices.GetAllPaging(request);
            if (!result.IsSuccessed)
            {
                return BadRequest(result);
            }
            return Ok(result);
        }

        [HttpGet("food")]
        [AllowAnonymous]
        public async Task<IActionResult> GetAsync([FromQuery] PagingRequestBase request, [FromQuery] int foodID)
        {
            var result = await _ratingServices.GetRatingsOfFood(foodID, request);
            if (!result.IsSuccessed)
            {
                return BadRequest(result);
            }
            return Ok(result);
        }

        // GET api/<ValuesController>/details?
        [HttpGet("details")]
        [AllowAnonymous]
        public IActionResult Get([FromQuery] int orderID, [FromQuery] int foodID)
        {
            var result = _ratingServices.GetByID(orderID, foodID);
            if (!result.IsSuccessed)
            {
                return BadRequest(result);
            }
            return Ok(result);
        }

        // POST api/<ValuesController>
        [HttpPost]
        [Authorize(Roles = PolicyType.Manager + "," + PolicyType.Admin)]
        public async Task<IActionResult> Post([FromBody] RatingCreateVM vM)
        {
            var result = await _ratingServices.Create(vM);
            if (!result.IsSuccessed)
            {
                return BadRequest(result);
            }
            return CreatedAtAction(nameof(Get), new { orderID = vM.OrderID, foodID = vM.FoodID }, result);

        }

        // PUT api/<ValuesController>/5
        [HttpPut]
        [Authorize(Roles = PolicyType.Manager + "," + PolicyType.Admin )]
        public async Task<IActionResult> PutAsync([FromQuery] int orderID, [FromQuery] int foodID, [FromBody] RatingEditVM value)
        {
            var result = await _ratingServices.Edit(orderID, foodID, value);
            if (!result.IsSuccessed)
            {
                return BadRequest(result);
            }
            return Ok(result);
        }

        // DELETE api/<ValuesController>/5
        [HttpDelete]
        [Authorize(Roles = PolicyType.Admin)]
        public async Task<IActionResult> Delete([FromQuery] int orderID, [FromQuery] int foodID)
        {
            var result = await _ratingServices.Delete(orderID, foodID);
            if (!result.IsSuccessed)
            {
                return BadRequest(result);
            }
            return Ok(result);
        }
    }
}

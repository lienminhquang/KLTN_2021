using FoodOrder.API.Identity;
using FoodOrder.API.Services;
using FoodOrder.Core.Helpers;
using FoodOrder.Core.Inferstructer;
using FoodOrder.Core.Models;
using FoodOrder.Core.ViewModels;
using FoodOrder.Core.ViewModels.OrderDetails;
using FoodOrder.Data;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
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
    [ValidTokenRequirement]
    public class OrderDetailsController : ControllerBase
    {
        private readonly OrderDetailServices _orderDetailServices;
        private readonly OrderServices _orderServices;

        public OrderDetailsController(OrderDetailServices orderDetailServices, OrderServices orderServices)
        {
            _orderDetailServices = orderDetailServices;
            _orderServices = orderServices;
        }
        // GET: api/<ValuesController>
        [HttpGet]
        [Authorize(Roles = PolicyType.Manager + "," + PolicyType.Admin)]
        public async Task<IActionResult> GetAsync([FromQuery] PagingRequestBase request)
        {
            var result = await _orderDetailServices.GetAllPaging(request);
            if (!result.IsSuccessed)
            {
                return BadRequest(result);
            }
            return Ok(result);
        }

        // GET api/<ValuesController>/details?
        [HttpGet("details")]
        [Authorize(Roles = PolicyType.Manager + "," + PolicyType.Admin + "," + PolicyType.User)]
        public async Task<IActionResult> Get([FromQuery] int orderID, [FromQuery] int foodID)
        {
            if (!(HttpContext.User.IsInRole(PolicyType.Manager) || HttpContext.User.IsInRole(PolicyType.Admin)))
            {
                var userIDInClaim = HttpContext.User.Claims.First(x => x.Type == "UserID").Value;
                var order = _orderServices.GetByID(orderID);
                if (order.IsSuccessed && userIDInClaim != order.PayLoad.AppUserID.ToString())
                {
                    return Forbid();
                }
            }

            var result = await _orderDetailServices.GetByID(orderID, foodID);
            if (!result.IsSuccessed)
            {
                return BadRequest(result);
            }
            return Ok(result);
        }

        // POST api/<ValuesController>
        [HttpPost]
        [Authorize(Roles = PolicyType.Admin + "," + PolicyType.User)]
        public async Task<IActionResult> Post([FromBody] OrderDetailCreateVM vM)
        {
            if (!(HttpContext.User.IsInRole(PolicyType.Manager) || HttpContext.User.IsInRole(PolicyType.Admin)))
            {
                var userIDInClaim = HttpContext.User.Claims.First(x => x.Type == "UserID").Value;
                var order = _orderServices.GetByID(vM.OrderID);
                if (order.IsSuccessed && userIDInClaim != order.PayLoad.AppUserID.ToString())
                {
                    return Forbid();
                }
            }

            var result = await _orderDetailServices.Create(vM);
            if (!result.IsSuccessed)
            {
                return BadRequest(result);
            }
            return CreatedAtAction(nameof(Get)
                , new {orderID = result.PayLoad.OrderID, foodID = result.PayLoad.FoodID }
                , result);

        }

        // PUT api/<ValuesController>/5
        [HttpPut]
        [Authorize(Roles = PolicyType.Admin)]
        public async Task<IActionResult> PutAsync(int orderID, int foodID, [FromBody] OrderDetailEditVM value)
        {
            var result = await _orderDetailServices.Edit(orderID, foodID, value);
            if (!result.IsSuccessed)
            {
                return BadRequest(result);
            }
            return Ok(result);
        }

        // DELETE api/<ValuesController>/5
        [HttpDelete]
        [Authorize(Roles = PolicyType.Admin)]
        public async Task<IActionResult> Delete(int orderID, int foodID)
        {
            var result = await _orderDetailServices.Delete(orderID, foodID);
            if (!result.IsSuccessed)
            {
                return BadRequest(result);
            }
            return Ok(result);
        }

        [HttpDelete("permanently")]
        [Authorize(Roles = PolicyType.Admin)]
        public async Task<IActionResult> DeletePermanently(int orderID, int foodID)
        {
            var result = await _orderDetailServices.DeletePermanently(orderID, foodID);
            if (!result.IsSuccessed)
            {
                return BadRequest(result);
            }
            return Ok(result);
        }
    }

    
}

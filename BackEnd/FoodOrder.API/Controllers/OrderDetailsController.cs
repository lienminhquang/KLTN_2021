using FoodOrder.API.Services;
using FoodOrder.Core.Helpers;
using FoodOrder.Core.Inferstructer;
using FoodOrder.Core.Models;
using FoodOrder.Core.ViewModels;
using FoodOrder.Core.ViewModels.OrderDetails;
using FoodOrder.Data;
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
    public class OrderDetailsController : ControllerBase
    {
        private readonly OrderDetailServices _orderDetailServices;

        public OrderDetailsController(OrderDetailServices orderDetailServices)
        {
            _orderDetailServices = orderDetailServices;
        }
        // GET: api/<ValuesController>
        [HttpGet]
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
        public async Task<IActionResult> Get([FromQuery] int orderID, [FromQuery] int foodID)
        {
            var result = await _orderDetailServices.GetByID(orderID, foodID);
            if (!result.IsSuccessed)
            {
                return BadRequest(result);
            }
            return Ok(result);
        }

        // POST api/<ValuesController>
        [HttpPost]
        public async Task<IActionResult> Post([FromBody] OrderDetailCreateVM vM)
        {
            var result = await _orderDetailServices.Create(vM);
            if (!result.IsSuccessed)
            {
                return BadRequest(result);
            }
            return Ok(result);
        }

        // PUT api/<ValuesController>/5
        [HttpPut]
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
        public async Task<IActionResult> Delete(int orderID, int foodID)
        {
            var result = await _orderDetailServices.Delete(orderID, foodID);
            if (!result.IsSuccessed)
            {
                return BadRequest(result);
            }
            return Ok(result);
        }
    }

    
}

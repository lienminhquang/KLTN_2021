using FoodOrder.API.Services;
using FoodOrder.Core.ViewModels;
using FoodOrder.Core.ViewModels.Notifications;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace FoodOrder.API.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class NotificationsController : Controller
    {
        private readonly NotificationServices _notiServices;

        public NotificationsController(NotificationServices services)
        {
            _notiServices = services;
        }
        // GET: api/<ValuesController>
        [HttpGet]
        public async Task<IActionResult> GetAsync([FromQuery] PagingRequestBase request)
        {
            var result = await _notiServices.GetAllPaging(request);
            if (!result.IsSuccessed)
            {
                return BadRequest(result);
            }
            return Ok(result);
        }

        [HttpGet("user")]
        public async Task<IActionResult> GetAsync([FromQuery] PagingRequestBase request, [FromQuery] string userID)
        {
            var result = await _notiServices.GetByUserID(userID, request);
            if (!result.IsSuccessed)
            {
                return BadRequest(result);
            }
            return Ok(result);
        }
        [HttpGet("unreceived")]
        public async Task<IActionResult> GetUnreceivedAsync([FromQuery] PagingRequestBase request, [FromQuery] string userID)
        {
            var result = await _notiServices.GetUnReceivedByUserID(userID, request);
            if (!result.IsSuccessed)
            {
                return BadRequest(result);
            }
            return Ok(result);
        }

        [HttpPost("received")]
        public IActionResult NotificationReceived([FromBody] NotificationReceivedVM notificationReceivedVM)
        {
            var result = _notiServices.NotificationReceived(notificationReceivedVM);
            if (!result.IsSuccessed)
            {
                return BadRequest(result);
            }
            return Ok(result);
        }

        // GET api/<ValuesController>/details?
        [HttpGet("details")]
        public async Task<IActionResult> Get([FromQuery] int id)
        {
            var result =  _notiServices.GetByID(id);
            if (!result.IsSuccessed)
            {
                return BadRequest(result);
            }
            return Ok(result);
        }

        // POST api/<ValuesController>
        [HttpPost]
        public async Task<IActionResult> Post([FromBody] NotificationCreateVM vM)
        {
            var result = await _notiServices.Create(vM);
            if (!result.IsSuccessed)
            {
                return BadRequest(result);
            }
            return CreatedAtAction(nameof(Get), result.PayLoad.ID, result);

        }

        //// PUT api/<ValuesController>/5
        //[HttpPut]
        //public async Task<IActionResult> PutAsync(Guid userID, int foodID, [FromBody] RatingEditVM value)
        //{
        //    var result = await _notiServices.Edit(userID, foodID, value);
        //    if (!result.IsSuccessed)
        //    {
        //        return BadRequest(result);
        //    }
        //    return Ok(result);
        //}

        // DELETE api/<ValuesController>/5
        [HttpDelete]
        public async Task<IActionResult> Delete(int id)
        {
            var result = await _notiServices.Delete(id);
            if (!result.IsSuccessed)
            {
                return BadRequest(result);
            }
            return Ok(result);
        }
    }
}

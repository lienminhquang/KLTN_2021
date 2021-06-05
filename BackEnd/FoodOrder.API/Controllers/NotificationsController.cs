using FoodOrder.API.Identity;
using FoodOrder.API.Services;
using FoodOrder.Core.ViewModels;
using FoodOrder.Core.ViewModels.Notifications;
using Microsoft.AspNetCore.Authorization;
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
    [Authorize]
    public class NotificationsController : Controller
    {
        private readonly NotificationServices _notiServices;

        public NotificationsController(NotificationServices services)
        {
            _notiServices = services;
        }
        // GET: api/<ValuesController>
        [HttpGet]
        [Authorize(Roles = PolicyType.Admin + "," + PolicyType.Manager)]
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
        [Authorize(Roles = PolicyType.Admin + "," + PolicyType.Manager + "," + PolicyType.User)]
        public async Task<IActionResult> GetAsync([FromQuery] PagingRequestBase request, [FromQuery] string userID)
        {
            if (!(HttpContext.User.IsInRole(PolicyType.Manager) || HttpContext.User.IsInRole(PolicyType.Admin)))
            {
                var userIDInClaim = HttpContext.User.Claims.First(x => x.Type == "UserID").Value;
                if (userIDInClaim != userID)
                {
                    return Forbid();
                }
            }
            var result = await _notiServices.GetByUserID(userID, request);
            if (!result.IsSuccessed)
            {
                return BadRequest(result);
            }
            return Ok(result);
        }
        [HttpGet("unreceived")]
        [Authorize(Roles = PolicyType.Admin + "," + PolicyType.Manager + "," + PolicyType.User)]
        public async Task<IActionResult> GetUnreceivedAsync([FromQuery] PagingRequestBase request, [FromQuery] string userID)
        {
            if (!(HttpContext.User.IsInRole(PolicyType.Manager) || HttpContext.User.IsInRole(PolicyType.Admin)))
            {
                var userIDInClaim = HttpContext.User.Claims.First(x => x.Type == "UserID").Value;
                if (userIDInClaim != userID)
                {
                    return Forbid();
                }
            }
            var result = await _notiServices.GetUnReceivedByUserID(userID, request);
            if (!result.IsSuccessed)
            {
                return BadRequest(result);
            }
            return Ok(result);
        }

        [HttpPost("received")]
        [Authorize(Roles = PolicyType.Admin + "," + PolicyType.Manager + "," + PolicyType.User)]
        public IActionResult NotificationReceived([FromBody] NotificationReceivedVM notificationReceivedVM)
        {
            if (!(HttpContext.User.IsInRole(PolicyType.Manager) || HttpContext.User.IsInRole(PolicyType.Admin)))
            {
                var userIDInClaim = HttpContext.User.Claims.First(x => x.Type == "UserID").Value;
                var notification = _notiServices.GetByID(notificationReceivedVM.NotificationID);
                if (notification.IsSuccessed && userIDInClaim != notification.PayLoad.UserID.ToString())
                {
                    return Forbid();
                }
            }
            var result = _notiServices.NotificationReceived(notificationReceivedVM);
            if (!result.IsSuccessed)
            {
                return BadRequest(result);
            }
            return Ok(result);
        }

        // GET api/<ValuesController>/details?
        [HttpGet("details")]
        [Authorize(Roles = PolicyType.Admin + "," + PolicyType.Manager + "," + PolicyType.User)]
        public async Task<IActionResult> Get([FromQuery] int id)
        {
            if (!(HttpContext.User.IsInRole(PolicyType.Manager) || HttpContext.User.IsInRole(PolicyType.Admin)))
            {
                var userIDInClaim = HttpContext.User.Claims.First(x => x.Type == "UserID").Value;
                var notification = _notiServices.GetByID(id);
                if (notification.IsSuccessed && userIDInClaim != notification.PayLoad.UserID.ToString())
                {
                    return Forbid();
                }
            }

            var result =  _notiServices.GetByID(id);
            if (!result.IsSuccessed)
            {
                return BadRequest(result);
            }
            return Ok(result);
        }

        // POST api/<ValuesController>
        [HttpPost]
        [Authorize(Roles = PolicyType.Admin + "," + PolicyType.Manager)]
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
        [Authorize(Roles = PolicyType.Admin + "," + PolicyType.Manager)]
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

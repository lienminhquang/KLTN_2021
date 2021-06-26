using FoodOrder.API.Identity;
using FoodOrder.API.Services;
using FoodOrder.Core.Helpers;
using FoodOrder.Core.Models;
using FoodOrder.Core.ViewModels;
using FoodOrder.Core.ViewModels.Orders;
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
    [ValidTokenRequirement]
    public class OrdersController : ControllerBase
    {

        private readonly OrderServices _orderServices;

        public OrdersController(OrderServices orderServices)
        {
            _orderServices = orderServices;
        }


        [HttpGet("{id}")]
        [Authorize(Roles = PolicyType.Manager + "," + PolicyType.Admin + "," + PolicyType.User)]
        public IActionResult GetByID(int id)
        {
            if (!(HttpContext.User.IsInRole(PolicyType.Manager) || HttpContext.User.IsInRole(PolicyType.Admin)))
            {
                var userIDInClaim = HttpContext.User.Claims.First(x => x.Type == "UserID").Value;
                var order = _orderServices.GetByID(id);
                if (order.IsSuccessed && userIDInClaim != order.PayLoad.AppUserID.ToString())
                {
                    return Forbid();
                }
            }
            var result = _orderServices.GetByID(id);
            if (!result.IsSuccessed)
            {
                return BadRequest(result);
            }
            return Ok(result);
        }

        [HttpGet("user")]
        [Authorize(Roles = PolicyType.Manager + "," + PolicyType.Admin + "," + PolicyType.User)]
        public async Task<IActionResult> GetByUserID([FromQuery] string userID)
        {
            if (!(HttpContext.User.IsInRole(PolicyType.Manager) || HttpContext.User.IsInRole(PolicyType.Admin)))
            {
                var userIDInClaim = HttpContext.User.Claims.First(x => x.Type == "UserID").Value;
                
                if ( userIDInClaim != userID)
                {
                    return Forbid();
                }
            }

            var result = _orderServices.GetByUserID(userID);
            if (!result.IsSuccessed)
            {
                return BadRequest(result);
            }
            return Ok(result);
        }

        [HttpPost]
        [Authorize(Roles = PolicyType.Manager + "," + PolicyType.Admin + "," + PolicyType.User)]
        public async Task<IActionResult> Create([FromBody] OrderCreateVM createVM)
        {
            if (!(HttpContext.User.IsInRole(PolicyType.Manager) || HttpContext.User.IsInRole(PolicyType.Admin)))
            {
                var userIDInClaim = HttpContext.User.Claims.First(x => x.Type == "UserID").Value;
               
                if (userIDInClaim != createVM.AppUserID.ToString())
                {
                    return Forbid();
                }
            }

            var result = await _orderServices.Create(createVM);
            if (!result.IsSuccessed)
            {
                return BadRequest(result);
            }
            return CreatedAtAction(nameof(GetByID), result.PayLoad.ID, result);

        }

        [HttpPost("changestatus")]
        [Authorize(Roles = PolicyType.Manager + "," + PolicyType.Admin + "," + PolicyType.User)]
        public async Task<IActionResult> ChangOrderStatus([FromBody] ChangeOrderStatusVM vm)
        {
            if (!(HttpContext.User.IsInRole(PolicyType.Manager) || HttpContext.User.IsInRole(PolicyType.Admin)))
            {
                var userIDInClaim = HttpContext.User.Claims.First(x => x.Type == "UserID").Value;
                var order = _orderServices.GetByID(vm.ID);
                if (order.IsSuccessed && userIDInClaim != order.PayLoad.AppUserID.ToString())
                {
                    
                    return Forbid();
                }

                //Todo: Order đang ở bước sau không thể quay lại bước trước???
                //if(order.PayLoad.OrderStatusID < vm.OrderStatusID)
                //{
                //    return Forbid();
                //}
            }
            var result = await _orderServices.ChangOrderStatus(vm);
            if (!result.IsSuccessed)
            {
                return BadRequest(result);
            }
            return Ok(result);
        }

        [HttpPut]
        [Authorize(Roles = PolicyType.Manager + "," + PolicyType.Admin)]
        public async Task<IActionResult> Edit(int id, [FromBody] OrderEditVM editVM)
        {
            // Todo: please handle this kind of error
            if (!ModelState.IsValid)
            {
                return BadRequest();
            }

            var result = await _orderServices.Edit(id, editVM);
            if (!result.IsSuccessed)
            {
                return BadRequest(result);
            }
            return Ok(result);
        }

        [HttpDelete("{id}")]
        [Authorize(Roles = PolicyType.Manager)]
        public async Task<IActionResult> Delete(int id)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest();
            }

            var result = await _orderServices.Delete(id);
            if (!result.IsSuccessed)
            {
                return BadRequest(result);
            }
            return Ok(result);
        }

        [HttpGet]
        [Authorize(Roles = PolicyType.Manager + "," + PolicyType.Admin)]
        // TODO: return the sortorder, currentfilter, pagenumber to the client.
        public async Task<IActionResult> GetAllPaging([FromQuery] PagingRequestBase request)
        {
            var result = await _orderServices.GetAllPaging(request);
            if (!result.IsSuccessed)
            {
                return BadRequest(result);
            }
            return Ok(result);
        }
    }
}

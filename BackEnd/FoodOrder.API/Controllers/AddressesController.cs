using FoodOrder.API.Identity;
using FoodOrder.API.Services;
using FoodOrder.Core.Helpers;
using FoodOrder.Core.Inferstructer;
using FoodOrder.Core.ViewModels;
using FoodOrder.Core.ViewModels.Addresses;
using Microsoft.AspNetCore.Authorization;
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
    public class AddressesController : Controller
    {
        private readonly AddressServices _addressServices;
        private readonly UserServices _userSerivces;


        public AddressesController(AddressServices services, UserServices userServices)
        {
            _addressServices = services;
            _userSerivces = userServices;
        }
        // GET: api/<ValuesController>
        [HttpGet]
        [Authorize(Roles = PolicyType.Manager + "," + PolicyType.Admin)]
        public async Task<IActionResult> GetAsync([FromQuery] PagingRequestBase request)
        {
            var validated = await _userSerivces.ValidateJWTAsync(this.HttpContext.User);
            if(validated == false)
            {
                return BadRequest(new FailedResult<PaginatedList<AddressVM>>("Token expired!", ApiResult<bool>.TokenExpiredCode));
            }


            var result = await _addressServices.GetAllPaging(request);
            if (!result.IsSuccessed)
            {
                return BadRequest(result);
            }
            return Ok(result);
        }

        // GET api/<ValuesController>/details?
        [HttpGet("user")]
        [Authorize(Roles = PolicyType.Manager + "," + PolicyType.Admin + "," + PolicyType.User)]
        public async Task<IActionResult> GetByUserID([FromQuery] string userID)
        {
            if(!(HttpContext.User.IsInRole(PolicyType.Manager) || HttpContext.User.IsInRole(PolicyType.Admin)))
            {
                if(HttpContext.User.Claims.First(x => x.Type == "UserID").Value != userID)
                {
                    return Forbid();
                }
            }

            var result = await _addressServices.GetByUserID(userID);
            if (!result.IsSuccessed)
            {
                return BadRequest(result);
            }
            return Ok(result);
        }

        // GET api/<ValuesController>/details?
        [HttpGet("details")]
        [Authorize(Roles = PolicyType.Manager + "," + PolicyType.Admin + "," + PolicyType.User)]
        public IActionResult Get([FromQuery] int id)
        {
            var result = _addressServices.GetByID(id);

            if (!(HttpContext.User.IsInRole(PolicyType.Manager) || HttpContext.User.IsInRole(PolicyType.Admin)))
            {
                var userID = HttpContext.User.Claims.First(x => x.Type == "UserID").Value;
                if(result.IsSuccessed && result.PayLoad.AppUserID.ToString() != userID)
                {
                    return Forbid();
                }
            }

            if (!result.IsSuccessed)
            {
                return BadRequest(result);
            }
            return Ok(result);
        }

        // POST api/<ValuesController>
        [HttpPost]
        [Authorize(Roles = PolicyType.Manager + "," + PolicyType.Admin + "," + PolicyType.User)]
        public async Task<IActionResult> Post([FromBody] AddressCreateVM vM)
        {
            if (!(HttpContext.User.IsInRole(PolicyType.Manager) || HttpContext.User.IsInRole(PolicyType.Admin)))
            {
                var userID = HttpContext.User.Claims.First(x => x.Type == "UserID").Value;
                if (userID != vM.AppUserID.ToString())
                {
                    return Forbid();
                }
            }

            var result = await _addressServices.Create(vM);
            if (!result.IsSuccessed)
            {
                return BadRequest(result);
            }
            return CreatedAtAction(nameof(Get), result.PayLoad.ID, result);
        }

        // PUT api/<ValuesController>/5
        [HttpPut]
        [Authorize(Roles = PolicyType.Manager + "," + PolicyType.Admin + "," + PolicyType.User)]
        public async Task<IActionResult> PutAsync(int id, [FromBody] AddressEditVM value)
        {
            if (!(HttpContext.User.IsInRole(PolicyType.Manager) || HttpContext.User.IsInRole(PolicyType.Admin)))
            {
                var userID = HttpContext.User.Claims.First(x => x.Type == "UserID").Value;
                if (userID != value.AppUserID.ToString())
                {
                    return Forbid();
                }
            }

            var result = await _addressServices.Edit(id, value);
            if (!result.IsSuccessed)
            {
                return BadRequest(result);
            }
            return Ok(result);
        }

        // DELETE api/<ValuesController>/5
        [HttpDelete]
        [Authorize(Roles = PolicyType.Manager + "," + PolicyType.Admin + "," + PolicyType.User)]
        public async Task<IActionResult> Delete(int id)
        {
            var address = _addressServices.GetByID(id);
            if (!(HttpContext.User.IsInRole(PolicyType.Manager) || HttpContext.User.IsInRole(PolicyType.Admin)))
            {
                var userID = HttpContext.User.Claims.First(x => x.Type == "UserID").Value;
                if (address.IsSuccessed == true && userID != address.PayLoad.AppUserID.ToString())
                {
                    return Forbid();
                }
            }

            var result = await _addressServices.Delete(id);
            if (!result.IsSuccessed)
            {
                return BadRequest(result);
            }
            return Ok(result);
        }
    }
}

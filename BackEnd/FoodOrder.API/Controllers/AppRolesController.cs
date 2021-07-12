using FoodOrder.API.Identity;
using FoodOrder.API.Services;
using FoodOrder.Core.Helpers;
using FoodOrder.Core.ViewModels;
using FoodOrder.Core.ViewModels.AppRoles;
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
    [ValidTokenRequirement]
    public class AppRolesController : Controller
    {
        private readonly AppRoleServices _appRoleServices;

        public AppRolesController(AppRoleServices appRoleServices)
        {
            _appRoleServices = appRoleServices;
        }

        [HttpGet]
        [Authorize(Roles = PolicyType.Manager + "," + PolicyType.Admin )]
        public async Task<IActionResult> GetAllPaging([FromQuery] PagingRequestBase request)
        {
            var result = await _appRoleServices.GetAllPaging(request);
            if (!result.IsSuccessed)
            {
                return BadRequest(result);
            }
            return Ok(result);
        }

        [HttpGet("{id}")]
        [Authorize(Roles = PolicyType.Manager + "," + PolicyType.Admin)]
        public async Task<IActionResult> GetByID(Guid id)
        {
            var result = await _appRoleServices.GetByID(id);
            if (!result.IsSuccessed)
            {
                return BadRequest(result);
            }
            return Ok(result);
        }

        [HttpPost]
        [Authorize(Roles = PolicyType.Admin)]
        public async Task<IActionResult> Create([FromBody] AppRoleCreateVM createVM)
        {
            var result = await _appRoleServices.Create(createVM);
            if (!result.IsSuccessed)
            {
                return BadRequest(result);
            }
            return CreatedAtAction(nameof(GetByID), result.PayLoad.Id, result);
        }

        [HttpPut]
        [Authorize(Roles = PolicyType.Admin)]
        public async Task<IActionResult> Edit(string id, [FromBody] AppRoleEditVm editVM)
        {
            // Todo: please handle this kind of error
            if (!ModelState.IsValid)
            {
                return BadRequest();
            }

            var result = await _appRoleServices.Edit(new Guid(id), editVM);
            if (!result.IsSuccessed)
            {
                return BadRequest(result);
            }
            return Ok(result);
        }

        [HttpDelete("{id}")]
        [Authorize(Roles = PolicyType.Admin)]
        public async Task<IActionResult> Delete(Guid id)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest();
            }

            var result = await _appRoleServices.Delete(id);
            if (!result.IsSuccessed)
            {
                return BadRequest(result);
            }
            return Ok(result);
        }

        [HttpDelete("permanently/{id}")]
        [Authorize(Roles = PolicyType.Admin)]
        public async Task<IActionResult> DeletePermanently(Guid id)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest();
            }

            var result = await _appRoleServices.DeletePermanently(id);
            if (!result.IsSuccessed)
            {
                return BadRequest(result);
            }
            return Ok(result);
        }
    }
}

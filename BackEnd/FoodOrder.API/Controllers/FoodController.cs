﻿using FoodOrder.API.Identity;
using FoodOrder.API.Services;
using FoodOrder.Core.Helpers;
using FoodOrder.Core.Inferstructer;
using FoodOrder.Core.Models;
using FoodOrder.Core.ViewModels;
using FoodOrder.Core.ViewModels.Categories;
using FoodOrder.Core.ViewModels.Foods;
using FoodOrder.Data;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace FoodOrder.API.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    [Authorize]
    public class FoodController : ControllerBase
    {
        private readonly FoodServices _foodServices;
        private readonly UserManager<AppUser> _userManager;

        public FoodController(FoodServices foodServices, UserManager<AppUser> userManager)
        {
            _foodServices = foodServices;
            _userManager = userManager;
        }


        [HttpGet("{id}")]
        [AllowAnonymous]
        public async Task<IActionResult> GetByID(int id)
        {

            var result = await _foodServices.GetByID(id);
            if (!result.IsSuccessed)
            {
                return BadRequest(result);
            }
            return Ok(result);
        }

        [HttpGet("best_selling")]
        [AllowAnonymous]
        public async Task<IActionResult> GetBestSellingAsync([FromQuery] PagingRequestBase request)
        {
            var result = await _foodServices.GetBestSellingAsync(request);
            if (!result.IsSuccessed)
            {
                return BadRequest(result);
            }
            return Ok(result);
        }

        [HttpGet("most_discounted")]
        [AllowAnonymous]
        public IActionResult GetMostDiscounted([FromQuery] PagingRequestBase request)
        {
            var result = _foodServices.GetMostDiscounted(request);
            if (!result.IsSuccessed)
            {
                return BadRequest(result);
            }
            return Ok(result);
        }

        [HttpPost]
        [Authorize(Roles = PolicyType.Admin + "," + PolicyType.Manager)]
        [Consumes("multipart/form-data")]
        [ValidTokenRequirement]
        public async Task<IActionResult> Create([FromForm] FoodCreateVM foodCreateVM)
        {
            var result = await _foodServices.Create(foodCreateVM);
            if (!result.IsSuccessed)
            {
                return BadRequest(result);
            }
           

            return CreatedAtAction(nameof(GetByID), result.PayLoad.ID, result);
        }

        [HttpPost("{id}/categories")]
        [Authorize(Roles = PolicyType.Admin + "," + PolicyType.Manager)]
        [ValidTokenRequirement]
        public async Task<IActionResult> AddFoodToCategories(int id, [FromBody] List<string> categoryIDs)
        {
            var fcResult = await _foodServices.AddFoodToCategories(categoryIDs, id);
            if (fcResult.IsSuccessed == false)
            {
                return BadRequest(new FailedResult<bool>(fcResult.ErrorMessage));
            }
            return Ok(fcResult);
        }

        [HttpDelete("{id}/categories")]
        [Authorize(Roles = PolicyType.Admin + "," + PolicyType.Manager)]
        [ValidTokenRequirement]
        public async Task<IActionResult> DeleteFoodFromCategory(int id)
        {
            var fcResult = await _foodServices.DeleteFoodFromAllCategory(id);
            if (fcResult.IsSuccessed == false)
            {
                return BadRequest(new FailedResult<bool>(fcResult.ErrorMessage));
            }
            return Ok(fcResult);
        }

        [HttpPut]
        [Consumes("multipart/form-data")]
        [Authorize(Roles = PolicyType.Admin + "," + PolicyType.Manager)]
        [ValidTokenRequirement]
        public async Task<IActionResult> Edit(int id, [FromForm] FoodEditVM food)
        {
            // Todo: please handle this kind of error
            if (!ModelState.IsValid)
            {
                return BadRequest();
            }

            var result = await _foodServices.Edit(id, food);
            if (!result.IsSuccessed)
            {
                return BadRequest(result);
            }
            return Ok(result);
        }

        [HttpDelete("{id}")]
        [Authorize(Roles = PolicyType.Admin)]
        [ValidTokenRequirement]
        public async Task<IActionResult> Delete(int id)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest();
            }

            var result = await _foodServices.Delete(id);
            if (!result.IsSuccessed)
            {
                return BadRequest(result);
            }
            return Ok(result);
        }

        [HttpDelete("permanently/{id}")]
        [Authorize(Roles = PolicyType.Admin)]
        [ValidTokenRequirement]
        public async Task<IActionResult> DeletePermanently(int id)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest();
            }

            var result = await _foodServices.DeletePermanently(id);
            if (!result.IsSuccessed)
            {
                return BadRequest(result);
            }
            return Ok(result);
        }

        [HttpGet]
        [AllowAnonymous]
        public async Task<IActionResult> GetAllPaging([FromQuery]PagingRequestBase request)
        {
            var result = await _foodServices.GetAllPaging(request);
            if (!result.IsSuccessed)
            {
                return BadRequest(result);
            }
            return Ok(result);
        }

        [HttpGet("filter")]
        [AllowAnonymous]
        public async Task<IActionResult> GetAllByFilter([FromQuery] CategoryFilterPagingRequest request)
        {
            var result = await _foodServices.GetAllByFilter(request);
            if (!result.IsSuccessed)
            {
                return BadRequest(result);
            }
            return Ok(result);
        }
    }
}

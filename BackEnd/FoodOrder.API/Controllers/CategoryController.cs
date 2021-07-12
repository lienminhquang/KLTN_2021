using FoodOrder.Core.Models;
using FoodOrder.Data;
using FoodOrder.Core.Helpers;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using FoodOrder.API.Services;
using FoodOrder.Core.ViewModels;
using FoodOrder.Core.ViewModels.Categories;
using Microsoft.AspNetCore.Authorization;
using FoodOrder.API.Identity;

namespace FoodOrder.API.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    [Authorize]
    public class CategoryController : ControllerBase
    {
        private readonly CategoryServices _categoryServices;

        public CategoryController(CategoryServices categoryServices)
        {
            _categoryServices = categoryServices;
        }

        // GET: CategoryController
        [HttpGet]
        [AllowAnonymous]
        public async Task<IActionResult> GetAllPaging([FromQuery]PagingRequestBase request)
        {
            var result = await _categoryServices.GetAllPaging(request);
            if (!result.IsSuccessed)
            {
                return BadRequest(result);
            }
            return Ok(result);
        }

        [HttpGet("{id}")]
        [AllowAnonymous]
        public async Task<IActionResult> GetByID(int id)
        {
            var result = await _categoryServices.GetByID(id);
            if (!result.IsSuccessed)
            {
                return BadRequest(result);
            }
            return Ok(result);
        }

        [HttpGet("{id}/foods")]
        [AllowAnonymous]
        public async Task<IActionResult> GetFoodsInCategory(int id, [FromQuery]PagingRequestBase request)
        {
            var result = await _categoryServices.GetFoodInCategory(id, request);
            if (!result.IsSuccessed)
            {
                return BadRequest(result);
            }
            return Ok(result);
        }

        [HttpGet("{id}/best_selling")]
        [AllowAnonymous]
        public async Task<IActionResult> GetBestSellingInCategory(int id, [FromQuery] PagingRequestBase request)
        {
            var result = await _categoryServices.GetBestSellingInCategory(id, request);
            if (!result.IsSuccessed)
            {
                return BadRequest(result);
            }
            return Ok(result);
        }

        [HttpGet("{id}/promoting")]
        [AllowAnonymous]
        public async Task<IActionResult> GetPromotingInCategory(int id, [FromQuery] PagingRequestBase request)
        {
            var result = await _categoryServices.GetPromotingInCategory(id, request);
            if (!result.IsSuccessed)
            {
                return BadRequest(result);
            }
            return Ok(result);
        }

        [HttpPost]
        [Authorize(Roles = PolicyType.Manager + "," + PolicyType.Admin)]
        [Consumes("multipart/form-data")]
        [ValidTokenRequirement]
        public async Task<IActionResult> CreateAsync([FromForm] CategoryCreateVM request)
        {
            var result = await _categoryServices.Create(request);
            if (!result.IsSuccessed)
            {
                return BadRequest(result);
            }
            return CreatedAtAction(nameof(GetByID), result.PayLoad.ID, result);
        }

        [HttpPut]
        [Consumes("multipart/form-data")]
        [Authorize(Roles = PolicyType.Manager + "," + PolicyType.Admin)]
        [ValidTokenRequirement]
        public async Task<IActionResult> EditAsync(int id, [FromForm] CategoryEditVM category)
        {
            var result = await _categoryServices.Edit(id ,category);
            if (!result.IsSuccessed)
            {
                return BadRequest(result);
            }
            return Ok(result);
        }

        [HttpDelete("{id}")]
        [Authorize(Roles = PolicyType.Admin)]
        [ValidTokenRequirement]
        public async Task<IActionResult> DeleteAsync(int id)
        {
            var result = await _categoryServices.Delete(id);
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
            var result = await _categoryServices.DeletePermanently(id);
            if (!result.IsSuccessed)
            {
                return BadRequest(result);
            }
            return Ok(result);
        }
    }
}


using FoodOrder.API.Services;
using FoodOrder.Core.Helpers;
using FoodOrder.Core.Inferstructer;
using FoodOrder.Core.Models;
using FoodOrder.Core.ViewModels;
using FoodOrder.Core.ViewModels.Categories;
using FoodOrder.Core.ViewModels.Foods;
using FoodOrder.Data;
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

    public class FoodController : ControllerBase
    {
        private readonly FoodServices _foodServices;

        public FoodController(FoodServices foodServices)
        {
            _foodServices = foodServices;
        }


        [HttpGet("{id}")]
        public async Task<IActionResult> GetByID(int id)
        {
            var result = await _foodServices.GetByID(id);
            if (!result.IsSuccessed)
            {
                return BadRequest(result);
            }
            return Ok(result);
        }

        [HttpPost]
        [Consumes("multipart/form-data")]
        public async Task<IActionResult> Create([FromForm] FoodCreateVM foodCreateVM)
        {
            var result = await _foodServices.Create(foodCreateVM);
            if (!result.IsSuccessed)
            {
                return BadRequest(result);
            }
           

            return Ok(result);
        }

        [HttpPost("{id}/categories")]
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

        [HttpGet]
        // TODO: return the sortorder, currentfilter, pagenumber to the client.
        public async Task<IActionResult> GetAllPaging([FromQuery]PagingRequestBase request)
        {
            var result = await _foodServices.GetAllPaging(request);
            if (!result.IsSuccessed)
            {
                return BadRequest(result);
            }
            return Ok(result);
        }
    }
}

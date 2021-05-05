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

namespace FoodOrder.API.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class CategoryController : ControllerBase
    {
        public class CreateCategoryRequest
        {
            public string Name { get; set; }
            public string Description { get; set; }

            public Category ToCategory()
            {
                return new Category { Name = this.Name, Description = this.Description };
            }
        }

        private readonly CategoryServices _categoryServices;

        public CategoryController(CategoryServices categoryServices)
        {
            _categoryServices = categoryServices;
        }

        // GET: CategoryController
        [HttpGet]
        public async Task<ActionResult<PaginatedList<Category>>> GetAllPaging(PagingRequestBase request)
        {
            var result = await _categoryServices.GetAllPaging(request);
            if (!result.IsSuccessed)
            {
                return BadRequest(result);
            }
            return Ok(result);
        }

        [HttpGet("{id}")]
        public async Task<ActionResult<Category>> GetByID(int id)
        {
            var result = await _categoryServices.GetByID(id);
            if (!result.IsSuccessed)
            {
                return BadRequest(result);
            }
            return Ok(result);
        }

        [HttpPost]
        //[ValidateAntiForgeryToken]
        public async Task<ActionResult> CreateAsync([FromForm] CategoryCreateVM request)
        {
            var result = await _categoryServices.Create(request);
            if (!result.IsSuccessed)
            {
                return BadRequest(result);
            }
            return Ok(result);
        }

        [HttpPut]
        //[ValidateAntiForgeryToken]
        public async Task<ActionResult> EditAsync(int id, [FromForm] CategoryVM category)
        {
            var result = await _categoryServices.Edit(id ,category);
            if (!result.IsSuccessed)
            {
                return BadRequest(result);
            }
            return Ok(result);
        }

        [HttpDelete("{id}")]
        //[ValidateAntiForgeryToken]
        public async Task<ActionResult> DeleteAsync(int id)
        {
            var result = await _categoryServices.Delete(id);
            if (!result.IsSuccessed)
            {
                return BadRequest(result);
            }
            return Ok(result);
        }
    }
}

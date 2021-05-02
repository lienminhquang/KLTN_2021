using FoodOrder.Core.Models;
using FoodOrder.Data;
using FoodOrder.Core.Helpers;
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

        private readonly ApplicationDBContext m_dbContext;

        public CategoryController(ApplicationDBContext i_dbContext)
        {
            m_dbContext = i_dbContext;
        }

        // GET: CategoryController
        [HttpGet]
        public async Task<ActionResult<IEnumerable<Category>>> Index(string sortOrder, string searchString, string currentFilter, int? pageNumber)
        {
            var categories = from c in m_dbContext.Categories select c;
            if(!String.IsNullOrEmpty(searchString))
            {
                pageNumber = 1;
            }
            else
            {
                searchString = currentFilter;
            }

            if(!String.IsNullOrEmpty(searchString))
            {
                categories = categories.Where(c => c.Name.Contains(searchString) || c.Description.Contains(searchString));
            }

            categories = Core.Helpers.Utilities<Category>.Sort(categories, sortOrder, "ID");

            return await PaginatedList<Category>.CreateAsync(categories, pageNumber ?? 1, Core.Helpers.Configs.PageSize);

        }

        [HttpGet("{id}")]
        public async Task<ActionResult<Category>> Details(int id)
        {
            var category = await m_dbContext.Categories
                .Include(c => c.FoodCategories)
                    .ThenInclude(fc => fc.Food)    
                .FirstOrDefaultAsync(c => c.ID == id);
            if(category == null)
            {
                return NotFound();
            }
            return category;
        }

        [HttpPost]
        //[ValidateAntiForgeryToken]
        public async Task<ActionResult> CreateAsync([FromForm] CreateCategoryRequest request)
        {
            if(!ModelState.IsValid)
            {
                // TODO: server error ?
                return BadRequest();
            }

            var result = await m_dbContext.Categories.AddAsync(request.ToCategory());
            try
            {
                await m_dbContext.SaveChangesAsync();
            }
            catch (Exception e)
            {
                return BadRequest(e.Message);
            }

            //TODO: Create successed result ?
            return Ok();
        }

        [HttpPut]
        //[ValidateAntiForgeryToken]
        public async Task<ActionResult> EditAsync([FromForm] Category category)
        {
            if(ModelState.IsValid)
            {
                //TODO: check for related data?
                m_dbContext.Categories.Update(category);
                try
                {
                    await m_dbContext.SaveChangesAsync();
                }
                catch (Exception e)
                {
                    return BadRequest(e.Message);
                }
                return Ok();
            }
            return BadRequest();
        }

        [HttpDelete("{id}")]
        //[ValidateAntiForgeryToken]
        public async Task<ActionResult> DeleteAsync(int id)
        {
            if (ModelState.IsValid)
            {
                //TODO: check for related data?
                var c = await m_dbContext.Categories.FindAsync(id);
                if(c == null)
                {
                    return NotFound();
                }

                try
                {
                    m_dbContext.Categories.Remove(c);
                    await m_dbContext.SaveChangesAsync();
                }
                catch (Exception e)
                {
                    return BadRequest(e.Message);
                }
                return Ok();
            }
            return BadRequest();
        }
    }
}

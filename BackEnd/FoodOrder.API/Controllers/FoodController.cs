using FoodOrder.Core.Helpers;
using FoodOrder.Core.Models;
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
        public class FoodCreateRequest
        {
            public string Name { get; set; }
            public string Description { get; set; }
            public decimal Price { get; set; }
            public int Count { get; set; }
        }

        private readonly ApplicationDBContext m_dbContext;

        public FoodController(ApplicationDBContext i_context)
        {
            m_dbContext = i_context;
        }


        [HttpGet("{id}")]
        public async Task<ActionResult<Food>> GetFoodByID(int id)
        {
            var food = await m_dbContext.Foods
                .Include(f => f.Ratings)
                .Include(f => f.Images)
                .AsNoTracking()
                .FirstOrDefaultAsync(f => f.ID == id);
            if (food == null)
            {
                return NotFound();
            }

            return food;
        }

        [HttpPost]
        public async Task<ActionResult<Food>> CreateFood([FromForm] FoodCreateRequest foodCreateRequest)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest();
            }

            var food = await m_dbContext.Foods.AddAsync(new Food { Description = foodCreateRequest.Description, Name = foodCreateRequest.Name, Price = foodCreateRequest.Price });

            await m_dbContext.SaveChangesAsync();
            return CreatedAtAction(nameof(GetFoodByID), new { id = food.Entity.ID }, food.Entity);

        }

        [HttpPut]
        public async Task<ActionResult> EditFood([FromForm] Food newFood)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest();
            }

            var food = await m_dbContext.Foods.FirstOrDefaultAsync(x => x.ID == newFood.ID);
            if(food == null)
            {
                return NotFound();
            }
            food.Name = newFood.Name;
            food.Description = newFood.Description;
            food.Count = newFood.Count;
            food.Price = newFood.Price;
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

        [HttpDelete("{id}")]
        public async Task<ActionResult> DeleteFood(int id)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest();
            }

            var food = await m_dbContext.Foods.FindAsync(id);
            if (food == null)
            {
                return NotFound();
            }
            m_dbContext.Foods.Remove(food);
            await m_dbContext.SaveChangesAsync();

            return NoContent();
        }

        [HttpGet]
        // TODO: return the sortorder, currentfilter, pagenumber to the client.
        public async Task<ActionResult<IEnumerable<Food>>> GetAllFood(string sortOrder, string currentFilter, string searchString, int? pageNumber)
        {
            var foods = from f in m_dbContext.Foods 
                        select f;

            // if search string change, reset the page number to 1
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
                foods = foods.Where(f => f.Name.Contains(searchString) || f.Description.Contains(searchString));
            }

            foods = Core.Helpers.Utilities<Food>.Sort(foods, sortOrder, "ID");

            return await PaginatedList<Food>.CreateAsync(foods.AsNoTracking(), pageNumber ?? 1, Core.Helpers.Configs.PageSize);
        }
    }
}

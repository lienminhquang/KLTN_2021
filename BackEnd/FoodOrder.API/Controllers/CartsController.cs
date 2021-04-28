using FoodOrder.Core.Models;
using FoodOrder.Data;
using FoodOrder.API.Helpers;
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
    public class CartsController : ControllerBase
    {
        public class CartCreateRequest
        {
            public Guid AppUserId { get; set; }
            public int FoodID { get; set; }
            public int Quantity { get; set; }
        }

        public class CartEditRequest
        {
            public int Quantity { get; set; }
        }

        private readonly ApplicationDBContext m_dbContext;

        public CartsController(ApplicationDBContext i_dbContext)
        {
            m_dbContext = i_dbContext;
        }
        // GET: api/<ValuesController>
        [HttpGet]
        public async Task<IEnumerable<Cart>> GetAsync(string sortOrder, string searchString, string currentFilter, int? pageNumber)
        {
            var carts = from c in m_dbContext.Carts select c;
            if (!String.IsNullOrEmpty(searchString))
            {
                pageNumber = 1;
            }
            else
            {
                searchString = currentFilter;
            }

            //if (!String.IsNullOrEmpty(searchString))
            //{
            //    carts = carts.Where(c => c..Contains(searchString) || c.Description.Contains(searchString));
            //}

            carts = Helpers.Utilities<Cart>.Sort(carts, sortOrder, "AppUserId");

            return await PaginatedList<Cart>.CreateAsync(carts, pageNumber ?? 1, Helpers.Configs.PageSize);
        }

        // GET api/<ValuesController>/5
        [HttpGet("{userId}/{foodID}")]
        public async Task<Cart> Get(Guid userId, int foodID)
        {
            var cart = await m_dbContext.Carts.Include(c => c.AppUser).Include(c => c.Food).FirstOrDefaultAsync(c => c.AppUserId == userId && c.FoodID == foodID);
            return cart;
        }

        // POST api/<ValuesController>
        [HttpPost]
        public async Task<IActionResult> Post([FromBody] CartCreateRequest cart)
        {
            var result = await m_dbContext.Carts.AddAsync(new Cart 
            {
                FoodID = cart.FoodID,
                AppUserId = cart.AppUserId,
                Quantity = cart.Quantity
            });
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

        // PUT api/<ValuesController>/5
        [HttpPut("{userId}/{foodID}")]
        public async Task<IActionResult> PutAsync(Guid userId, int foodID, [FromBody] CartEditRequest value)
        {
            var cart = await m_dbContext.Carts.FirstOrDefaultAsync(c => c.AppUserId == userId && c.FoodID == foodID);
            if(cart == null)
            {
                return NotFound();
            }
            cart.Quantity = value.Quantity;
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

        // DELETE api/<ValuesController>/5
        [HttpDelete("{userId}/{foodID}")]
        public async Task<IActionResult> Delete(Guid userId, int foodID)
        {
            var cart = await m_dbContext.Carts.FirstOrDefaultAsync(c => c.AppUserId == userId && c.FoodID == foodID);
            if (cart == null)
            {
                return NotFound();
            }
            try
            {
                m_dbContext.Carts.Remove(cart);
                await m_dbContext.SaveChangesAsync();
            }
            catch (Exception e)
            {
                return BadRequest(e.Message);
            }
            return Ok();
        }
    }
}

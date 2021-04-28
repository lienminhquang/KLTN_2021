using FoodOrder.API.Helpers;
using FoodOrder.Core.Models;
using FoodOrder.Data;
using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

// For more information on enabling Web API for empty projects, visit https://go.microsoft.com/fwlink/?LinkID=397860

namespace FoodOrder.API.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class RatingsController : ControllerBase
    {
        public class RatingCreateRequest
        { 
            public Guid AppUserID { get; set; }
            public int FoodID { get; set; }
            public int Star { get; set; }
            public string Comment { get; set; }
        }

        public class RatingUpdateRequest
        {
            public int Star { get; set; }
            public string Comment { get; set; }
        }

        private readonly ApplicationDBContext m_dbContext;
        public RatingsController(ApplicationDBContext i_dbContext)
        {
            m_dbContext = i_dbContext;
        }

        // GET: api/<RatingsController>
        [HttpGet]
        public async Task<IEnumerable<Rating>> Get(string sortOrder, string searchString, string currentFilter, int? pageNumber)
        {
            var rating = from c in m_dbContext.Rating select c;
            if (!String.IsNullOrEmpty(searchString))
            {
                pageNumber = 1;
            }
            else
            {
                searchString = currentFilter;
            }

            if (!String.IsNullOrEmpty(searchString))
            {
                rating = rating.Where(c => c.Comment.Contains(searchString));
            }

            rating = Helpers.Utilities<Rating>.Sort(rating, sortOrder, "AppUserID");

            return await PaginatedList<Rating>.CreateAsync(rating, pageNumber ?? 1, Helpers.Configs.PageSize);

        }

        // GET api/<RatingsController>/5
        [HttpGet("{userID}/{foodID}")]
        public async Task<Rating> Get(Guid userID, int foodID)
        {
            return await m_dbContext.Rating.FindAsync(new { userID, foodID });
        }

        // POST api/<RatingsController>
        [HttpPost]
        public async Task<IActionResult> Post([FromBody] RatingCreateRequest value)
        {
            await m_dbContext.Rating.AddAsync(new Rating
            {
                AppUserID = value.AppUserID,
                FoodID = value.FoodID,
                Comment = value.Comment,
                LastCreatedTime = DateTime.Now,
                Star = value.Star
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

        // PUT api/<RatingsController>/5
        [HttpPut("{userID}/{foodID}")]
        public async Task<IActionResult> Put(Guid userID, int foodID, [FromBody] RatingUpdateRequest value)
        {
            var rating = await m_dbContext.Rating.FindAsync(new { userID, foodID });
            if (rating == null)
            {
                return NotFound();
            }

            rating.Comment = value.Comment;
            rating.Star = value.Star;
            rating.LastCreatedTime = DateTime.Now;

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

        // DELETE api/<RatingsController>/5
        [HttpDelete("{userID}/{foodID}")]
        public async Task<IActionResult> Delete(Guid userID, int foodID)
        {
            var rating = await m_dbContext.Rating.FindAsync(new { userID, foodID });
            if (rating == null)
            {
                return NotFound();
            }
            try
            {
                m_dbContext.Rating.Remove(rating);
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

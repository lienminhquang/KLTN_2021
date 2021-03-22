using FoodOrderBackend.Data;
using FoodOrderBackend.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace FoodOrderBackend.Controllers
{
    [Route("api/[controller]")]
    [ApiController]

    public class FoodController : ControllerBase
    {
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
            if(food == null)
            {
                return NotFound();
            }

            return food;
        }
    }
}

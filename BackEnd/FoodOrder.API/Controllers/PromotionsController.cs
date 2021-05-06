using FoodOrder.Core.Helpers;
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
    public class PromotionsController : ControllerBase
    {
        public class PromotionCreateRequest
        {
            public string Name { get; set; }
            public string Code { get; set; }
            public string Desciption { get; set; }
            public DateTime CreatedDate { get; set; }
            public DateTime StartDate { get; set; }
            public DateTime EndDate { get; set; }
            public int Amount { get; set; }
            public float Percent { get; set; }
            public bool Enabled { get; set; }
            public int Max { get; set; }
            public int MinPrice { get; set; }
        }
        public class PromotionUpdateRequest
        {
            public string Name { get; set; }
            public string Code { get; set; }
            public string Desciption { get; set; }
            public DateTime StartDate { get; set; }
            public DateTime EndDate { get; set; }
            public int Amount { get; set; }
            public float Percent { get; set; }
            public bool Enabled { get; set; }
            public int Max { get; set; }
            public int MinPrice { get; set; }
        }

        private readonly ApplicationDBContext m_dbContext;
        public PromotionsController(ApplicationDBContext i_dbContext)
        {
            m_dbContext = i_dbContext;
        }

        // GET: api/<ValuesController>
        [HttpGet]
        public async Task<PaginatedList<Promotion>> Get(string sortOrder, string searchString, string currentFilter, int? pageNumber)
        {
            var promition = from c in m_dbContext.Promotions select c;
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
                promition = promition.Where(c => c.Name.Contains(searchString) || c.Desciption.Contains(searchString));
            }

            promition = Core.Helpers.Utilities<Promotion>.Sort(promition, sortOrder, "ID");

            return await PaginatedList<Promotion>.CreateAsync(promition, pageNumber ?? 1, Core.Helpers.Configs.PageSize);

        }

        // GET api/<ValuesController>/5
        [HttpGet("{id}")]
        public async Task<Promotion> Get(int id)
        {
            return await m_dbContext.Promotions.FindAsync(id);
        }

        // POST api/<ValuesController>
        [HttpPost]
        public async Task<IActionResult> Post([FromBody] PromotionCreateRequest value)
        {
            var rs = m_dbContext.Promotions.AddAsync(new Promotion
            {
                Name = value.Name,
                Code = value.Code,
                Desciption = value.Desciption,
                CreatedDate = value.CreatedDate,
                StartDate = value.StartDate,
                EndDate = value.EndDate,
                Amount = value.Amount,
                Percent = value.Percent,
                Enabled = value.Enabled,
                Max = value.Max,
                MinPrice = value.MinPrice
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
        [HttpPut("{id}")]
        public async Task<IActionResult> Put(int id, [FromBody] PromotionUpdateRequest value)
        {
            var promotion = await m_dbContext.Promotions.FindAsync(id);
            if(promotion == null)
            {
                return NotFound();
            }

            promotion.Name = value.Name;
            promotion.Code = value.Code;
            promotion.Desciption = value.Desciption;
            promotion.StartDate = value.StartDate;
            promotion.EndDate = value.EndDate;
            promotion.Amount = value.Amount;
            promotion.Percent = value.Percent;
            promotion.Enabled = value.Enabled;
            promotion.Max = value.Max;
            promotion.MinPrice = value.MinPrice;
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
        [HttpDelete("{id}")]
        public async Task<IActionResult> Delete(int id)
        {
            var promotion = await m_dbContext.Promotions.FindAsync(id);
            if (promotion == null)
            {
                return NotFound();
            }
            try
            {
                m_dbContext.Promotions.Remove(promotion);
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

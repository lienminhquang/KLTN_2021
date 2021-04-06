using FoodOrderBackend.Data;
using FoodOrderBackend.Helpers;
using FoodOrderBackend.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

// For more information on enabling Web API for empty projects, visit https://go.microsoft.com/fwlink/?LinkID=397860

namespace FoodOrderBackend.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class OrdersController : ControllerBase
    {
        public class OrderCreateRequest
        {
            public Guid AppUserID { get; set; }
            public DateTime CreatedDate { get; set; }
            public int? PromotionID { get; set; }
            public decimal? PromotionAmount { get; set; }
        }

        public class OrderUpdateRequest
        {
            public int ID { get; set; }
            public bool IsPaid { get; set; }
            public DateTime? DatePaid { get; set; }
            public int OrderStatusID { get; set; }

            public List<OrderDetail> OrderDetails { get; set; }
        }

        private readonly ApplicationDBContext m_dbContext;

        public OrdersController(ApplicationDBContext i_dbContext)
        {
            m_dbContext = i_dbContext;
        }

        // GET: api/<ValuesController>
        [HttpGet]
        public async Task<IEnumerable<Order>> Get(string sortOrder, string searchString, string currentFilter, int? pageNumber)
        {
            var order = from c in m_dbContext.Orders select c;
            if (!String.IsNullOrEmpty(searchString))
            {
                pageNumber = 1;
            }
            else
            {
                searchString = currentFilter;
            }

            order = Helpers.Utilities<Order>.Sort(order, sortOrder, "ID");

            return await PaginatedList<Order>.CreateAsync(order, pageNumber ?? 1, Helpers.Configs.PageSize);
        }

        // GET api/<ValuesController>/5
        [HttpGet("{id}")]
        public async Task<Order> Get(int id)
        {
            var order = await m_dbContext.Orders
                .Include(o => o.AppUser)
                .FirstOrDefaultAsync(o => o.ID == id);
            return order;
        }

        // POST api/<ValuesController>
        [HttpPost]
        public async Task<IActionResult> PostAsync([FromBody] OrderCreateRequest value)
        {
            var result = await m_dbContext.Orders.AddAsync(new Order
            {
                AppUserID = value.AppUserID,
                CreatedDate = value.CreatedDate,
                //OrderStatusID = ?
                PromotionID = value.PromotionID,
                PromotionAmount = value.PromotionAmount
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
        public async Task<IActionResult> Put(int id, [FromBody] OrderUpdateRequest value)
        {
            var order = await m_dbContext.Orders.FindAsync(value.ID);
            if(order == null)
            {
                return NotFound();
            }
            order.IsPaid = value.IsPaid;
            order.DatePaid = value.DatePaid;
            order.OrderDetails = value.OrderDetails;
            order.OrderStatusID = value.OrderStatusID;

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
            var order = await m_dbContext.Orders.FindAsync(id);
            if (order == null)
            {
                return NotFound();
            }
           
            try
            {
                m_dbContext.Orders.Remove(order);
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

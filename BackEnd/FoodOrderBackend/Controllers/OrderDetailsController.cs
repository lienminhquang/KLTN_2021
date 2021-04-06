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
    public class OrderDetailsController : ControllerBase
    {
        public class OrderDetailCreateRequest
        {
            public int OrderID { get; set; }
            public int FoodID { get; set; }
            public int Amount { get; set; }
            public decimal Price { get; set; }
        }
        public class OrderDetailUpdateRequest
        {
            public int Amount { get; set; }
            public decimal Price { get; set; }
        }

        private readonly ApplicationDBContext m_dbContext;
        public OrderDetailsController(ApplicationDBContext i_dbContext)
        {
            m_dbContext = i_dbContext;
        }

        // GET: api/<OrderDetailsController>
        [HttpGet]
        public async Task<IEnumerable<OrderDetail>> Get(string sortOrder, string searchString, string currentFilter, int? pageNumber)
        {
            var orderDetail = from c in m_dbContext.OrderDetails select c;
            if (!String.IsNullOrEmpty(searchString))
            {
                pageNumber = 1;
            }
            else
            {
                searchString = currentFilter;
            }

            orderDetail = Helpers.Utilities<OrderDetail>.Sort(orderDetail, sortOrder, "OrderID");

            return await PaginatedList<OrderDetail>.CreateAsync(orderDetail, pageNumber ?? 1, Helpers.Configs.PageSize);
        }

        // GET api/<OrderDetailsController>/5
        [HttpGet("{orderID}/{foodID}")]
        public async Task<OrderDetail> Get(int orderID, int foodID)
        {
            var order = await m_dbContext.OrderDetails
                .Include(od => od.Food)
                .Include(od => od.Order)
                .FirstOrDefaultAsync(od => od.OrderID == orderID && od.FoodID == foodID);
            return order;
        }

        // POST api/<OrderDetailsController>
        [HttpPost]
        public async Task<IActionResult> Post([FromBody] OrderDetailCreateRequest value)
        {
            await m_dbContext.OrderDetails.AddAsync(new OrderDetail
            {
                OrderID = value.OrderID,
                FoodID = value.FoodID,
                Amount = value.Amount,
                Price = value.Price
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

        // PUT api/<OrderDetailsController>/5
        [HttpPut("{orderID}/{foodID}")]
        public async Task<IActionResult> Put(int orderID, int foodID, [FromBody] OrderDetailUpdateRequest value)
        {
            var orderDetail = await m_dbContext.OrderDetails.FirstOrDefaultAsync(od => od.FoodID == foodID && od.OrderID == orderID);
            if(orderDetail == null)
            {
                return NotFound();
            }
            orderDetail.Amount = value.Amount;
            orderDetail.Price = value.Price;
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

        // DELETE api/<OrderDetailsController>/5
        [HttpDelete("{orderID}/{foodID}")]
        public async Task<IActionResult> Delete(int orderID, int foodID)
        {
            var orderDetail = await m_dbContext.OrderDetails.FirstOrDefaultAsync(od => od.FoodID == foodID && od.OrderID == orderID);
            if (orderDetail == null)
            {
                return NotFound();
            }
           
            try
            {
                m_dbContext.Remove(orderDetail);
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

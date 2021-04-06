﻿using FoodOrderBackend.Data;
using FoodOrderBackend.Helpers;
using FoodOrderBackend.Models;
using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

// For more information on enabling Web API for empty projects, visit https://go.microsoft.com/fwlink/?LinkID=397860

namespace FoodOrderBackend.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class OrderStatusController : ControllerBase
    {
        public class OrderStatusCreateRequest
        {
            public string Name { get; set; }
            public string Description { get; set; }
        }

        public class OrderStatusUpdateRequest
        {
            public string Name { get; set; }
            public string Description { get; set; }
        }

        private readonly ApplicationDBContext m_dbContext;
        public OrderStatusController(ApplicationDBContext i_dbContext)
        {
            m_dbContext = i_dbContext;
        }

        // GET: api/<OrderStatusController>
        [HttpGet]
        public async Task<IEnumerable<OrderStatus>> Get(string sortOrder, string searchString, string currentFilter, int? pageNumber)
        {
            var orderStatus = from c in m_dbContext.OrderStatuses select c;
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
                orderStatus = orderStatus.Where(c => c.Name.Contains(searchString) || c.Description.Contains(searchString));
            }

            orderStatus = Helpers.Utilities<OrderStatus>.Sort(orderStatus, sortOrder, "ID");

            return await PaginatedList<OrderStatus>.CreateAsync(orderStatus, pageNumber ?? 1, Helpers.Configs.PageSize);

        }

        // GET api/<OrderStatusController>/5
        [HttpGet("{id}")]
        public async Task<OrderStatus> Get(int id)
        {
            var os = m_dbContext.OrderStatuses.FirstOrDefault(os => os.ID == id);
            return os;
        }

        // POST api/<OrderStatusController>
        [HttpPost]
        public async Task<IActionResult> Post([FromBody] OrderStatusCreateRequest value)
        {
            var rs = await m_dbContext.OrderStatuses.AddAsync(new OrderStatus
            {
                Name = value.Name,
                Description = value.Description
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

        // PUT api/<OrderStatusController>/5
        [HttpPut("{id}")]
        public async Task<IActionResult> Put(int id, [FromBody] OrderStatusUpdateRequest value)
        {
            var rs = await m_dbContext.OrderStatuses.FindAsync(id);
            if(rs == null)
            {
                return NotFound();
            }
            try
            {
                rs.Name = value.Name;
                rs.Description = value.Description;
                await m_dbContext.SaveChangesAsync();
            }
            catch (Exception e)
            {
                return BadRequest(e.Message);
            }
            return Ok();
        }

        // DELETE api/<OrderStatusController>/5
        [HttpDelete("{id}")]
        public async Task<IActionResult> Delete(int id)
        {
            var rs = await m_dbContext.OrderStatuses.FindAsync(id);
            if (rs == null)
            {
                return NotFound();
            }
            try
            {
                m_dbContext.OrderStatuses.Remove(rs);
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

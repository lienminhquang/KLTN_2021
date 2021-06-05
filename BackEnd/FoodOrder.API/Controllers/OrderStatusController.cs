using AutoMapper;
using FoodOrder.API.Identity;
using FoodOrder.Core.Helpers;
using FoodOrder.Core.Inferstructer;
using FoodOrder.Core.Models;
using FoodOrder.Core.ViewModels.OrderStatuses;
using FoodOrder.Data;
using Microsoft.AspNetCore.Authorization;
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
    [Authorize(Roles = PolicyType.Admin)]
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
        private readonly IMapper _mapper;

        public OrderStatusController(ApplicationDBContext i_dbContext, IMapper mapper)
        {
            m_dbContext = i_dbContext;
            _mapper = mapper;
        }

        // GET: api/<OrderStatusController>
        [HttpGet]
        [AllowAnonymous]
        public async Task<IActionResult> Get(string sortOrder, string searchString, string currentFilter, int? pageNumber)
        {
            var orderStatus = from c in m_dbContext.OrderStatuses select c;
           

           

            orderStatus = Core.Helpers.Utilities<OrderStatus>.Sort(orderStatus, sortOrder, "ID");

            return Ok(new SuccessedResult<PaginatedList<OrderStatusVM>>(await PaginatedList<OrderStatusVM>.CreateAsync(orderStatus.Select(c => _mapper.Map<OrderStatusVM>(c)), pageNumber ?? 1, Core.Helpers.Configs.PageSize)));

        }

        // GET api/<OrderStatusController>/5
        [HttpGet("{id}")]
        [AllowAnonymous]
        public async Task<IActionResult> Get(int id)
        {
            var os = m_dbContext.OrderStatuses.FirstOrDefault(os => os.ID == id);
            
            return Ok(new SuccessedResult<OrderStatusVM>( _mapper.Map<OrderStatusVM>(os)));
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
            return CreatedAtAction(nameof(Get), rs.Entity.ID, rs.Entity);
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

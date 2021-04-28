using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

// For more information on enabling Web API for empty projects, visit https://go.microsoft.com/fwlink/?LinkID=397860

namespace FoodOrder.IdentityServer.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class HomesController : ControllerBase
    {
        // GET: api/<HomesController>
        [HttpGet]
        public IEnumerable<string> Get()
        {
            return new string[] { "value1", "value2" };
        }

        [HttpPost("/GetAccessToken")]
        public IActionResult GetAccessToken()
        {
            return RedirectToAction("/connect/token");
            //return Ok();
        }

        // GET api/<HomesController>/5
        [HttpGet("{id}")]
        public string Get(int id)
        {
            return "value";
        }

        // POST api/<HomesController>
        [HttpPost]
        public void Post([FromBody] string value)
        {
        }

        // PUT api/<HomesController>/5
        [HttpPut("{id}")]
        public void Put(int id, [FromBody] string value)
        {
        }

        // DELETE api/<HomesController>/5
        [HttpDelete("{id}")]
        public void Delete(int id)
        {
        }
    }
}

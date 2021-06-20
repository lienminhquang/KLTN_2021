using FoodOrder.API.Services;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using System;

namespace FoodOrder.API.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class HomeController : ControllerBase
    {
        private readonly ILogger<HomeController> _logger;
        private readonly HomeServices _homeServices;

        public HomeController(ILogger<HomeController> logger, HomeServices homeServices)
        {
            _logger = logger;
            _homeServices = homeServices;
        }

        [HttpGet]
        public IActionResult Index()
        {
            var rs = _homeServices.Get();
            return Ok(rs);
        }

        [HttpGet("privacy")]
        public IActionResult Privacy()
        {
            return Ok();
        }

        [HttpGet("secret")]
        [Authorize]
        public IActionResult Secret()
        {
            return Ok("Secret page");
        }

        [HttpGet("error")]
        [ResponseCache(Duration = 0, Location = ResponseCacheLocation.None, NoStore = true)]
        public IActionResult Error()
        {
            return Ok();
        }
    }
}

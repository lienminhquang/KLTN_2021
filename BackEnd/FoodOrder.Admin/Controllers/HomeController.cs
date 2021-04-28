using Admin.Models;
using Admin.Services;
using IdentityModel.Client;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Net.Http;
using System.Threading.Tasks;

namespace Admin.Controllers
{
    public class HomeController : Controller
    {
        private readonly ILogger<HomeController> _logger;
        private readonly ITokenService _tokenService;

        public HomeController(ILogger<HomeController> logger, ITokenService tokenService)
        {
            _logger = logger;
            _tokenService = tokenService;
        }

        public async Task<IActionResult> TestSecret()
        {
            var token = await _tokenService.GetToken("api1.read");
            using (var client = new HttpClient())
            {
                client.SetBearerToken(token.AccessToken);
                var result = await client.GetAsync("https://localhost:5001/api/home/secret");
                if(result.IsSuccessStatusCode)
                {
                    var model = await result.Content.ReadAsStringAsync();
                    return View(model);
                }
                else
                {
                    throw new Exception("Failed to get data from api");
                }
            }
        }

        public IActionResult Index()
        {
            return View();
        }

        public IActionResult Privacy()
        {
            return View();
        }

        [ResponseCache(Duration = 0, Location = ResponseCacheLocation.None, NoStore = true)]
        public IActionResult Error()
        {
            return View(new ErrorViewModel { RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier });
        }
    }
}

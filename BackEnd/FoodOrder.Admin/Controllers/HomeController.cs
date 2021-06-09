using FoodOrder.Admin.Extensions;
using FoodOrder.Admin.Identity;
using FoodOrder.Admin.Models;
using FoodOrder.Admin.Services;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Threading.Tasks;

namespace FoodOrder.Admin.Controllers
{
    [Authorize(Roles = RoleTypes.ManagerGroup)]
    public class HomeController : Controller
    {
        private readonly ILogger<HomeController> _logger;
        private readonly HomeServices _homeServices;

        public HomeController(ILogger<HomeController> logger, HomeServices homeServices)
        {
            _logger = logger;
            _homeServices = homeServices;
        }

        public async Task<IActionResult> IndexAsync()
        {
            var username = User.Identity.Name;

            DateTime startDay = DateTime.Now.AddDays(-30);

            var rs = await _homeServices.Get(this.GetTokenFromCookie());
            if(rs.IsSuccessed == false)
            {
                return this.RedirectToErrorPage(rs.ErrorMessage);
            }

            List<string> totalSalePerDayLables = new List<string>();
            for (int i = 0; i < 30; i++)
            {
                totalSalePerDayLables.Insert(0, startDay.ToString("MMM dd"));
                startDay = startDay.AddDays(-1);
            }
            ViewBag.TotalSalePerDayLables = totalSalePerDayLables;
           

            List<string> totalSalePerMonthLables = new List<string>();
            DateTime startMonth = DateTime.Now;
           
            for (int i = 0; i < 6; i++)
            {
                totalSalePerMonthLables.Insert(0, startMonth.ToString("MMMM"));
                startMonth = startMonth.AddMonths(-1);
            }
           
            ViewBag.TotalSalePerMonthLables = totalSalePerMonthLables;
           

            return View(rs.PayLoad);
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

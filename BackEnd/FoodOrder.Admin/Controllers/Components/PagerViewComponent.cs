using FoodOrder.Core.Helpers;
using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace FoodOrder.Admin.Controllers.Components
{
    public class PagerViewComponent : ViewComponent
    {
        public async Task<IViewComponentResult> InvokeAsync(PaginatedBase paginatedBase)
        {
            return await Task.FromResult((IViewComponentResult)View("Default", paginatedBase));
        }
    }
}

using Microsoft.AspNetCore.Http;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FoodOrder.Core.ViewModels.Categories
{
    public class CategoryCreateVM
    {
        public string Name { get; set; }
        public string Description { get; set; }
        public IFormFile ImageBinary { get; set; }
    }
}

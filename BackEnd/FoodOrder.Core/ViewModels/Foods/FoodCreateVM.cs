using FoodOrder.Core.ViewModels.Categories;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc.Rendering;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FoodOrder.Core.ViewModels.Foods
{
    public class FoodCreateVM
    {
        [Required(ErrorMessage ="Name is required!")]
        public string Name { get; set; }
        public string Description { get; set; }
        public double Price { get; set; }
        public int Count { get; set; }
        public IFormFile ImageData { get; set; }

        public MultiSelectList Categories { get; set; }
        public List<string> CategoryIDs { get; set; }
    }
}

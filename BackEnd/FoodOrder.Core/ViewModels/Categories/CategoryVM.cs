using FoodOrder.Core.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FoodOrder.Core.ViewModels.Categories
{
    public class CategoryVM
    {
        public int ID { get; set; }
        public string Name { get; set; }
        public string Description { get; set; }
        public string ImagePath { get; set; }

        public bool IsDeleted { get; set; }
        public DateTime? TimeDeleted { get; set; }

    }
}

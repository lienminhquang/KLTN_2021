using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace FoodOrderBackend.Models
{
    public class Category
    {
        public int ID { get; set; }
        public string Name { get; set; }
        public string Description { get; set; }

        public List<FoodCategory> FoodCategories { get; set; }
    }
}

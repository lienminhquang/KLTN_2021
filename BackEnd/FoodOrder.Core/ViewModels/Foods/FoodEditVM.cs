﻿using FoodOrder.Core.Models;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc.Rendering;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FoodOrder.Core.ViewModels.Foods
{
    public class FoodEditVM
    {
        public int ID { get; set; }
        public string Name { get; set; }
        public string Description { get; set; }
        public double Price { get; set; }
        public int Count { get; set; }
        public IFormFile ImageData { get; set; }

        public MultiSelectList Categories { get; set; }
        public List<string> CategoryIDs { get; set; }

        //public List<OrderDetail> OrderDetails { get; set; }
        //public List<Rating> Ratings { get; set; }
        //public List<FoodCategory> FoodCategories { get; set; }
        //public List<Cart> Carts { get; set; }
        //public List<Image> Images { get; set; }
    }
}

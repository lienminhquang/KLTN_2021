﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace FoodOrder.Core.Models
{
    public class Food
    {
        public int ID { get; set; }
        public string Name { get; set; }
        public string Description { get; set; }
        public double Price { get; set; }
        public int Count { get; set; }
        public string ImagePath { get; set; }

        public bool IsDeleted { get; set; }
        public DateTime? TimeDeleted { get; set; }

        public List<OrderDetail> OrderDetails { get; set; }
        public List<Rating> Ratings { get; set; }
        public List<FoodCategory> FoodCategories { get; set; }
        public List<Cart> Carts { get; set; }
        public List<SaleCampaignFood> SaleCampaignFoods { get; set; }
    }
}

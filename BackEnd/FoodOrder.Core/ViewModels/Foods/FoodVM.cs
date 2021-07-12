﻿using FoodOrder.Core.Models;
using FoodOrder.Core.ViewModels.Categories;
using FoodOrder.Core.ViewModels.SaleCampaigns;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FoodOrder.Core.ViewModels.Foods
{
    public class FoodVM
    {
        public int ID { get; set; }
        public string Name { get; set; }
        public string Description { get; set; }
        public double Price { get; set; }
        public int Count { get; set; }
        public string ImagePath { get; set; }

        public double AgvRating { get; set; }
        public int TotalRating { get; set; }

        public bool IsDeleted { get; set; }
        public DateTime? TimeDeleted { get; set; }


        public SaleCampaignVM SaleCampaignVM { get; set; }

        public List<CategoryVM> CategoryVMs { get; set; }

        //public List<OrderDetail> OrderDetails { get; set; }
        public List<Rating> Ratings { get; set; }
        public List<Cart> Carts { get; set; }
    }
}

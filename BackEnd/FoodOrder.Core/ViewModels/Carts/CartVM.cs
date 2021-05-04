﻿using FoodOrder.Core.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FoodOrder.Core.ViewModels.Carts
{
    public class CartVM
    {
        public Guid AppUserId { get; set; }
        public int FoodID { get; set; }
        public int Quantity { get; set; }

        public AppUser AppUser { get; set; }
        public Food Food { get; set; }
    }
}

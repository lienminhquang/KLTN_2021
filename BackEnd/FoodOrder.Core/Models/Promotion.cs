﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace FoodOrder.Core.Models
{
    public class Promotion
    {
        public int ID { get; set; }
        public string Name { get; set; }
        public string Code { get; set; }
        public string Desciption { get; set; }
        public DateTime StartDate { get; set; }
        public DateTime EndDate { get; set; }
        public int UseTimes { get; set; } // So lan co the su dung
        public float Percent { get; set; }
        public bool Enabled { get; set; }
        public double Max { get; set; }
        public double MinPrice { get; set; }
        public bool IsGlobal { get; set; }
        public int Priority { get; set; }
        public string ImagePath { get; set; }

        public bool IsDeleted { get; set; }
        public DateTime? TimeDeleted { get; set; }

        public List<Order> Orders { get; set; }
    }
}

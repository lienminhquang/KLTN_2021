using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace FoodOrderBackend.Models
{
    public class Promotion
    {
        public int ID { get; set; }
        public string Name { get; set; }
        public string Code { get; set; }
        public string Desciption { get; set; }
        public DateTime CreatedDate { get; set; }
        public DateTime StartDate { get; set; }
        public DateTime EndDate { get; set; }
        public int Amount { get; set; }
        public float Percent { get; set; }
        public bool Enabled { get; set; }
        public int Max { get; set; }
        public int MinPrice { get; set; }

        public List<Order> Orders { get; set; }
    }
}

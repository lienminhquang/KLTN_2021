using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace FoodOrder.Core.Models
{
    public class OrderStatus
    {
        public int ID { get; set; }
        public string Name { get; set; }
        public string Description { get; set; }

        public List<Order> Orders { get; set; }

        public static int DangChuanBi = 2;
        public static int DangGiao = 3;
        public static int DaNhan = 4;
        public static int DaHuy = 5;
    }
}

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FoodOrder.Core.Helpers
{
    public class PaginatedBase
    {
        public int PageIndex { get; set; }
        public int TotalPage { get; set; }
    }
}

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FoodOrder.Core.ViewModels
{
    public class CategoryFilterPagingRequest : PagingRequestBase
    {
        public List<int> CID { get; set; }
    }
}

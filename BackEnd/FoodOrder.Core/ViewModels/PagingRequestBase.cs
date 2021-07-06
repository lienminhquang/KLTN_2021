﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace FoodOrder.Core.ViewModels
{
    public class PagingRequestBase
    {
        public string SortOrder { get; set; }
        public string SearchString { get; set; }
        public int? PageNumber { get; set; }
        public int? PageSize { get; set; }
    }
}

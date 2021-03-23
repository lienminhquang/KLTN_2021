using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace FoodOrderBackend.Helpers
{
    class Configs
    {
        public static int PageSize = 2;
    }

    public class Utilities<T>
    { 
        public static IQueryable<T> Sort(IQueryable<T> source, string sortOrder, string defaultSortOrder)
        {
            if (String.IsNullOrEmpty(sortOrder))
            {
                sortOrder = defaultSortOrder;
            }
            bool descending = false;
            if (sortOrder.EndsWith("_desc"))
            {
                descending = true;
                sortOrder = sortOrder.Substring(0, sortOrder.Length - "_desc".Length);
            }
            if (descending)
            {
                return source.OrderByDescending(c => EF.Property<object>(c, sortOrder));
            }
            else
            {
                return source.OrderBy(c => EF.Property<object>(c, sortOrder));
            }
        }
    }
}

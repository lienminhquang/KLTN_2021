using Microsoft.AspNetCore.Http;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net.Http.Headers;
using System.Threading.Tasks;

namespace FoodOrder.Core.Helpers
{
    public class Utils
    {

    }

    public class Configs
    {
        public static int PageSize = -1; // -1 mean get all
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

            var property = typeof(T).GetProperty(sortOrder);
            if (property == null)
            {
                return source;
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

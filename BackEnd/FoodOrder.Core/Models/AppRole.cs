using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Identity;

namespace FoodOrder.Core.Models
{
    public class AppRole : IdentityRole<Guid>
    {
        public string Description { get; set; }

        public bool IsDeleted { get; set; }
        public DateTime? TimeDeleted { get; set; }
    }
}

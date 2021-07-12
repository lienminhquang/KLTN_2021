using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FoodOrder.Core.Models
{
    public class Address
    {
        public int ID { get; set; }
        public Guid AppUserID { get; set; }
        public String Name { get; set; }
        public String AddressString { get; set; }

        public bool IsDeleted { get; set; }
        public DateTime? TimeDeleted { get; set; }

        public AppUser AppUser { get; set; }
    }
}

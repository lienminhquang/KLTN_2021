using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FoodOrder.Core.ViewModels.Addresses
{
    public class AddressEditVM
    {
        public int ID { get; set; }
        public Guid AppUserID { get; set; }
        public String Name { get; set; }
        public String AddressString { get; set; }
    }
}

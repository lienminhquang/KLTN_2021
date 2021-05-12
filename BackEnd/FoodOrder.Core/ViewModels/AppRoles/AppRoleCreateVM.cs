using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FoodOrder.Core.ViewModels.AppRoles
{
    public class AppRoleCreateVM
    {
        public string Description { get; set; }
        public virtual string Name { get; set; }
        public virtual string NormalizedName { get; set; }
    }
}

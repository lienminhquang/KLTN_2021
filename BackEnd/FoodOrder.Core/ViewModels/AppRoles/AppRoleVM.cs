using FoodOrder.Core.ViewModels.Users;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FoodOrder.Core.ViewModels.AppRoles
{
    public class AppRoleVM
    {
        public Guid Id { get; set; }
        public string Description { get; set; }

        public bool IsDeleted { get; set; }
        public DateTime? TimeDeleted { get; set; }

        public virtual string Name { get; set; }

        public List<UserVM> UserVMs { get; set; }
    }
}

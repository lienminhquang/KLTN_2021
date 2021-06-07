using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace FoodOrder.Admin.Identity
{
    public static class RoleTypes
    {
        public const string Admin = "admin";
        public const string Manager = "manager";
        public const string ManagerGroup = Admin + "," + Manager;
    }
}

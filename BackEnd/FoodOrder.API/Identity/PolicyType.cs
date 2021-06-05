using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace FoodOrder.API.Identity
{
    public static class PolicyType
    {
        public const string Admin = "admin";
        public const string Manager = "manager";
        public const string User = "user";
        public const string RegisteredUser = "registered_user";
    }
}

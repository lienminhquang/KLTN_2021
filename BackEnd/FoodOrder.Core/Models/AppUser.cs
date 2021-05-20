using Microsoft.AspNetCore.Identity;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace FoodOrder.Core.Models
{
    public class AppUser : IdentityUser<Guid>
    {
        public AppUser()
        {

        }
        public AppUser(string i_username):base(i_username)
        {
            
        }

        public string FirstName { get; set; }
        public string LastName { get; set; }
        public DateTime DateOfBirth { get; set; }

        public List<Order> Orders { get; set; }
        public List<Rating> Ratings { get; set; }
        public List<Cart> Carts { get; set; }
        public List<Address> Addresses { get; set; }
    }
}

﻿using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FoodOrder.Core.ViewModels.Users
{
    public class RegisterRequest
    {
        public string FirstName { get; set; }

        public string LastName { get; set; }

        //[DataType(DataType.Date)]
        //public DateTime Dob { get; set; }

        //[DataType(DataType.EmailAddress)]
        //public string Email { get; set; }

        public string PhoneNumber { get; set; }

        [DataType(DataType.Password)]
        public string Password { get; set; }

        //[DataType(DataType.Password)]
        //public string ConfirmPassword { get; set; }
    }
}

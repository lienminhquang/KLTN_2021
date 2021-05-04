using FluentValidation;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FoodOrder.Core.ViewModels.Users
{
    public class LoginRequestValidator : AbstractValidator<LoginRequest>
    {
        public LoginRequestValidator()
        {
            RuleFor(x => x.Username).NotEmpty().WithMessage("Username must not be null!");
            RuleFor(x => x.Password).NotEmpty().WithMessage("Password must not be null!")
                .MinimumLength(6).WithMessage("Password must longer atlast 6 characters!");
        }
    }
}

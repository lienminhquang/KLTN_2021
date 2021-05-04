using FluentValidation;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FoodOrder.Core.ViewModels.Users
{
    public class RegisterRequestValidator : AbstractValidator<RegisterRequest>
    {
        public RegisterRequestValidator()
        {
            RuleFor(x => x.FirstName).NotEmpty().WithMessage("This field must not be null!");
            RuleFor(x => x.LastName).NotEmpty().WithMessage("This field must not be null!");
            RuleFor(x => x.Password).NotEmpty().WithMessage("This field must not be null!");
            RuleFor(x => x.Dob).NotEmpty().WithMessage("This field must not be null!");
            RuleFor(x => x.Email).NotEmpty().WithMessage("This field must not be null!");
            RuleFor(x => x).Custom((request, context) =>
            {
                if (request.Password != request.ConfirmPassword)
                {
                    context.AddFailure("ConfirmPassword is not match!");
                }
            });
        }
    }
}

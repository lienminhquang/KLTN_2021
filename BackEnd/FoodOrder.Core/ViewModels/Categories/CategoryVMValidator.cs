using FluentValidation;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FoodOrder.Core.ViewModels.Categories
{
    public class CategoryVMValidator : AbstractValidator<CategoryVM>
    {
        public CategoryVMValidator()
        {
            RuleFor(x => x.Name).NotEmpty().WithMessage("Name cannot be null!");
        }
    }
}

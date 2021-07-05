using FluentValidation;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using UnderSea.Bll.Dtos.Unit;

namespace UnderSea.Bll.Validation.Validators.Buy
{
    public class BuyUnitValidator : AbstractValidator<BuyUnitDto>
    {

        public BuyUnitValidator()
        {
            RuleFor(dto => dto.Units).NotEmpty().WithMessage("Legalább egy egység vásárlása kötelező.").OverridePropertyName("units").WithName("units");
        }

    }
}

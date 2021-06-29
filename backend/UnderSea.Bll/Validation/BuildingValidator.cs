using FluentValidation;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using UnderSea.Bll.Dtos;

namespace UnderSea.Bll.Validation
{
    public class BuildingValidator : AbstractValidator<BuyBuildingDto>
    {
        public BuildingValidator()
        {
            RuleFor(x => x.BuildingId).NotNull();
        }
    }
}

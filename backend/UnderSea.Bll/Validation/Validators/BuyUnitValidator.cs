using FluentValidation;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using UnderSea.Bll.Dtos;
using UnderSea.Dal.Data;

namespace UnderSea.Bll.Validation
{
    public class BuyUnitValidator : AbstractValidator<BuyUnitDto>
    {
        private readonly UnderSeaDbContext _context;

        public BuyUnitValidator(UnderSeaDbContext context)
        {
            this._context = context;
            RuleFor(unit => unit.UnitId).NotNull().MustAsync(async (unitId, cancellation) 
                => await UnitExist(unitId)).WithMessage("Nincs ilyen egység.");
        }

        private async Task<bool> UnitExist(int unitId)
            => await _context.Units.Where(u => u.Id == unitId).AnyAsync();
    }
}

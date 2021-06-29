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
    public class BuyBuildingValidator : AbstractValidator<BuyBuildingDto>
    {
        private readonly UnderSeaDbContext _context;

        public BuyBuildingValidator(UnderSeaDbContext context)
        {
            this._context = context;
            RuleFor(building => building.BuildingId).NotNull().MustAsync(async (buildingId, cancellation) =>await BuildingExist(buildingId)).WithMessage("Nem létezik ilyen építmény!");
        }

        private async Task<bool> BuildingExist(int buildingId) 
            => await _context.Buildings.Where(b => b.Id == buildingId).AnyAsync();
    }
}

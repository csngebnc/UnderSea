using FluentValidation;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using UnderSea.Bll.Dtos;
using UnderSea.Bll.Services.Interfaces;
using UnderSea.Dal.Data;

namespace UnderSea.Bll.Validation
{
    public class SendAttackValidator : AbstractValidator<SendAttackDto>
    {
        private readonly UnderSeaDbContext _context;
        private readonly IIdentityService identityService;

        public SendAttackValidator(UnderSeaDbContext context, IIdentityService identityService)
        {
            this._context = context;
            RuleFor(attack => attack.AttackedCountryId).NotNull().MustAsync(async (countryId, cancellation) => await CountryExist(countryId)).WithMessage("Nem létezik ilyen ország, amit megtámadtál!");
            RuleForEach(attack => attack.Units).NotNull().SetValidator(new AttackUnitValidator(context));
        }

        private async Task<bool> CountryExist(int countryId)
           => await _context.Countries.Where(b => b.Id == countryId).AnyAsync();

        public class AttackUnitValidator : AbstractValidator<AttackUnitDto>
        {
            private readonly UnderSeaDbContext _context;

            public AttackUnitValidator(UnderSeaDbContext context)
            {
                this._context = context;
                RuleFor(attackUnit => attackUnit.UnitId).NotNull().MustAsync(async (unitId, cancellation) => await UnitExist(unitId)).WithMessage("Nem létezik ilyen egység!");
                RuleFor(attackUnit => attackUnit.Count).NotNull().GreaterThan(0).WithMessage("Legalább 1 egységet el kell küldened!");
            }

            private async Task<bool> UnitExist(int UnitId)
                => await _context.Countries.Where(b => b.Id == UnitId).AnyAsync();
        }
    }
}

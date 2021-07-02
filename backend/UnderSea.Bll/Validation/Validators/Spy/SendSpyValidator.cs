using FluentValidation;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using UnderSea.Bll.Dtos.Spy;
using UnderSea.Dal.Data;

namespace UnderSea.Bll.Validation.Validators.Spy
{
    class SendSpyValidator : AbstractValidator<SendSpyDto>
    {
        private readonly UnderSeaDbContext _context;

        public SendSpyValidator(UnderSeaDbContext context)
        {
            this._context = context;
            RuleFor(spy => spy.SpiedCountryId).NotNull().MustAsync(async (countryId, cancellation) => await CountryExist(countryId))
                .WithMessage("Nem létezik ilyen ország, amit kémlelnél!").WithName("spiedCountryId").OverridePropertyName("spiedCountryId");
            RuleFor(spy => spy.SpyCount).GreaterThan(0).WithMessage("Legalább egy kémet el kell küldened a kémkedéshez!")
                .WithName("spyCount").OverridePropertyName("spyCount");
        }

        private async Task<bool> CountryExist(int countryId)
            => await _context.Countries.Where(b => b.Id == countryId).AnyAsync();
    }
}

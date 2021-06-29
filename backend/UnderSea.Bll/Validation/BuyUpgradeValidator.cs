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
    public class BuyUpgradeValidator : AbstractValidator<BuyUpgradeDto>
    {
        private readonly UnderSeaDbContext _context;

        public BuyUpgradeValidator(UnderSeaDbContext context)
        {
            this._context = context;
            RuleFor(upgrade => upgrade.UpgradeId).NotNull().MustAsync(async (upgradeId, cancellation) 
                => await UpgradeExist(upgradeId)).WithMessage("Nincs ilyen fejlesztés.");
        }

        private async Task<bool> UpgradeExist(int upgradeId)
            => await _context.Upgrades.Where(u => u.Id == upgradeId).AnyAsync();
    }
}

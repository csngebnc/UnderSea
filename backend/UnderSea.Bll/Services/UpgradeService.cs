using AutoMapper;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using UnderSea.Bll.Dtos;
using UnderSea.Bll.Services.Interfaces;
using UnderSea.Dal.Data;

namespace UnderSea.Bll.Services
{
    public class UpgradeService
    {
        private readonly UnderSeaDbContext _context;
        private readonly IIdentityService _identityService;
        private readonly IMapper _mapper;

        public UpgradeService(UnderSeaDbContext context, IMapper mapper, IIdentityService identityService)
        {
            _context = context;
            _mapper = mapper;
            _identityService = identityService;
        }

        public async Task<IEnumerable<UpgradeDto>> GetUpgrades()
        {
            var country = await _context.Countries
                .Where(u => u.OwnerId == _identityService.GetCurrentUserId())
                .Include(c => c.World)
                .Include(c => c.ActiveUpgradings)
                .Include(c => c.CountryUpgrades)
                .FirstOrDefaultAsync();

            var upgrades = await _context.Upgrades
                .Include(u => u.UpgradeEffects)
                    .ThenInclude(ue => ue.Effect)
                .ToListAsync();


            return upgrades.Select(upgrade =>
            {
                var remaining_time = country.ActiveUpgradings
                .Where(u => u.UpgradeId == upgrade.Id)
                .FirstOrDefault()
                .EstimatedFinish - country.World.Round;

                return new UpgradeDto
                {
                    Id = upgrade.Id,
                    Name = upgrade.Name,
                    Effects = _mapper.Map<ICollection<EffectDto>>(upgrade.UpgradeEffects.Select(ue => ue.Effect)),
                    DoesExist = country.CountryUpgrades.Select(cu => cu.UpgradeId).Contains(upgrade.Id),
                    IsUnderConstruction = country.ActiveUpgradings.Select(au => au.UpgradeId).Contains(upgrade.Id),
                    RemainingTime = remaining_time > 0 ? remaining_time : 0
                };
            });
        }

        public async Task BuyUpgrade(BuyUpgradeDto buyUpgradeDto)
        {
            var country = await _context.Countries
                            .Where(c => c.OwnerId == _identityService.GetCurrentUserId())
                            .Include(c => c.World)
                            .FirstOrDefaultAsync();

            var activeupgrade = await _context.ActiveUpgradings.Where(c => c.CountryId == country.Id).FirstOrDefaultAsync();
            if (activeupgrade != null) throw new InvalidOperationException();

            if(await _context.CountryUpgrades.AnyAsync(c => c.CountryId == country.Id && c.UpgradeId == buyUpgradeDto.UpgradeId) &&
                await _context.ActiveUpgradings.AnyAsync(au => au.CountryId == country.Id && au.UpgradeId == buyUpgradeDto.UpgradeId))
            {
                throw new Exception();
            }

            var upgrade = await _context.Upgrades.FindAsync(buyUpgradeDto.UpgradeId);

            _context.ActiveUpgradings.Add(new Model.Models.ActiveUpgrading
            {
                CountryId = country.Id,
                UpgradeId = buyUpgradeDto.UpgradeId,
                EstimatedFinish = country.World.Round + upgrade.UpgradeTime
            });

            await _context.SaveChangesAsync();
        }
    }
}

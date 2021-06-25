using AutoMapper;
using AutoMapper.QueryableExtensions;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
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

            var result = new List<UpgradeDto>();
            foreach (var upgrade in upgrades)
            {
                var remaining_time = country.ActiveUpgradings.Where(u => u.UpgradeId == upgrade.Id).FirstOrDefault()
                    .EstimatedFinish - country.World.Round;

                result.Add(
                    new UpgradeDto
                    {
                        Id = upgrade.Id,
                        Name = upgrade.Name,
                        Effects = _mapper.Map<ICollection<EffectDto>>(upgrade.UpgradeEffects.Select(ue => ue.Effect)),
                        DoesExist = country.CountryUpgrades.Select(cu => cu.UpgradeId).Contains(upgrade.Id),
                        IsUnderConstruction = country.ActiveUpgradings.Select(au => au.UpgradeId).Contains(upgrade.Id),
                        RemainingTime = remaining_time > 0 ? remaining_time : 0
                    }
                );
            }

            return result;
        }

        public async Task BuyUpgrade(BuyUpgradeDto buyUpgradeDto)
        {
            var country = await _context.Countries
                            .Where(c => c.OwnerId == _identityService.GetCurrentUserId())
                            .Include(c => c.World)
                            .FirstOrDefaultAsync();

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

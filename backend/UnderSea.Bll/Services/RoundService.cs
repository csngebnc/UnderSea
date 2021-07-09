using AutoMapper;
using Microsoft.AspNetCore.SignalR;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using UnderSea.Bll.Extensions;
using UnderSea.Bll.Services.Interfaces;
using UnderSea.Bll.Validation.Exceptions;
using UnderSea.Dal.Data;
using UnderSea.Model.Constants;
using UnderSea.Model.Models;
using UnderSea.Model.Models.Materials;

namespace UnderSea.Bll.Services
{
    public class RoundService : IRoundService
    {
        private readonly UnderSeaDbContext _context;
        private readonly IHubService _hubService;

        public RoundService(UnderSeaDbContext context, IHubService hubService)
        {
            _context = context;
            _hubService = hubService;
        }

        public void RemovePreviousRoundEvents(ICollection<Country> countries)
        {
            foreach (var country in countries)
            {
                foreach (var countryEvent in country.CountryEvents)
                {
                    foreach (var effect in countryEvent.Event.EventEffects)
                    {
                        effect.Effect.RemoveEffect(country);
                    }
                }
            }
        }

        public void PayMaterial(ICollection<Country> countries)
        {
            foreach(var country in countries)
            {
                foreach(var material in country.CountryMaterials)
                {
                    if(material.Material.MaterialType == MaterialTypeConstants.Pearl)
                    {
                        material.BaseProduction = country.Population * EffectConstants.PopulationPearlMultiplier;
                    }
                    material.Amount += (int)Math.Round(material.BaseProduction * material.Multiplier); 
                }
            }
        }

        public void PayMercenaryAndFeedSoldiers(ICollection<Country> countries)
        {
            foreach (var country in countries)
            {
                foreach(var unit in country.CountryUnits.OrderByDescending(c => c.Unit.UnitMaterials.Sum(c => c.Amount)))
                {
                    int requiredFood = unit.Unit.SupplyPerRound * unit.Count;
                    int requiredMercenary = unit.Unit.MercenaryPerRound * unit.Count;

                    var coralCountryMaterial = country.CountryMaterials.SingleOrDefault(cm => cm.Material.MaterialType == MaterialTypeConstants.Coral);
                    var pearlCountryMaterial = country.CountryMaterials.SingleOrDefault(cm => cm.Material.MaterialType == MaterialTypeConstants.Pearl);

                    if (requiredFood <= coralCountryMaterial.Amount && requiredMercenary <= pearlCountryMaterial.Amount)
                    {
                        coralCountryMaterial.Amount -= requiredFood;
                        pearlCountryMaterial.Amount -= requiredMercenary;
                    }
                    else
                    {
                        int numberOfAlive = 0;

                        for(int i = 0; i <= unit.Count; i++)
                        {
                            int food = unit.Unit.SupplyPerRound * i;
                            int mercenary = unit.Unit.MercenaryPerRound * i;

                            if (food <= coralCountryMaterial.Amount && mercenary <= pearlCountryMaterial.Amount)
                            {
                                numberOfAlive = i;
                            }
                            else
                            {
                                break;
                            }                          
                        }

                        unit.Count = numberOfAlive;

                        coralCountryMaterial.Amount -= numberOfAlive * unit.Unit.SupplyPerRound;
                        pearlCountryMaterial.Amount -= numberOfAlive * unit.Unit.MercenaryPerRound;
                    }
                }
            }
        }

        public void MakeUpgrades(ICollection<Country> countries, World world)
        {
            foreach (var country in countries)
            {
                foreach(var upgrade in country.ActiveUpgradings.Where(c => c.EstimatedFinish == world.Round+1))
                {
                    var newCountryUpgrade = new CountryUpgrade()
                    {
                        CountryId = country.Id,
                        UpgradeId = upgrade.UpgradeId,
                    };

                    _context.CountryUpgrades.Add(newCountryUpgrade);

                    foreach(var effect in upgrade.Upgrade.UpgradeEffects)
                    {
                        effect.Effect.ApplyEffect(country);
                    }

                    _context.ActiveUpgradings.Remove(upgrade);
                }
            }
        }

        public void MakeBuildings(ICollection<Country> countries, World world)
        {
            foreach (var country in countries)
            {
                foreach (var building in country.ActiveConstructions
                    .Where(c => c.EstimatedFinish == world.Round+1))
                {
                    var cbuilding = country.CountryBuildings
                        .Where(c => c.BuildingId == building.BuildingId)
                        .FirstOrDefault();

                    if(cbuilding == null)
                    {
                        var newCountryBuilding = new CountryBuilding()
                        {
                            CountryId = country.Id,
                            Count = 1,
                            BuildingId = building.BuildingId,
                        };

                        _context.CountryBuildings.Add(newCountryBuilding);
                    }
                    else
                    {
                        cbuilding.Count++;
                    }

                    foreach (var effect in building.Building.BuildingEffects)
                    {
                        effect.Effect.ApplyEffect(country);
                    }

                    _context.ActiveConstructions.Remove(building);
                }
            }
        }

        public void Fights(ICollection<Country> countries, World world, int generalId)
        {
            foreach (var attackerCountry in countries)
            {
                foreach(var attack in attackerCountry.Attacks.Where(c => c.WinnerId == null && world.Round == c.AttackRound))
                {
                    var attackUnits = attack.AttackUnits;
                    var defenseUnits = attack.DefenderCountry.CountryUnits;

                    double attackPoints = 0;
                    double defensePoints = 0;

                    foreach (var unit in attackUnits)
                    {
                        attackPoints += (unit.Unit.UnitLevels.SingleOrDefault(ul => ul.Level == unit.GetLevel()).AttackPoint + attackerCountry.FightPoint.BonusAttackPoint)* unit.Count;
                    }

                    foreach (var unit in defenseUnits)
                    {
                        defensePoints += unit.Unit.UnitLevels.SingleOrDefault(ul => ul.Level == unit.GetLevel()).DefensePoint * unit.Count;
                    }

                    attackPoints *= attackerCountry.FightPoint.AttackPointMultiplier * (1 - new Random().Next(-5, 5) / 100);
                    defensePoints *= attack.DefenderCountry.FightPoint.DefensePointMultiplier;

                    var attackerGenerals = attackUnits.FirstOrDefault(u => u.UnitId == generalId).Count;
                    var defenderGenerals = defenseUnits.FirstOrDefault(u => u.UnitId == generalId)?.Count ?? 0;

                    attackPoints *= (1 + (attackerGenerals - 1) * UnitValueConstants.GeneralBonus);
                    defensePoints *= (1 + defenderGenerals * UnitValueConstants.GeneralBonus);

                    if (attackPoints-defensePoints > 0)
                    {
                        attack.WinnerId = attackerCountry.OwnerId;

                        foreach (var unit in defenseUnits)
                        {
                            unit.Count = (int)Math.Round(unit.Count * 0.9);
                        }

                        foreach (var material in attack.DefenderCountry.CountryMaterials)
                        {
                            attackerCountry.CountryMaterials.SingleOrDefault(cm => cm.MaterialId == material.MaterialId).Amount += material.Amount;
                            material.Amount /= 2;
                        }
                    } 
                    else
                    {
                        attack.WinnerId = attack.DefenderCountry.OwnerId;

                        foreach (var unit in attackUnits)
                        {
                            unit.Count = (int)Math.Round(unit.Count * 0.9);
                        }
                    }
                }
            }

        }

        public void Spies(ICollection<SpyReport> spyReports, int generalId)
        {
            foreach (var spyreport in spyReports)
            {
                var attackerCountry = spyreport.SpySenderCountry;
                var defenderCountry = spyreport.SpiedCountry;

                var attackPercentage = 60 + (spyreport.NumberOfSpies - 1) * 5;
                var defenderSpies = defenderCountry.CountryUnits.Where(cu => cu.Unit.Name == UnitNameConstants.Felfedezo).FirstOrDefault();
                var defensePercentage = defenderSpies == null ? 0 : defenderSpies.Count * 5;

                var diff = attackPercentage - defensePercentage;
                if(diff <= 0)
                {
                    spyreport.WinnerId = defenderCountry.OwnerId;
                }
                else
                {
                    var resultNum = new Random().Next(0, 100);
                    if(resultNum <= diff)
                    {
                        spyreport.WinnerId = attackerCountry.OwnerId;
                        var defenseUnits = defenderCountry.CountryUnits;
                        spyreport.DefensePoints = 0;
                        foreach (var unit in defenseUnits)
                        {
                            spyreport.DefensePoints += unit.Unit.UnitLevels.SingleOrDefault(ul => ul.Level == unit.GetLevel()).DefensePoint * unit.Count;
                        }

                        var defenderGenerals = defenseUnits.SingleOrDefault(u => u.UnitId == generalId)?.Count ?? 0;

                        spyreport.DefensePoints = (int)(spyreport.DefensePoints* (1+defenderCountry.FightPoint.DefensePointMultiplier));
                        spyreport.DefensePoints = (int)(spyreport.DefensePoints * (1+defenderGenerals * UnitValueConstants.GeneralBonus));
                        attackerCountry.CountryUnits.Where(cu => cu.Unit.Name == UnitNameConstants.Felfedezo).FirstOrDefault().Count += spyreport.NumberOfSpies;
                    }
                    else
                    {
                        spyreport.WinnerId = defenderCountry.OwnerId;
                    }
                }
            }
        }

        public async Task ReturnAttackUnits(ICollection<Country> countries, World world)
        {
            foreach (var attackerCountry in countries)
            {
                foreach (var attack in attackerCountry.Attacks.Where(c => world.Round == c.AttackRound)) 
                {
                    var attackUnits = attack.AttackUnits;

                    foreach(var attackUnit in attackUnits)
                    {
                        if(attackUnit.BattlesPlayed < attackUnit.Unit.UnitLevels.Max(ul => ul.MinimumBattles))
                        {
                            attackUnit.BattlesPlayed++;
                        }
                        if(attackerCountry.CountryUnits.Any(cu => cu.UnitId == attackUnit.UnitId && cu.BattlesPlayed == attackUnit.BattlesPlayed))
                        {
                            var unit = attackerCountry.CountryUnits.SingleOrDefault(cu => cu.UnitId == attackUnit.UnitId && cu.BattlesPlayed == attackUnit.BattlesPlayed);
                            unit.Count += attackUnit.Count;
                        }
                        else
                        {
                            
                            attackerCountry.CountryUnits.Add(new CountryUnit
                            {
                                CountryId = attackerCountry.Id,
                                UnitId = attackUnit.UnitId,
                                Count = attackUnit.Count,
                                BattlesPlayed = attackUnit.BattlesPlayed
                            });
                            
                        }
                    }
                }
            }
            await _context.SaveChangesAsync();
        }

        public void CalculatePoints(ICollection<Country> countries)
        {
            foreach (var country in countries)
            {
                int populationPoints = country.Population * PointConstants.Population;

                int buildingPoints = 0;
                foreach(var building in country.CountryBuildings)
                {
                    buildingPoints += building.Count * PointConstants.Buildings;
                }

                int upgradePoints = 0;
                foreach (var upgrade in country.CountryUpgrades)
                {
                    upgradePoints += PointConstants.Science;
                }

                int militaryPoints = 0;
                foreach(var unit in country.CountryUnits)
                {
                    switch (unit.Unit.Name)
                    {
                        case UnitNameConstants.RohamFoka:
                            militaryPoints += unit.Count * PointConstants.Military;
                            break;
                        case UnitNameConstants.Csatacsiko:
                            militaryPoints += unit.Count * PointConstants.Military;
                            break;
                        case UnitNameConstants.Lezercapa:
                            militaryPoints += unit.Count * PointConstants.MilitaryShark;
                            break;
                        case UnitNameConstants.Felfedezo:
                            militaryPoints += unit.Count * PointConstants.Spy;
                            break;
                        default:
                            militaryPoints += unit.Count * PointConstants.Military;
                            break;
                    }
                    militaryPoints += unit.Count * PointConstants.Military;
                }

                country.Owner.Points = populationPoints + buildingPoints + upgradePoints + militaryPoints;
            }
        }

        public void GenerateCountryEvents(ICollection<Country> countries, List<Event> events, World world)
        {
            var random = new Random();

            foreach (var country in countries)
            {
                var randomNumber = random.Next(0, 10);
                if(randomNumber == 5)
                {
                    var eventNumber = random.Next(0, events.Count);
                    country.CountryEvents.Add(new Model.Models.Joins.CountryEvent
                    {
                        CountryId = country.Id,
                        EventId = events[eventNumber].Id,
                        EventRound = world.Round
                    });
                    foreach (var eventEffect in events[eventNumber].EventEffects)
                    {
                        eventEffect.Effect.ApplyEffect(country);
                    }
                }
            }
        }

        public async Task NextRound()
        {
            var world = await _context.Worlds.FirstOrDefaultAsync();
            if (world == null)
            {
                throw new NotExistsException("Nem létezik ilyen világ.");
            }

            var countries = await _context.Countries.Include(e => e.CountryUnits)
                                                        .ThenInclude(e => e.Unit)
                                                            .ThenInclude(e => e.UnitMaterials)
                                                    .Include(e => e.FightPoint)
                                                    .Include(e => e.CountryMaterials)
                                                        .ThenInclude(e => e.Material)
                                                    .Include(e => e.Attacks)
                                                        .ThenInclude(e => e.AttackUnits)
                                                            .ThenInclude(e => e.Unit)
                                                                .ThenInclude(u => u.UnitLevels)
                                                    .Include(e => e.Attacks)
                                                        .ThenInclude(e => e.DefenderCountry)
                                                            .ThenInclude(e => e.FightPoint)
                                                    .Include(e => e.Attacks)
                                                        .ThenInclude(e => e.DefenderCountry)
                                                            .ThenInclude(e => e.CountryUnits)
                                                    .Include(e => e.CountryBuildings)
                                                        .ThenInclude(e => e.Building)
                                                    .Include(e => e.CountryUpgrades)
                                                        .ThenInclude(e => e.Upgrade)
                                                    .Include(e => e.ActiveUpgradings)
                                                        .ThenInclude(e => e.Upgrade)
                                                            .ThenInclude(e => e.UpgradeEffects)
                                                                .ThenInclude(e => e.Effect)
                                                    .Include(e => e.ActiveConstructions)
                                                        .ThenInclude(e => e.Building)
                                                            .ThenInclude(e => e.BuildingEffects)
                                                                .ThenInclude(e => e.Effect)
                                                    .Include(e => e.Owner)
                                                    .Include(c => c.CountryEvents)
                                                        .ThenInclude(ce => ce.Event)
                                                            .ThenInclude(e => e.EventEffects)
                                                                .ThenInclude(ee => ee.Effect)
                                                    .ToListAsync();

            var spyreports = await _context.SpyReports.Where(sr => sr.Round == world.Round)
                .Include(sr => sr.SpySenderCountry)
                    .ThenInclude(sc => sc.CountryUnits)
                        .ThenInclude(cu => cu.Unit)
                .Include(sr => sr.SpiedCountry)
                    .ThenInclude(sc => sc.CountryUnits)
                        .ThenInclude(cu => cu.Unit)
                .ToListAsync();

            var events = await _context.Events
                .Include(e => e.EventEffects)
                    .ThenInclude(ee => ee.Effect)
                .ToListAsync();

            var generalId= (await _context.Units.SingleOrDefaultAsync(u => u.Name == UnitNameConstants.Hadvezer)).Id;

            using (var transaction = _context.Database.BeginTransaction())
            {
                RemovePreviousRoundEvents(countries);

                PayMaterial(countries);

                PayMercenaryAndFeedSoldiers(countries);

                MakeUpgrades(countries,world);

                MakeBuildings(countries,world);

                Fights(countries,world, generalId);

                Spies(spyreports, generalId);

                await ReturnAttackUnits(countries, world);

                CalculatePoints(countries);

                GenerateCountryEvents(countries, events, world);

                world.Round++;

                await _context.SaveChangesAsync();
                await transaction.CommitAsync();
            }

            await _hubService.SendNewRoundMessage(world.Round);
        }
    }
}

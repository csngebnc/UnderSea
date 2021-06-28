using AutoMapper;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using UnderSea.Bll.Extensions;
using UnderSea.Bll.Services.Interfaces;
using UnderSea.Dal.Data;
using UnderSea.Model.Constants;
using UnderSea.Model.Models;

namespace UnderSea.Bll.Services
{
    public class RoundService : IRoundService
    {
        private readonly UnderSeaDbContext _context;

        public RoundService(UnderSeaDbContext context)
        {
            _context = context;
        }

        public void PayTax(ICollection<Country> countries)
        {
            foreach(var country in countries)
            {
                country.Pearl += (int)Math.Round(country.Production.BasePearlProduction * country.Production.PearlProductionMultiplier);
            }
        }

        public void PayCoral(ICollection<Country> countries)
        {
            foreach (var country in countries)
            {
                country.Coral += (int)Math.Round(country.Production.BaseCoralProduction * country.Production.CoralProductionMultiplier);
            }
        }

        public void PayMercenaryAndFeedSoldiers(ICollection<Country> countries)
        {
            foreach (var country in countries)
            {
                foreach(var unit in country.CountryUnits.OrderByDescending(c => c.Unit.Price))
                {
                    int requiredFood = unit.Unit.SupplyPerRound * unit.Count;
                    int requiredMercenary = unit.Unit.MercenaryPerRound * unit.Count;

                    if(requiredFood <= country.Coral && requiredMercenary <= country.Pearl)
                    {
                        country.Coral -= requiredFood;
                        country.Pearl -= requiredMercenary;
                    }
                    else
                    {
                        int numberOfAlive = 0;

                        for(int i = 0; i <= unit.Count; i++)
                        {
                            int food = unit.Unit.SupplyPerRound * i;
                            int mercenary = unit.Unit.MercenaryPerRound * i;

                            if (food <= country.Coral && mercenary <= country.Pearl)
                            {
                                numberOfAlive = i;
                            }
                            else
                            {
                                break;
                            }                          
                        }

                        unit.Count = numberOfAlive;

                        country.Coral -= numberOfAlive * unit.Unit.SupplyPerRound;
                        country.Pearl -= numberOfAlive * unit.Unit.MercenaryPerRound;
                    }
                }
            }
        }

        public void MakeUpgrades(ICollection<Country> countries, World world)
        {
            foreach (var country in countries)
            {
                foreach(var upgrade in country.ActiveUpgradings.Where(c => c.EstimatedFinish == world.Round))
                {
                    CountryUpgrade newCountryUpgrade = new CountryUpgrade()
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
                foreach (var building in country.ActiveConstructions.Where(c => c.EstimatedFinish == world.Round))
                {
                    var cbuilding = country.CountryBuildings.Where(c => c.BuildingId == building.BuildingId).FirstOrDefault();

                    if(cbuilding == null)
                    {
                        CountryBuilding newCountryBuilding = new CountryBuilding()
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

        public void Fights(ICollection<Country> countries, World world)
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
                        attackPoints += unit.Unit.AttackPoint;
                    }

                    foreach (var unit in defenseUnits)
                    {
                        defensePoints += unit.Unit.DefensePoint;
                    }

                    attackPoints *= attackerCountry.FightPoint.AttackPointMultiplier * (1 - new Random().Next(-5, 5) / 100);
                    defensePoints *= attack.DefenderCountry.FightPoint.DefensePointMultiplier;

                    if (attackPoints-defensePoints > 0)
                    {
                        attack.WinnerId = attackerCountry.OwnerId;

                        foreach (var unit in defenseUnits)
                        {
                            unit.Count = (int)Math.Round(unit.Count * 0.9);
                        }

                        attackerCountry.Pearl += attack.DefenderCountry.Pearl / 2;
                        attackerCountry.Coral += attack.DefenderCountry.Coral / 2;

                        attack.DefenderCountry.Pearl /= 2;
                        attack.DefenderCountry.Coral /= 2;
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

        public async Task ReturnAttackUnits(ICollection<Country> countries, World world)
        {
            foreach (var attackerCountry in countries)
            {
                foreach (var attack in attackerCountry.Attacks.Where(c => world.Round == c.AttackRound)) 
                {
                    var attackUnits = attack.AttackUnits;

                    foreach(var attackUnit in attackUnits)
                    {
                        var unit = attackerCountry.CountryUnits.Where(ac => ac.UnitId == attackUnit.UnitId).FirstOrDefault();
                        unit.Count += attackUnit.Count;
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
                        case UnitConstants.RohamFoka:
                            militaryPoints += unit.Count * PointConstants.Military;
                            break;
                        case UnitConstants.Csatacsiko:
                            militaryPoints += unit.Count * PointConstants.Military;
                            break;
                        case UnitConstants.Lezercapa:
                            militaryPoints += unit.Count * PointConstants.MilitaryShark;
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

        public async Task NextRound()
        {
            var world = await _context.Worlds.FirstOrDefaultAsync();
            if (world == null) throw new NullReferenceException();

            var countries = await _context.Countries.Include(e => e.CountryUnits).ThenInclude(e => e.Unit)
                                                    .Include(e => e.Production)
                                                    .Include(e => e.FightPoint)
                                                    .Include(e => e.Attacks).ThenInclude(e => e.AttackUnits).ThenInclude(e => e.Unit)
                                                    .Include(e => e.Attacks).ThenInclude(e => e.DefenderCountry).ThenInclude(e => e.FightPoint).Include(e => e.CountryUnits).ThenInclude(e => e.Unit)
                                                    .Include(e => e.CountryBuildings).ThenInclude(e => e.Building)
                                                    .Include(e => e.CountryUpgrades).ThenInclude(e => e.Upgrade)
                                                    .Include(e => e.ActiveUpgradings).ThenInclude(e => e.Upgrade).ThenInclude(e => e.UpgradeEffects).ThenInclude(e => e.Effect)
                                                    .Include(e => e.ActiveConstructions).ThenInclude(e => e.Building).ThenInclude(e => e.BuildingEffects).ThenInclude(e => e.Effect)
                                                    .Include(e => e.Owner)
                                                    .ToListAsync();

            using (var transaction = _context.Database.BeginTransaction())
            {
                PayTax(countries);

                PayCoral(countries);

                PayMercenaryAndFeedSoldiers(countries);

                MakeUpgrades(countries,world);

                MakeBuildings(countries,world);

                Fights(countries,world);

                await ReturnAttackUnits(countries, world);

                CalculatePoints(countries);

                world.Round++;

                await _context.SaveChangesAsync();
                await transaction.CommitAsync();
            }

        }
    }
}

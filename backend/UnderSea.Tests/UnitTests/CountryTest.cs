using FluentAssertions;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using UnderSea.Bll.Services;
using UnderSea.Bll.Services.Interfaces;
using UnderSea.Bll.Validation.Exceptions;
using UnderSea.Model.Constants;
using UnderSea.Model.Models;
using UnderSea.Model.Models.Joins;
using Xunit;

namespace UnderSea.Tests.UnitTests
{
    public class CountryTest : UnitTest
    {
        private readonly ICountryService service;
        public CountryTest()
        {
            service = new CountryService(_context,_mapper,identityService);
        }

        [Fact]
        public async Task GetUserCountryDetailsTest()
        {
            // Arrange
            var country = await _context.Countries
                .Include(c => c.CountryMaterials)
                .FirstOrDefaultAsync(c => c.Id == LoggedInCountryId);

            var expectedDetails = await DetailsSeed(country);

            // Act
            var actualDetails = await service.GetUserCountryDetails();

            // Assert
            actualDetails.Event.Should().NotBeNull();

            actualDetails.HasSonarCanon.Should().BeTrue();

            //actualDetails.Units.Any(u => u.Level == expectedDetails.countryUnit.GetLevel()).Should().BeTrue();

            actualDetails.Materials.Any(m => m.Amount == expectedDetails.countryMaterial.Amount).Should().BeTrue();
            actualDetails.Materials.Any(m => m.Production == expectedDetails.countryMaterial.BaseProduction * expectedDetails.countryMaterial.Multiplier)
                .Should().BeTrue();

            actualDetails.Population.Should().Be(country.Population);
            actualDetails.MaxUnitCount.Should().Be(country.MaxUnitCount);

            actualDetails.Buildings.Any(b => b.ActiveConstructionCount == 1).Should().BeTrue();
            actualDetails.Buildings.Any(b => b.BuildingsCount == expectedDetails.countryBuilding.Count).Should().BeTrue();
        }

        [Fact]
        public async Task GetUserCountryNameTest()
        {
            // Arrange
            var country = await _context.Countries.FirstOrDefaultAsync(c => c.Id == LoggedInCountryId);

            // Act
            var actualCountryName = await service.GetUserCountryName();

            // Assert
            actualCountryName.Should().Be(country.Name);
        }

        [Fact]
        public void ChangeCountryNameTest_FailedRequiredName()
        {
            // Arrange
            string newName = null;

            // Act
            Func<Task> action = async () => await service.ChangeUserCountryName(newName);

            // Assert
            action.Should().Throw<InvalidParameterException>().WithMessage(ExceptionMessageConstants.ChangeCountryName_Required);
        }

        [Fact]
        public async Task ChangeCountryNameTest_Successful()
        {
            // Arrange
            string newName = "teszt";
            var oldCountry = await _context.Countries.FirstOrDefaultAsync(c => c.Id == LoggedInCountryId);
            string oldName = oldCountry.Name;

            // Act
            await service.ChangeUserCountryName(newName);

            // Assert
            var country = await _context.Countries.FirstOrDefaultAsync(c => c.Id == LoggedInCountryId);
            country.Name.Should().Be(newName);
            country.Name.Should().NotBe(oldName);
        }

        // why not
        private async Task<(
            CountryUnit countryUnit,
            CountryEvent countryEvent,
            CountryMaterial countryMaterial,
            CountryBuilding countryBuilding,
            CountryUpgrade countryUpgrade,
            ActiveConstruction activeConstruction
            )> 
            DetailsSeed(Country country)
        {
            var countryUnit = new CountryUnit
            {
                UnitId = 3,
                BattlesPlayed = 5,
                CountryId = LoggedInCountryId,
                Count = 10
            };
            _context.CountryUnits.Add(countryUnit);

            var countryEvent = new CountryEvent
            {
                CountryId = LoggedInCountryId,
                EventId = 4,
                EventRound = 1
            };
            _context.CountryEvents.Add(countryEvent);

            var countryMaterial = new CountryMaterial
            {
                Amount = 12345,
                BaseProduction = 20000,
                CountryId = LoggedInCountryId,
                MaterialId = 3,
                Multiplier = 23
            };
            var material = country.CountryMaterials
                .FirstOrDefault(c => c.MaterialId == countryMaterial.MaterialId && c.CountryId == countryMaterial.CountryId);
            material.Amount = countryMaterial.Amount;
            material.BaseProduction = countryMaterial.BaseProduction;
            material.MaterialId = countryMaterial.MaterialId;
            material.Multiplier = countryMaterial.Multiplier;

            var countryUpgrade = new CountryUpgrade
            {
                CountryId = LoggedInCountryId,
                UpgradeId = 4
            };
            _context.CountryUpgrades.Add(countryUpgrade);

            var countryBuilding = new CountryBuilding
            {
                BuildingId = 1,
                CountryId = LoggedInCountryId,
                Count = 4
            };
            _context.CountryBuildings.Add(countryBuilding);

            var activeConstruction = new ActiveConstruction
            {
                BuildingId = 2,
                CountryId = LoggedInCountryId,
                EstimatedFinish = 6
            };
            _context.ActiveConstructions.Add(activeConstruction);

            await _context.SaveChangesAsync();

            return (countryUnit, countryEvent,countryMaterial, countryBuilding, countryUpgrade,activeConstruction);
        }
    }
}

using FluentAssertions;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using UnderSea.Bll.Dtos;
using UnderSea.Bll.Services;
using UnderSea.Bll.Services.Interfaces;
using UnderSea.Bll.Validation.Exceptions;
using UnderSea.Model.Constants;
using UnderSea.Model.Models;
using Xunit;

namespace UnderSea.Tests.UnitTests
{
    public class BuildingTest : UnitTest
    {
        private readonly IBuildingService _service;
        public BuildingTest() : base()
        {
            _service = new BuildingService(_context, _mapper, identityService);
        }

        [Fact]
        public async Task GetUserBuildingTest()
        {
            // Arrange
            var countryBuilding = new CountryBuilding
            {
                BuildingId = 1,
                CountryId = LoggedInCountryId,
                Count = 20
            };

            var countryBuilding2 = new CountryBuilding
            {
                BuildingId = 2,
                CountryId = LoggedInCountryId,
                Count = 20
            };

            var countryBuilding3 = new CountryBuilding
            {
                BuildingId = 3,
                CountryId = LoggedInCountryId,
                Count = 20
            };

            _context.CountryBuildings.Add(countryBuilding);
            _context.CountryBuildings.Add(countryBuilding2);
            _context.CountryBuildings.Add(countryBuilding3);

            await _context.SaveChangesAsync();

            // Act
            var buildings = await _service.GetUserBuildingAsync();

            // Asset
            buildings.Count().Should().Be(3);
            buildings.Sum(b => b.Count)
                .Should().Be(countryBuilding.Count + countryBuilding2.Count + countryBuilding3.Count);
        }

        [Fact]
        public void BuyBuilding_BuildingNotExistsTest()
        {
            // Arrange
            var buyBuilding = new BuyBuildingDto
            {
                BuildingId = 10
            };

            // Act
            Func<Task> action = async () => await _service.BuyBuildingAsync(buyBuilding);

            // Asset
            action.Should().Throw<NotExistsException>().WithMessage(ExceptionMessageConstants.BuyBuilding_BuildingNotExists);
        }

        [Fact]
        public async Task BuyBuilding_ActiveBuildingConstructionTest()
        {
            // Arrange
            var buyBuilding = new BuyBuildingDto
            {
                BuildingId = 2
            };

            var activeBuilding = new ActiveConstruction
            {
                BuildingId = 2,
                CountryId = LoggedInCountryId,
                EstimatedFinish = 4
            };
            _context.ActiveConstructions.Add(activeBuilding);
            await _context.SaveChangesAsync();

            // Act
            Func<Task> action = async () => await _service.BuyBuildingAsync(buyBuilding);

            // Asset
            action.Should().Throw<InvalidParameterException>().WithMessage(ExceptionMessageConstants.BuyBuilding_ActiveBuildingConstruction);
        }

        [Fact]
        public async Task BuyBuilding_NotEnoughMaterials()
        {
            // Arrange
            var buyBuilding = new BuyBuildingDto
            {
                BuildingId = 1
            };

            var countryMaterial = await _context.CountryMaterials.FirstOrDefaultAsync(c => c.CountryId == LoggedInCountryId && c.MaterialId == 1);
            countryMaterial.Amount = 0;
            countryMaterial.BaseProduction = 0;
            await _context.SaveChangesAsync();

            // Act
            Func<Task> action = async () => await _service.BuyBuildingAsync(buyBuilding);

            // Asset
            action.Should().Throw<ArgumentOutOfRangeException>();
        }

        [Fact]
        public async Task BuyBuilding_SuccessfulBuying()
        {
            // Arrange
            var buyBuilding = new BuyBuildingDto
            {
                BuildingId = 1
            };

            var countryMaterial = await _context.CountryMaterials.FirstOrDefaultAsync(c => c.CountryId == LoggedInCountryId && c.MaterialId == 3);
            countryMaterial.Amount = 400;
            countryMaterial.BaseProduction = 100;
            await _context.SaveChangesAsync();

            // Act
            await _service.BuyBuildingAsync(buyBuilding);

            // Asset
            var activeConstruction = await _context.ActiveConstructions.FirstOrDefaultAsync(ac => ac.CountryId == LoggedInCountryId);
            activeConstruction.Should().NotBeNull();
        }
    }
}
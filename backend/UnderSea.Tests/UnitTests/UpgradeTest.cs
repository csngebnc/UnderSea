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
    public class UpgradeTest : UnitTest
    {
        private readonly IUpgradeService service;
        public UpgradeTest() : base()
        {
            service = new UpgradeService(_context,_mapper,identityService);
        }

        [Fact]
        public async Task GetUpgradesTest()
        {
            // Arrange
            var countryUpgrade = new CountryUpgrade
            {
                CountryId = LoggedInCountryId,
                UpgradeId = 3
            };

            var countryUpgrade2 = new CountryUpgrade
            {
                CountryId = LoggedInCountryId,
                UpgradeId = 4
            };

            _context.CountryUpgrades.Add(countryUpgrade);
            _context.CountryUpgrades.Add(countryUpgrade2);

            await _context.SaveChangesAsync();

            // Act
            var actualUpgrades = await service.GetUpgrades();

            // Assert
            actualUpgrades.Count().Should().Be(6);
            actualUpgrades.Where(u => u.DoesExist == true).Count().Should().Be(2);
            actualUpgrades.Any(u => u.IsUnderConstruction == true).Should().BeFalse();
            actualUpgrades.Any(u => u.Name == "Szonárágyú").Should().BeTrue();
        }

        [Fact]
        public async Task BuyUpgradeTest_ActiveUpgrading()
        {
            // Arrange
            var activeUpgrade = new ActiveUpgrading()
            {
                CountryId = LoggedInCountryId,
                EstimatedFinish = 10,
                UpgradeId = 2
            };

            _context.ActiveUpgradings.Add(activeUpgrade);
            await _context.SaveChangesAsync();

            var buyUpgrade = new BuyUpgradeDto
            {
                UpgradeId = 3
            };

            // Act
            Func<Task> action = async () => await service.BuyUpgrade(buyUpgrade);

            // Assert
            action.Should().Throw<InvalidParameterException>().WithMessage(ExceptionMessageConstants.BuyUpgrade_ActiveUpgrading);
        }

        [Fact]
        public async Task BuyUpgradeTest_AlreadyUpgraded()
        {
            // Arrange
            var upgrade = new CountryUpgrade()
            {
                CountryId = LoggedInCountryId,
                UpgradeId = 2
            };

            _context.CountryUpgrades.Add(upgrade);
            await _context.SaveChangesAsync();

            var buyUpgrade = new BuyUpgradeDto
            {
                UpgradeId = 2
            };

            // Act
            Func<Task> action = async () => await service.BuyUpgrade(buyUpgrade);

            // Assert
            action.Should().Throw<InvalidParameterException>().WithMessage(ExceptionMessageConstants.BuyUpgrade_AlreadyUpgraded);
        }

        [Fact]
        public async Task BuyUpgradeTest_NotExistsUpgrade()
        {
            // Arrange
            var buyUpgrade = new BuyUpgradeDto
            {
                UpgradeId = 100
            };

            // Act
            Func<Task> action = async () => await service.BuyUpgrade(buyUpgrade);

            // Assert
            action.Should().Throw<NotExistsException>().WithMessage(ExceptionMessageConstants.BuyUpgrade_NotExistUpgrade);
        }

        [Fact]
        public async Task BuyUpgradeTest_Successful()
        {
            // Arrange
            var buyUpgrade = new BuyUpgradeDto
            {
                UpgradeId = 2
            };

            // Act
            await service.BuyUpgrade(buyUpgrade);

            // Assert
            var activeUpgrading = await _context.ActiveUpgradings
                .FirstOrDefaultAsync(au => au.CountryId == LoggedInCountryId && au.UpgradeId == buyUpgrade.UpgradeId);
            activeUpgrading.Should().NotBeNull();
        }
    }
}

using System;
using System.Collections.Generic;
using System.Data.Common;
using System.Linq;
using System.Security.Claims;
using System.Text;
using System.Threading.Tasks;
using AutoMapper;
using FluentAssertions;
using IdentityModel;
using Microsoft.AspNetCore.Http;
using Microsoft.Data.Sqlite;
using Microsoft.EntityFrameworkCore;
using Moq;
using UnderSea.Api.Services;
using UnderSea.Bll.Dtos;
using UnderSea.Bll.Mapper;
using UnderSea.Bll.Paging;
using UnderSea.Bll.Services;
using UnderSea.Bll.Services.Interfaces;
using UnderSea.Dal.Data;
using UnderSea.Model.Models;
using Xunit;

namespace UnderSea.Tests.UnitTests
{
    public class BattleTests : UnitTest
    {

        private IBattleService _service;

        public BattleTests() : base()
        {
            _service = new BattleService(_context, _mapper, identityService);
        }

        [Fact]
        public async Task AttackableUsersTestWithoutFilter()
        {
            var paginationData = new PaginationData();

            // Arrange
            var expectedAttackableUsers = await _context.Users
                .Where(user => user.Id != LoggedInUserId)
                .ToListAsync();

            // Act
            var actualAttackableUsers = await _service.GetAttackableUsersAsync(paginationData, null);

            // Assert
            actualAttackableUsers.AllResultsCount.Should().Be(expectedAttackableUsers.Count);
            actualAttackableUsers.Results
                .Any(user => user.Id == "a63a97aa-4ae8-4185-8621-be02286b1542")
                .Should().Be(expectedAttackableUsers.Any(user => user.Id == "a63a97aa-4ae8-4185-8621-be02286b1542"));
            actualAttackableUsers.PageNumber.Should().Be(paginationData.PageNumber);
            actualAttackableUsers.PageSize.Should().Be(paginationData.PageSize);
        }

        [Fact]
        public async Task AttackableUsersTestWithFilter()
        {
            string filter = "bly";
            var paginationData = new PaginationData();

            // Arrange
            var expectedAttackableUsers = await _context.Users
                .Where(user => user.Id != LoggedInUserId && user.UserName
                .Contains(filter))
                .ToListAsync();

            // Act
            var actualAttackableUsers = await _service.GetAttackableUsersAsync(paginationData, filter);

            // Assert
            actualAttackableUsers.AllResultsCount.Should().Be(expectedAttackableUsers.Count);
            actualAttackableUsers.Results.Any(user => user.Id == "a63a97aa-4ae8-4185-8621-be02286b1542")
                .Should().Be(expectedAttackableUsers.Any(user => user.Id == "a63a97aa-4ae8-4185-8621-be02286b1542"));
            actualAttackableUsers.PageNumber.Should().Be(paginationData.PageNumber);
            actualAttackableUsers.PageSize.Should().Be(paginationData.PageSize);
        }

        [Fact]
        public async Task GetUserUnitsTest()
        {
            // Arrange
            var countryUnit = new CountryUnit
            {
                CountryId = 1,
                UnitId = 3,
                Count = 20,
                BattlesPlayed = 5
            };

            var countryUnit2 = new CountryUnit
            {
                CountryId = 1,
                UnitId = 2,
                Count = 40,
                BattlesPlayed = 2
            };

            _context.CountryUnits.Add(countryUnit);
            _context.CountryUnits.Add(countryUnit2);
            await _context.SaveChangesAsync();

            // Act
            var actualBattleUnits = await _service.GetUserUnitsAsync();

            // Arrange
            actualBattleUnits.Count.Should().Be(_context.CountryUnits.Count());
            actualBattleUnits
                .Any(bunit => bunit.Level == 3)
                .Should().Be(countryUnit.GetLevel() == 3);
            actualBattleUnits
                .FirstOrDefault(bunit => bunit.Id == 2).Level
                .Should().NotBe(3);
            actualBattleUnits
                .Sum(bunit => bunit.Count)
                .Should().Be(countryUnit.Count + countryUnit2.Count);
        }

        [Fact]
        public async Task GetUserAllUnitsTest()
        {
            // Arrange
            var countryUnit = new CountryUnit
            {
                CountryId = 1,
                UnitId = 1,
                Count = 20,
                BattlesPlayed = 5
            };

            var countryUnit2 = new CountryUnit
            {
                CountryId = 1,
                UnitId = 3,
                Count = 40,
                BattlesPlayed = 2
            };

            var world = await _context.Worlds.FirstOrDefaultAsync();

            var attack = new Attack
            {
                AttackerCountryId = 1,
                DefenderCountryId = 3,
                WinnerId = null,
                AttackRound = world.Round
            };

            var attackUnits = new AttackUnit
            {
                BattlesPlayed = 2,
                Count = 15,
                UnitId = 3
            };

            attack.AttackUnits = new List<AttackUnit>() { attackUnits };

            _context.CountryUnits.Add(countryUnit);
            _context.CountryUnits.Add(countryUnit2);
            _context.Attacks.Add(attack);

            await _context.SaveChangesAsync();

            // Act
            var actualBattleUnits = await _service.GetUserAllUnitsAsync();

            // Arrange
            actualBattleUnits.Count().Should().Be(_context.CountryUnits.Count() + _context.AttackUnits.Count());
            actualBattleUnits
                .Any(bunit => bunit.Level == 3)
                .Should().Be(countryUnit.GetLevel() == 3);
            actualBattleUnits
                .SingleOrDefault(bunit => bunit.Id == 2)?.Level
                .Should().NotBe(3);
            actualBattleUnits
                .Sum(bunit => bunit.Count)
                .Should().Be(countryUnit.Count + countryUnit2.Count + attackUnits.Count);

        }


    }
}

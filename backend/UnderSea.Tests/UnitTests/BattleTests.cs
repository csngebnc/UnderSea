using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Claims;
using System.Text;
using System.Threading.Tasks;
using AutoMapper;
using FluentAssertions;
using IdentityModel;
using Microsoft.AspNetCore.Http;
using Microsoft.EntityFrameworkCore;
using Moq;
using UnderSea.Api.Services;
using UnderSea.Bll.Dtos;
using UnderSea.Bll.Mapper;
using UnderSea.Bll.Paging;
using UnderSea.Bll.Services;
using UnderSea.Bll.Services.Interfaces;
using UnderSea.Dal.Data;
using Xunit;

namespace UnderSea.Tests.UnitTests
{
    public class BattleTests
    {
        private UnderSeaDbContext _context;
        private IBattleService _service;
        private IMapper _mapper;
        private readonly IIdentityService identityService;
        private readonly Mock<HttpContext> mockHttpContext;

        private readonly string LoggedInUserId = "af378505-14cb-4f49-bb01-ba2c8fdef77d";
        public BattleTests()
        {
            var mockMapper = new MapperConfiguration(cfg =>
            {
                cfg.AddProfile(new AutoMapperProfiles());
            });
            _mapper = mockMapper.CreateMapper();

            var options = new DbContextOptionsBuilder<UnderSeaDbContext>()
                .UseInMemoryDatabase("TestDatabaseBattle")
                .Options;

            var mockAccessor = new Mock<IHttpContextAccessor>();
            mockHttpContext = new Mock<HttpContext>();

            mockHttpContext.Setup(x => x.User.Claims).Returns(new List<Claim>
            {
                new Claim(JwtClaimTypes.Subject, LoggedInUserId)
            });

            mockAccessor.Setup(x => x.HttpContext).Returns(mockHttpContext.Object);

            identityService = new IdentityService(mockAccessor.Object);

            _context = new UnderSeaDbContext(options);
            _context.Database.EnsureCreated();

            _service = new BattleService(_context, _mapper, identityService);
        }

        [Fact]
        public async Task AttackableUsersTestWithoutFilter()
        {
            // Arrange
            var expectedAttackableUsers = await _context.Users.Where(user => user.Id != LoggedInUserId).ToListAsync();

            // Act
            var actualAttackableUsers = await _service.GetAttackableUsersAsync(new PaginationData(), null);

            // Assert
            actualAttackableUsers.AllResultsCount.Should().Be(expectedAttackableUsers.Count);
            actualAttackableUsers.Results.Any(user => user.Id == "a63a97aa-4ae8-4185-8621-be02286b1542")
                .Should().Be(expectedAttackableUsers.Any(user => user.Id == "a63a97aa-4ae8-4185-8621-be02286b1542"));
        }


    }
}

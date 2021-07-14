using AutoMapper;
using IdentityModel;
using Microsoft.AspNetCore.Http;
using Microsoft.Data.Sqlite;
using Microsoft.EntityFrameworkCore;
using Moq;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Claims;
using System.Text;
using System.Threading.Tasks;
using UnderSea.Api.Services;
using UnderSea.Bll.Mapper;
using UnderSea.Bll.Services.Interfaces;
using UnderSea.Dal.Data;

namespace UnderSea.Tests.UnitTests
{
    public abstract class UnitTest : IDisposable
    {
        protected readonly SqliteConnection _connection;
        protected UnderSeaDbContext _context;
        protected IMapper _mapper;
        protected readonly IIdentityService identityService;
        protected readonly Mock<HttpContext> mockHttpContext;

        protected readonly string LoggedInUserId = "af378505-14cb-4f49-bb01-ba2c8fdef77d";
        protected readonly int LoggedInCountryId = 1;

        public UnitTest()
        {
            var mockMapper = new MapperConfiguration(cfg =>
            {
                cfg.AddProfile(new AutoMapperProfiles());
            });
            _mapper = mockMapper.CreateMapper();

            _connection = new SqliteConnection("Filename=:memory:");
            _connection.Open();

            var options = new DbContextOptionsBuilder<UnderSeaDbContext>()
                .UseSqlite(_connection)
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
            var cunits = _context.CountryUnits.ToList();
            _context.CountryUnits.RemoveRange(cunits);
            _context.SaveChanges();
        }

        public void Dispose()
        {
            _context.Dispose();
            _connection.Dispose();
        }
    }
}

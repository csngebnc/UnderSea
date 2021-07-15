using FluentAssertions;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using UnderSea.Bll.Paging;
using UnderSea.Bll.Services;
using UnderSea.Bll.Services.Interfaces;
using UnderSea.Model.Models.Joins;
using Xunit;

namespace UnderSea.Tests.UnitTests
{
    public class EventTest : UnitTest
    {
        private readonly IEventService service;
        public EventTest() : base()
        {
            service = new EventService(_context, identityService);
        }

        [Fact]
        public async Task GetUserEventsTest()
        {
            // Arrange
            PaginationData data = new PaginationData();
            var countryEvent = new CountryEvent
            {
                CountryId = LoggedInCountryId,
                EventId = 4,
                EventRound = 1
            };
            _context.CountryEvents.Add(countryEvent);
            await _context.SaveChangesAsync();

            // Act
            var events = await service.GetUserEventsAsync(data);

            // Assert
            events.AllResultsCount.Should().Be(1);
            events.PageNumber.Should().Be(data.PageNumber);
            events.PageSize.Should().Be(data.PageSize);
            events.Results.Count().Should().Be(1);
            events.Results.Any(e => e.Name == "Jó termés").Should().BeTrue();
        }
    }
}

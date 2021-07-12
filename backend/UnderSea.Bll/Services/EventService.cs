using AutoMapper;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using UnderSea.Bll.Dtos.Event;
using UnderSea.Bll.Paging;
using UnderSea.Bll.Services.Interfaces;
using UnderSea.Dal.Data;

namespace UnderSea.Bll.Services
{
    public class EventService
    {
        private readonly UnderSeaDbContext _context;
        private readonly IIdentityService _identityService;

        public EventService(UnderSeaDbContext context, IIdentityService identityService)
        {
            _context = context;
            _identityService = identityService;
        }

        public async Task<PagedResult<EventDto>> GetUserEventsAsync(PaginationData data)
        {
            var country = await _context.Countries
                .Include(c => c.CountryUnits)
                .SingleOrDefaultAsync(c => c.OwnerId == _identityService.GetCurrentUserId());

            var events = await _context.CountryEvents
                .Include(ce => ce.Event)
                    .ThenInclude(e => e.EventEffects)
                        .ThenInclude(ce => ce.Effect)
                .Where(ee => ee.CountryId == country.Id)
                .Select(ee => new EventDto
                {
                    Id = ee.EventId,
                    Name = ee.Event.Name,
                    EventRound = ee.EventRound,
                    Effects = ee.Event.EventEffects.Select(e => 
                    new Dtos.EffectDto
                    {
                        Id = e.Effect.Id,
                        Name = e.Effect.Name
                    })
                    .ToList()
                })
                .ToPagedList(data.PageSize, data.PageNumber);

            return events;
        }
    }
}

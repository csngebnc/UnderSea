using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using UnderSea.Bll.Dtos.Event;
using UnderSea.Bll.Paging;
using UnderSea.Bll.Services.Interfaces;

namespace UnderSea.Api.Controllers
{
    [Authorize(AuthenticationSchemes = JwtBearerDefaults.AuthenticationScheme)]
    [Route("api/[controller]")]
    [ApiController]
    public class EventController : ControllerBase
    {
        private readonly IEventService service;

        public EventController(IEventService service)
        {
            this.service = service;
        }

        [HttpGet("user-events")]
        public async Task<ActionResult<PagedResult<EventDto>>> GetUserEvents([FromQuery] PaginationData pagination)
        {
            return await service.GetUserEventsAsync(pagination);
        }
    }
}

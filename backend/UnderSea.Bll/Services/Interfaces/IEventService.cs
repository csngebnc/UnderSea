using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using UnderSea.Bll.Dtos.Event;
using UnderSea.Bll.Paging;

namespace UnderSea.Bll.Services.Interfaces
{
    public interface IEventService
    {
        Task<PagedResult<EventDto>> GetUserEventsAsync(PaginationData data);
    }
}

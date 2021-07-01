using Microsoft.AspNetCore.SignalR;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using UnderSea.Api.SignalR;
using UnderSea.Bll.Services.Interfaces;

namespace UnderSea.Api.Services
{
    public class RoundHubService : IHubService
    {
        private readonly IHubContext<RoundHub> _roundHub;

        public RoundHubService(IHubContext<RoundHub> roundHub)
        {
            _roundHub = roundHub;
        }

        public async Task SendNewRoundMessage(int roundNumber)
        {
            await _roundHub.Clients.All.SendAsync("SendMessage", roundNumber);
        }
    }
}

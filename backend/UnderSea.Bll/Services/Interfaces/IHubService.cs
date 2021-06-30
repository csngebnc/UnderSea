using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace UnderSea.Bll.Services.Interfaces
{
    public interface IHubService
    {
        Task SendNewRoundMessage(int roundNumber);
    }
}

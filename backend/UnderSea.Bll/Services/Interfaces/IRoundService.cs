using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using UnderSea.Model.Models;

namespace UnderSea.Bll.Services.Interfaces
{
    public interface IRoundService
    {
        Task NextRound();
    }
}

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using UnderSea.Dal.Data;

namespace UnderSea.Bll.Services
{
    public class BattleService
    {
        private readonly UnderSeaDbContext _context;

        public BattleService(UnderSeaDbContext context)
        {
            _context = context;
        }
    }
}

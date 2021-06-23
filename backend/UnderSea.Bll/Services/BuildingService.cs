using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using UnderSea.Dal.Data;

namespace UnderSea.Bll.Services
{
    public class BuildingService
    {
        private readonly UnderSeaDbContext _context;

        public BuildingService(UnderSeaDbContext context)
        {
            _context = context;
        }
    }
}

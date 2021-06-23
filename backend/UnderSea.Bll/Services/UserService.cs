using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using UnderSea.Dal.Data;

namespace UnderSea.Bll.Services
{
    public class UserService
    {
        private readonly UnderSeaDbContext _context;
        public UserService(UnderSeaDbContext context)
        {
            _context = context;
        }
     }
}

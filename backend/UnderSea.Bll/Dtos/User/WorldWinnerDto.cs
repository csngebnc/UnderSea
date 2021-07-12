using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace UnderSea.Bll.Dtos.User
{
    public class WorldWinnerDto
    {
        public int Id { get; set; }
        public string UserName { get; set; }
        public string CountryName { get; set; }
        public int Points { get; set; }
        public int WorldRound { get; set; }
        public DateTime Date { get; set; }
    }
}

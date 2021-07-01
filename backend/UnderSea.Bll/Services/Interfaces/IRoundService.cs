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
        void PayTax(ICollection<Country> countries);
        void PayCoral(ICollection<Country> countries);
        void PayMercenaryAndFeedSoldiers(ICollection<Country> countries);
        void MakeUpgrades(ICollection<Country> countries, World world);
        void MakeBuildings(ICollection<Country> countries, World world);
        void Fights(ICollection<Country> countries, World world);
        void CalculatePoints(ICollection<Country> countries);
        Task NextRound();
    }
}

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using UnderSea.Model.Models.Materials;

namespace UnderSea.Model.Models.Joins
{
    public class CountryMaterial
    {
        private int amount;

        public int CountryId { get; set; }
        public Country Country { get; set; }
        public int MaterialId { get; set; }
        public Material Material { get; set; }
        public int Amount
        {
            get => amount;
            set 
            {
                if(value < 0)
                {
                    throw new ArgumentOutOfRangeException(nameof(value),"Nincs elég nyersanyagod a művelet végrehajtásához.");
                }
                amount = value;
            }
        }

        public int BaseProduction { get; set; }
        public double Multiplier { get; set; }
    }
}

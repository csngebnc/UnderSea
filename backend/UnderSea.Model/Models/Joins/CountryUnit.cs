using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace UnderSea.Model.Models
{
    public class CountryUnit
    {
        private int count;
        public int Count { get => count; 
            set {
                if(value < 0)
                {
                    throw new ArgumentOutOfRangeException(nameof(value), "A kért egységek nem állnak rendelkezésre.");
                }
                count = value; 
            } 
        }

        public int CountryId { get; set; }
        public Country Country { get; set; }

        public int UnitId { get; set; }
        public Unit Unit { get; set; }

    }
}

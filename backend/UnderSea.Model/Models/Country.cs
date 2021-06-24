using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace UnderSea.Model.Models
{
    public class Country
    {
        public int Id { get; set; }

        [Required(ErrorMessage = "Az ország nevét kötelező megadni!")]
        [StringLength(100, ErrorMessage = "Az ország neve maximum 100 karakter hosszú lehet!")]
        public string Name { get; set; }

        [Range(0, int.MaxValue, ErrorMessage = "A népesség nem lehet negatív szám!")]
        [Required(ErrorMessage = "A népességet kötelező megadni!")]
        public int Population { get; set; }

        [Range(0, int.MaxValue, ErrorMessage = "A gyöngy mennyisége nem lehet negatív szám!")]
        [Required(ErrorMessage = "A gyöngy mennyiségét kötelező megadni!")]
        public int Pearl { get; set; }

        [Range(0, int.MaxValue, ErrorMessage = "A korall mennyisége nem lehet negatív szám!")]
        [Required(ErrorMessage = "A korall mennyiségét kötelező megadni!")]
        public int Coral { get; set; }

        [Range(0, int.MaxValue, ErrorMessage = "Az egység mennyisége nem lehet negatív szám!")]
        [Required(ErrorMessage = "A egység mennyiségének kötelező megadni!")]
        public int MaxUnitCount { get; set; }

        public Production Production { get; set; }

        public string OwnerId { get; set; }
        public User Owner { get; set; }

        public ICollection<Attack> Attacks { get; set; }
        public ICollection<Attack> Defenses { get; set; }
        public ICollection<CountryUnit> CountryUnits { get; set; }
        public ICollection<CountryBuilding> CountryBuildings { get; set; }
        public ICollection<CountryUpgrade> CountryUpgrades { get; set; }
        public ICollection<ActiveUpgrading> ActiveUpgradings { get; set; }
    }
}

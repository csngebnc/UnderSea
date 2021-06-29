using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace UnderSea.Bll.Dtos
{
    public class UnitDto
    {
        [Required(ErrorMessage = "Az egység azonosítóját kötelező megadni!")]
        public int Id { get; set; }

        [Required(ErrorMessage = "Az egység nevét kötelező megadni!")]
        [StringLength(100, ErrorMessage = "Az egység neve maximum 100 karakter hosszú lehet!")]
        public string Name { get; set; }

        [Range(0, int.MaxValue, ErrorMessage = "A támadó pont nem lehet negatív szám!")]
        [Required(ErrorMessage = "A támadó pontot kötelező megadni!")]
        public int AttackPoint { get; set; }

        [Range(0, int.MaxValue, ErrorMessage = "A védekező pont nem lehet negatív szám!")]
        [Required(ErrorMessage = "A védekező pontot kötelező megadni!")]
        public int DefensePoint { get; set; }

        [Range(0, int.MaxValue, ErrorMessage = "A zsold nem lehet negatív szám!")]
        [Required(ErrorMessage = "A zsoldot kötelező megadni!")]
        public int MercenaryPerRound { get; set; }

        [Range(0, int.MaxValue, ErrorMessage = "Az ellátás nem lehet negatív szám!")]
        [Required(ErrorMessage = "Az ellátást kötelező megadni!")]
        public int SupplyPerRound { get; set; }

        [Range(0, int.MaxValue, ErrorMessage = "Az egység ára nem lehet negatív szám!")]
        [Required(ErrorMessage = "Az egység árát kötelező megadni!")]
        public int Price { get; set; }
        [Range(0, int.MaxValue, ErrorMessage = "Az egység ára nem lehet negatív szám!")]
        [Required(ErrorMessage = "Az egység darabszámát kötelező megadni!")]
        public int CurrentCount { get; set; }
    }
}

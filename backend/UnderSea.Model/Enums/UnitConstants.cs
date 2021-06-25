using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace UnderSea.Model.Constants
{
    public enum UnitConstants
    {
        [Display(Name = "Rohamfóka")]
        RohamFoka = 0,
        [Display(Name = "Csatacsikó")]
        Csatacsiko = 1,
        [Display(Name = "Lézercápa")]
        Lezercapa = 2
    }
}

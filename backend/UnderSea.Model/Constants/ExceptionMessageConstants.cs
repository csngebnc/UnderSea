using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace UnderSea.Model.Constants
{
    public static class ExceptionMessageConstants
    {
        public static string Attack_AttackedCountryNotExists = "Nem létezik ilyen ország, ami megtámadható lenne.";
        public static string Attack_WorldNotExists = "Nem létezik ilyen világ, ahol támadni lehet.";
        public static string Attack_CanNotSendSpy = "Kémet nem küldhetsz támadni.";
        public static string Attack_CanNotSendSecondAttack = "Nem támadható ugyanaz az ország egy körben!";
        public static string Attack_CanNotAttackYourself = "Nem támadhatja meg saját magát az ország.";
        public static string Attack_NeedGeneral = "A támadáshoz legalább egy hadvezért is küldeni kell.";
        public static string Attack_NotEnoughUnits = "Nem áll rendelkezésre elég egység.";

        public static string Spy_CanNotSpyingYourself = "Nem kémlelheti saját magát az ország.";
        public static string Spy_NotEnoughSpies = "Nincsenek kém egységek, amiket el lehetne küldeni!";

        public static string BuyBuilding_BuildingNotExists = "Nem létezik ilyen épület.";
        public static string BuyBuilding_CountryNotExists = "Nem létezik ilyen ország.";
        public static string BuyBuilding_ActiveBuildingConstruction = "Már folyamatban van egy építés.";

        public static string ChangeCountryName_Required = "Az ország nevének megadása kötelező.";
    }
}

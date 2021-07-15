using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using UnderSea.Bll.Dtos;

namespace UnderSea.Bll.Services.Interfaces
{
    public interface ICountryService
    {
        Task CreateCountryWithMaterials(string countryName, string ownerId);
        Task<CountryDetailsDto> GetUserCountryDetails();
        Task<string> GetUserCountryName();
        Task ChangeUserCountryName(string name);
    }
}

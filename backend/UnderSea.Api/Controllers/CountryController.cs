using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using UnderSea.Bll.Dtos;
using UnderSea.Bll.Services.Interfaces;

namespace UnderSea.Api.Controllers
{
    [Authorize(AuthenticationSchemes = JwtBearerDefaults.AuthenticationScheme)]
    [Route("api/[controller]")]
    [ApiController]
    public class CountryController : ControllerBase
    {
        private readonly ICountryService _countryService;

        public CountryController(ICountryService countryService)
        {
            _countryService = countryService;
        }

        [HttpGet]
        public async Task<ActionResult<CountryDetailsDto>> GetCountryDetails()
        {
            return Ok(await _countryService.GetUserCountryDetails());
        }

        [HttpGet("country-name")]
        public async Task<ActionResult<string>> GetUserCountryName()
        {
            return Ok(await _countryService.GetUserCountryName());
        }

        [HttpPut("new-country-name")]
        public async Task<ActionResult> ChangeCountryName([FromQuery] string name)
        {
            await _countryService.ChangeUserCountryName(name);
            return Ok();
        }
    }
}

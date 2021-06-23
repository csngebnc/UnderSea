using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using UnderSea.Bll.Dtos;
using UnderSea.Bll.Paging;
using UnderSea.Dal.Data;

namespace UnderSea.Api.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class UserController : ControllerBase
    {
        public UserController()
        {

        }

        [HttpPost("register")]
        public async Task<ActionResult> Register(RegisterDto registerDto)
        {
            return Ok("success: register");
        }

        [HttpPost("login")]
        public async Task<ActionResult> Login(LoginDto registerDto)
        {
            return Ok("success: login");
        }

        [HttpGet("ranklist")]
        public async Task<ActionResult<PagedResult<UserRankDto>>> GetRanklist(PaginationData pagination) 
        {
            return Ok(new PagedResult<UserRankDto>());
        }

        [HttpGet]
        public async Task<ActionResult<UserInfoDto>> GetUserInfo()
        {
            return Ok(new UserInfoDto { Id = new Guid().ToString("N"), Name = "Teszt User", Placement = 1, Round = 1 });
        }

        [HttpGet("details")]
        public async Task<ActionResult<UserDetailsDto>> GetUserDetails()
        {
            return Ok(new UserDetailsDto());
        }

        [HttpPut("country-name")]
        public async Task<ActionResult<string>> ChangeCountryName([FromBody] string countryName)
        {
            return Ok($"success: {countryName}");
        }


    }
}

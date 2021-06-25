using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.IdentityModel.Tokens.Jwt;
using System.Linq;
using System.Threading.Tasks;
using UnderSea.Bll.Dtos;
using UnderSea.Bll.Paging;
using UnderSea.Bll.Services;
using UnderSea.Bll.Services.Interfaces;
using UnderSea.Dal.Data;

namespace UnderSea.Api.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class UserController : ControllerBase
    {
        private readonly UserService _userService;

        public UserController(UserService userService)
        {
            _userService = userService;
        }

        [HttpPost("register")]
        public async Task<ActionResult<string>> Register(RegisterDto registerDto)
        {
            return Ok(await _userService.Register(registerDto));
        }
        
        [HttpGet("ranklist")]
        public async Task<ActionResult<PagedResult<UserRankDto>>> GetRanklist([FromQuery] PaginationData pagination, [FromQuery] string name)
        {
            return Ok(await _userService.GetRanklist(pagination, name));
        }

        [HttpGet]
        public async Task<ActionResult<UserInfoDto>> GetUserInfo()
        {
            return Ok(await _userService.GetUserInfo());
        }

        [HttpGet("details")]
        public async Task<ActionResult<CountryDetailsDto>> GetUserDetails()
        {
            return Ok(await _userService.GetUserDetails());
        }

        [HttpGet("country-name")]
        public async Task<ActionResult<string>> GetUserCountryName()
        {
            return Ok(await _userService.GetUserCountryName());
        }

        [HttpPut("new-country-name")]
        public async Task<ActionResult> ChangeCountryName([FromQuery] string name)
        {
            await _userService.ChangeCountryName(name);
            return Ok();
        }


    }
}

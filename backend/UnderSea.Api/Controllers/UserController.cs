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
        private readonly IIdentityService _identityService;
        //private readonly JwtSecurityTokenHandler jwth;

        public UserController(UserService userService, IIdentityService identityService)
        {
            _userService = userService;
            _identityService = identityService;
        }

        [HttpPost("register")]
        public async Task<ActionResult<string>> Register(RegisterDto registerDto)
        {
            return Ok(await _userService.Register(registerDto));
        }
        
        [HttpGet("ranklist")]
        public async Task<ActionResult<PagedResult<UserRankDto>>> GetRanklist([FromQuery] PaginationData pagination)
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

        [HttpPut("new-country-name")]
        public async Task<ActionResult<string>> ChangeCountryName([FromQuery] string name)
        {
            return Ok($"success: {name}");
        }


    }
}

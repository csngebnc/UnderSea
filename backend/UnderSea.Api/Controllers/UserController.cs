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
using UnderSea.Bll.Dtos.User;
using UnderSea.Bll.Paging;
using UnderSea.Bll.Services;
using UnderSea.Bll.Services.Interfaces;
using UnderSea.Dal.Data;

namespace UnderSea.Api.Controllers
{
    [Authorize(AuthenticationSchemes = JwtBearerDefaults.AuthenticationScheme)]
    [Route("api/[controller]")]
    [ApiController]
    public class UserController : ControllerBase
    {
        private readonly IUserService _userService;

        public UserController(IUserService userService)
        {
            _userService = userService;
        }

        [AllowAnonymous]
        [HttpPost("register")]
        public async Task Register(RegisterDto registerDto)
        {
            await _userService.Register(registerDto);
        }
        
        [HttpGet("ranklist")]
        public async Task<PagedResult<UserRankDto>> GetRanklist([FromQuery] PaginationData pagination, [FromQuery] string name)
        {
            return await _userService.GetRanklist(pagination, name);
        }

        [HttpGet("worldwinners")]
        public async Task<PagedResult<WorldWinnerDto>> GetWorldWinners([FromQuery] PaginationData pagination, [FromQuery] string name)
        {
            return await _userService.GetWorldWinners(pagination, name);
        }

        [HttpGet]
        public async Task<UserInfoDto> GetUserInfo()
        {
            return await _userService.GetUserInfo();
        }
    }
}

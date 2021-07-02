using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using UnderSea.Bll.Dtos;
using UnderSea.Bll.Dtos.Unit;
using UnderSea.Bll.Paging;
using UnderSea.Bll.Services;
using UnderSea.Bll.Services.Interfaces;

namespace UnderSea.Api.Controllers
{
    [Authorize(AuthenticationSchemes = JwtBearerDefaults.AuthenticationScheme)]
    [Route("api/[controller]")]
    [ApiController]
    public class BattleController : ControllerBase
    {
        private readonly IBattleService service;

        public BattleController(IBattleService service)
        {
            this.service = service;
        }

        [HttpGet("attackable-users")]
        public async Task<ActionResult<PagedResult<AttackableUserDto>>> GetAttackableUsers([FromQuery] PaginationData pagination, [FromQuery] string name)
        {
            var attackableusers = await service.GetAttackableUsersAsync(pagination, name);
            return Ok(attackableusers);
        }

        [HttpGet("available-units")]
        public async Task<ActionResult<IEnumerable<BattleUnitDto>>> GetUserUnits()
        {
            var userunits = await service.GetUserUnitsAsync();
            return Ok(userunits);
        }

        [HttpGet("all-units")]
        public async Task<ActionResult<IEnumerable<BattleUnitDto>>> GetAllUserUnits()
        {
            var userunits = await service.GetUserAllUnitsAsync();
            return Ok(userunits);
        }

        [HttpPost("attack")]
        public async Task<ActionResult> Attack([FromBody] SendAttackDto sendAttack)
        {
            await service.AttackAsync(sendAttack);
            return Ok();
        }

        [HttpGet("history")]
        public async Task<ActionResult<PagedResult<LoggedAttackDto>>> History([FromQuery] PaginationData pagination)
        {
            var loggedattacks = await service.GetLoggedAttacksAsync(pagination);
            return Ok(loggedattacks);
        }

        [HttpGet("units")]
        public async Task<ActionResult<IEnumerable<UnitDto>>> GetAllUnits()
        {
            var units = await service.GetAllUnitsAsync();
            return Ok(units);
        }

        [HttpPost("buy-unit")]
        public async Task<ActionResult> BuyUnit([FromBody] BuyUnitDto unitsDto)
        {
            await service.BuyUnitAsync(unitsDto);
            return Ok();
        }
    }
}

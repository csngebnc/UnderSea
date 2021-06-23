using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using UnderSea.Bll.Dtos;
using UnderSea.Bll.Paging;

namespace UnderSea.Api.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class BattleController : ControllerBase
    {
        public BattleController()
        {
             
        }

        [HttpGet("attackable-users")]
        public async Task<ActionResult<PagedResult<AttackableUserDto>>> GetAttackableUsers([FromQuery] PaginationData pagination)
        {
            return Ok(new PagedResult<AttackableUserDto>());
        }

        [HttpGet("available-units")]
        public async Task<ActionResult<BattleUnitDto>> GetUserUnits()
        {
            return Ok(new BattleUnitDto());
        }

        [HttpPost("attack")]
        public async Task<ActionResult> Attack([FromBody] SendAttackDto sendAttack)
        {
            return Ok("cső");
        }

        [HttpGet("history")]
        public async Task<ActionResult<PagedResult<LoggedAttackDto>>> History()
        {
            return Ok(new PagedResult<LoggedAttackDto>());
        }

        [HttpGet("units")]
        public async Task<ActionResult<IEnumerable<UnitDto>>> GetAllUnits()
        {
            return Ok(new List<UnitDto>());
        }

        [HttpPost("buy-unit")]
        public async Task<ActionResult> BuyUnit([FromBody] BuyUnitDto unitDto)
        {
            return Ok("cső");
        }
    }
}

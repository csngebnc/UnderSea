using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using UnderSea.Bll.Dtos;

namespace UnderSea.Api.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class UpgradeController : ControllerBase
    {
        public UpgradeController()
        {

        }

        [HttpGet("list")]
        public async Task<IEnumerable<UpgradeDto>> GetUpgrades()
        {
            return new List<UpgradeDto>();
        }

        [HttpPost("buy")]
        public async Task<ActionResult> BuyUpgrade(BuyUpgradeDto buyUpgradeDto)
        {
            return Ok("succes: buy upgrade");
        }
    }
}

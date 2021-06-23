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
    public class BuildingController : ControllerBase
    {
        public BuildingController()
        {

        }

        [HttpGet("user-buildings")]
        public async Task<ActionResult<IEnumerable<BuildingDetailsDto>>> GetUserBuildings()
        {
            return Ok(new List<BuildingDetailsDto>());
        }

        [HttpPost("buy")]
        public async Task<ActionResult> BuyBuilding(BuyBuildingDto buildingDto)
        {
            return Ok("cső");
        }
    }
}

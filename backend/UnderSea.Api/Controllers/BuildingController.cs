using Microsoft.AspNetCore.Mvc;
using System.Collections.Generic;
using System.Threading.Tasks;
using UnderSea.Bll.Dtos;
using UnderSea.Bll.Services;

namespace UnderSea.Api.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class BuildingController : ControllerBase
    {
        private readonly BuildingService service;

        public BuildingController(BuildingService service)
        {
            this.service = service;
        }

        [HttpGet("user-buildings")]
        public async Task<ActionResult<IEnumerable<BuildingDetailsDto>>> GetUserBuildings()
        {
            var userbuildings = await service.GetUserBuildingAsync();
            return Ok(userbuildings);
        }

        [HttpPost("buy")]
        public async Task<ActionResult> BuyBuilding(BuyBuildingDto buildingDto)
        {
            await service.BuyBuildingAsync(buildingDto);
            return Ok();
        }
    }
}

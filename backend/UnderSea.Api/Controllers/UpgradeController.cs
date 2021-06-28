﻿using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using UnderSea.Bll.Dtos;
using UnderSea.Bll.Services;

namespace UnderSea.Api.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class UpgradeController : ControllerBase
    {
        private readonly UpgradeService _upgradeService;
        public UpgradeController(UpgradeService upgradeService)
        {
            _upgradeService = upgradeService;
        }

        [HttpGet("list")]
        public async Task<ActionResult<IEnumerable<UpgradeDto>>> GetUpgrades()
        {
            return Ok(await _upgradeService.GetUpgrades());
        }

        [HttpPost("buy")]
        public async Task<ActionResult> BuyUpgrade(BuyUpgradeDto buyUpgradeDto)
        {
            await _upgradeService.BuyUpgrade(buyUpgradeDto);
            return Ok();
        }
    }
}
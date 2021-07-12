using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using UnderSea.Bll.Dtos;
using UnderSea.Bll.Dtos.Spy;
using UnderSea.Bll.Dtos.Unit;
using UnderSea.Bll.Paging;
using UnderSea.Model.Models;

namespace UnderSea.Bll.Services.Interfaces
{
    public interface IBattleService
    {
        Task<PagedResult<AttackableUserDto>> GetAttackableUsersAsync(PaginationData data, string name);
        Task<ICollection<BattleUnitDto>> GetUserUnitsAsync();
        Task<IEnumerable<BattleUnitDto>> GetUserAllUnitsAsync();
        Task<BattleUnitDto> GetSpies();
        Task<PagedResult<LoggedAttackDto>> GetLoggedAttacksAsync(PaginationData data);
        Task<PagedResult<SpyReportDto>> GetLoggedSpyReportsAsync(PaginationData data);
        Task<IEnumerable<UnitDto>> GetAllUnitsAsync();
        Task BuyUnitAsync(BuyUnitDto unitsDto);
        Task AttackAsync(SendAttackDto attackDto);
        Task SpyAsync(SendSpyDto spies);
        Task AttackLogic(Country attackerCountry, Country attackedCountry, SendAttackDto attackDto);

    }
}

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using UnderSea.Bll.Dtos;
using UnderSea.Bll.Dtos.Unit;
using UnderSea.Bll.Paging;
using UnderSea.Model.Models;

namespace UnderSea.Bll.Services.Interfaces
{
    public interface IBattleService
    {
        Task<PagedResult<AttackableUserDto>> GetAttackableUsersAsync(PaginationData data, string name);
        Task<IEnumerable<BattleUnitDto>> GetUserUnitsAsync();
        Task<PagedResult<LoggedAttackDto>> GetLoggedAttacksAsync(PaginationData data);
        Task<IEnumerable<UnitDto>> GetAllUnitsAsync();
        Task BuyUnitAsync(BuyUnitDto unitsDto);
        Task AttackAsync(SendAttackDto attackDto);
        Task AttackLogic(Country attackerCountry, Country attackedCountry, SendAttackDto attackDto);

    }
}

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using UnderSea.Bll.Dtos;
using UnderSea.Bll.Paging;

namespace UnderSea.Bll.Services.Interfaces
{
    public interface IUserService
    {
        Task<bool> Register(RegisterDto registerDto);
        Task<PagedResult<UserRankDto>> GetRanklist(PaginationData pagination, string nameFilter);
        Task<UserInfoDto> GetUserInfo();

    }
}

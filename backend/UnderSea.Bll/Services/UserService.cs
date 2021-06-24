using Microsoft.AspNetCore.Identity;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using UnderSea.Bll.Dtos;
using UnderSea.Dal.Data;
using UnderSea.Model.Models;

namespace UnderSea.Bll.Services
{
    public class UserService
    {
        private readonly UserManager<User> _userManager;
        private readonly UnderSeaDbContext _context;

        public UserService(UserManager<User> userManager, UnderSeaDbContext context)
        {
            _context = context;
            _userManager = userManager;
        }

        public async Task<bool> Register(RegisterDto registerDto)
        {
            var user = new User { UserName = registerDto.UserName };
            var result = await _userManager.CreateAsync(user, registerDto.Password);
            return result.Succeeded;
        }
    }
}

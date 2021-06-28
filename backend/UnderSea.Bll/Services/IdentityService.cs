using System;
using System.IdentityModel.Tokens.Jwt;
using System.Linq;
using System.Security.Claims;
using Microsoft.AspNetCore.Http;
using UnderSea.Bll.Services.Interfaces;

namespace UnderSea.Bll.Services
{
    public class IdentityService : IIdentityService
    {
        private readonly HttpContext httpContext;

        public IdentityService(IHttpContextAccessor httpContextAccessor)
        {
            httpContext = httpContextAccessor.HttpContext;
        }

        public string GetCurrentUserId()
        {
            return httpContext.User.Claims.FirstOrDefault(x => x.Type == JwtRegisteredClaimNames.Sub)?.Value;
        }
    }
}

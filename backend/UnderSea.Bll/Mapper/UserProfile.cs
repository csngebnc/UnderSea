using AutoMapper;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using UnderSea.Bll.Dtos;
using UnderSea.Model.Models;

namespace UnderSea.Bll.Mapper
{
    public class UserProfile : Profile
    {
        public UserProfile()
        {
            CreateMap<User, UserInfoDto>()
                .ForMember(dest => dest.Round, src => src.MapFrom(u => u.Country.World.Round));
            CreateMap<User, UserDetailsDto>()
                .ForMember(dest => dest.MaxUnitCount, opt =>
                    opt.MapFrom(src => src.Country.CountryBuildings
                        .Sum(b => b.Building.BuildingEffects
                           .Count(e => e.Effect.EffectType == "effect_population"))));
            CreateMap<User, UserRankDto>();
        }
    }
}

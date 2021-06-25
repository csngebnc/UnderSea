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
                .ForMember(dest => dest.Round, opt => 
                    opt.MapFrom(src => src.Country.World.Round));

            CreateMap<Country, CountryDetailsDto>()
                .ForMember(dest => dest.MaxUnitCount, opt =>
                    opt.MapFrom(src => src.CountryBuildings
                        .Sum(b => b.Building.BuildingEffects
                           .Count(e => e.Effect.EffectType == "effect_population"))))
                .ForMember(dest => dest.Units, opt => 
                    opt.MapFrom(src => src.CountryUnits.Select(cu => cu.Unit)))
                .ForMember(dest => dest.Buildings, opt =>
                    opt.MapFrom(src => src.CountryBuildings.Select(cb => cb.Building)))
                .ForMember(dest => dest.CurrentCoralProduction, opt => 
                    opt.MapFrom(src => 
                        src.Production.BaseCoralProduction * src.Production.CoralProductionMultiplier))
                .ForMember(dest => dest.CurrentPearlProduction, opt => 
                    opt.MapFrom(src => 
                        src.Production.BasePearlProduction * src.Production.PearlProductionMultiplier));

            CreateMap<User, UserRankDto>();
        }
    }
}

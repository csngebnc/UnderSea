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
    public class UpgradeProfile : Profile
    {
        public UpgradeProfile()
        {
            CreateMap<Upgrade, UpgradeDto>()
                .ForMember(dest => dest.DoesExist, src => src
                    .MapFrom(u => u.CountryUpgrades.Any(cu => cu.UpgradeId == u.Id)))
                .ForMember(dest => dest.Effects, src => src
                    .MapFrom(u => u.UpgradeEffects.Select(ue => ue.Effect)));
        }
    }
}

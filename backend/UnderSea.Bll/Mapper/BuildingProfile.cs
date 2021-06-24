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
    public class BuildingProfile : Profile
    {
        public BuildingProfile()
        {
            CreateMap<Building, BuildingDetailsDto>()
                .ForMember(e => e.Id, a => a.MapFrom(s => s.Id))
                .ForMember(e => e.Name, a => a.MapFrom(s => s.Name))
                .ForMember(e => e.Price, a => a.MapFrom(s => s.Price))
                .ForMember(e => e.Count, a => a.MapFrom(s => s.CountryBuildings.Where(c => c.Id == s.Id).Count()))
                .ForMember(e => e.Effects, a => a.MapFrom(s => s.BuildingEffects.Select(e => e.Effect)));
        }
    }
}

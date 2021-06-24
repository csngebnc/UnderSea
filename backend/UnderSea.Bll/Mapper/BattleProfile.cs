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
    public class BattleProfile : Profile
    {
        public BattleProfile()
        {
            CreateMap<User, AttackableUserDto>()
                .ForMember(e => e.Id, a => a.MapFrom(s => s.Id))
                .ForMember(e => e.UserName, a => a.MapFrom(s => s.UserName))
                .ForMember(e => e.CountryId, a => a.MapFrom(s => s.Country.Id));

            CreateMap<Unit, BattleUnitDto>()
                .ForMember(e => e.Id, a => a.MapFrom(s => s.Id))
                .ForMember(e => e.Name, a => a.MapFrom(s => s.Name))
                .ForMember(e => e.Count, a => a.MapFrom(s => s.CountryUnits.Count));

            CreateMap<SendAttackDto, Attack>()
                .ForMember(e => e.DefenderCountryId, a => a.MapFrom(s => s.AttackedCountryId))
                .ForMember(e => e.AttackUnits, a => a.MapFrom(s => s.Units));

            CreateMap<AttackUnitDto, AttackUnit>()
                .ForMember(e => e.UnitId, a => a.MapFrom(s => s.UnitId))
                .ForMember(e => e.Count, a => a.MapFrom(s => s.Count));

            CreateMap<AttackUnit, BattleUnitDto>()
                .ForMember(e => e.Id, a => a.MapFrom(s => s.UnitId))
                .ForMember(e => e.Name, a => a.MapFrom(s => s.Unit.Name))
                .ForMember(e => e.Count, a => a.MapFrom(s => s.Count));

            CreateMap<Attack, LoggedAttackDto>()
                .ForMember(e => e.AttackedCountryName, a => a.MapFrom(s => s.AttackerCountry.Name))
                .ForMember(e => e.IsWinner, a => a.MapFrom(s => s.WinnerId == s.AttackerCountry.OwnerId || s.WinnerId == s.DefenderCountry.OwnerId))
                .ForMember(e => e.Units, a => a.MapFrom(s => s.AttackUnits));

            CreateMap<Unit, UnitDto>()
                .ForMember(e => e.Id, a => a.MapFrom(s => s.Id))
                .ForMember(e => e.Name, a => a.MapFrom(s => s.Name))
                .ForMember(e => e.MercenaryPerRound, a => a.MapFrom(s => s.MercenaryPerRound))
                .ForMember(e => e.Price, a => a.MapFrom(s => s.Price))
                .ForMember(e => e.SupplyPerRound, a => a.MapFrom(s => s.SupplyPerRound));


        }
    }
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'country_details_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CountryDetailsDto _$CountryDetailsDtoFromJson(Map<String, dynamic> json) {
  return CountryDetailsDto(
    maxUnitCount: json['maxUnitCount'] as int,
    materials: (json['materials'] as List<dynamic>?)
        ?.map((e) => MaterialDetailsDto.fromJson(e as Map<String, dynamic>))
        .toList(),
    population: json['population'] as int,
    buildings: (json['buildings'] as List<dynamic>?)
        ?.map((e) => BuildingInfoDto.fromJson(e as Map<String, dynamic>))
        .toList(),
    units: (json['units'] as List<dynamic>?)
        ?.map((e) => BattleUnitDto.fromJson(e as Map<String, dynamic>))
        .toList(),
    hasSonarCanon: json['hasSonarCanon'] as bool,
  );
}

Map<String, dynamic> _$CountryDetailsDtoToJson(CountryDetailsDto instance) =>
    <String, dynamic>{
      'maxUnitCount': instance.maxUnitCount,
      'units': instance.units,
      'materials': instance.materials,
      'population': instance.population,
      'hasSonarCanon': instance.hasSonarCanon,
      'buildings': instance.buildings,
    };

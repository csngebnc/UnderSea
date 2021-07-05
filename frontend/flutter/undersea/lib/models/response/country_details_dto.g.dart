// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'country_details_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CountryDetailsDto _$CountryDetailsDtoFromJson(Map<String, dynamic> json) {
  return CountryDetailsDto(
    maxUnitCount: json['maxUnitCount'] as int,
    coral: json['coral'] as int,
    currentCoralProduction: json['currentCoralProduction'] as int,
    currentPearlProduction: json['currentPearlProduction'] as int,
    pearl: json['pearl'] as int,
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
      'coral': instance.coral,
      'pearl': instance.pearl,
      'currentCoralProduction': instance.currentCoralProduction,
      'currentPearlProduction': instance.currentPearlProduction,
      'population': instance.population,
      'hasSonarCanon': instance.hasSonarCanon,
      'buildings': instance.buildings,
    };

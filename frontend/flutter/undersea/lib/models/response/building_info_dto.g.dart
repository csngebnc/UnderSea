// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'building_info_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BuildingInfoDto _$BuildingInfoDtoFromJson(Map<String, dynamic> json) {
  return BuildingInfoDto(
    name: json['name'] as String,
    buildingsCount: json['buildingsCount'] as int,
    id: json['id'] as int,
    activeConstructionCount: json['activeConstructionCount'] as int,
  );
}

Map<String, dynamic> _$BuildingInfoDtoToJson(BuildingInfoDto instance) =>
    <String, dynamic>{
      'name': instance.name,
      'buildingsCount': instance.buildingsCount,
      'activeConstructionCount': instance.activeConstructionCount,
      'id': instance.id,
    };

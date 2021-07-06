// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'building_details_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BuildingDetailsList _$BuildingDetailsListFromJson(Map<String, dynamic> json) {
  return BuildingDetailsList(
    buildings: (json['buildings'] as List<dynamic>)
        .map((e) => BuildingDetailsDto.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$BuildingDetailsListToJson(
        BuildingDetailsList instance) =>
    <String, dynamic>{
      'buildings': instance.buildings,
    };

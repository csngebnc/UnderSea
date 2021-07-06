// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'building_details_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BuildingDetailsDto _$BuildingDetailsDtoFromJson(Map<String, dynamic> json) {
  return BuildingDetailsDto(
    effects: (json['effects'] as List<dynamic>?)
        ?.map((e) => EffectDto.fromJson(e as Map<String, dynamic>))
        .toList(),
    requiredMaterials: (json['requiredMaterials'] as List<dynamic>?)
        ?.map((e) => MaterialDto.fromJson(e as Map<String, dynamic>))
        .toList(),
    id: json['id'] as int,
    count: json['count'] as int,
    name: json['name'] as String?,
    underConstruction: json['underConstruction'] as bool,
    imageUrl: json['imageUrl'] as String,
  );
}

Map<String, dynamic> _$BuildingDetailsDtoToJson(BuildingDetailsDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'count': instance.count,
      'requiredMaterials': instance.requiredMaterials,
      'underConstruction': instance.underConstruction,
      'effects': instance.effects,
      'imageUrl': instance.imageUrl,
      'name': instance.name,
    };

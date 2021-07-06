// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'unit_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UnitDto _$UnitDtoFromJson(Map<String, dynamic> json) {
  return UnitDto(
    id: json['id'] as int,
    name: json['name'] as String,
    attackPoint: json['attackPoint'] as int,
    defensePoint: json['defensePoint'] as int,
    currentCount: json['currentCount'] as int,
    mercenaryPerRound: json['mercenaryPerRound'] as int,
    requiredMaterials: (json['requiredMaterials'] as List<dynamic>?)
        ?.map((e) => MaterialDto.fromJson(e as Map<String, dynamic>))
        .toList(),
    supplyPerRound: json['supplyPerRound'] as int,
  );
}

Map<String, dynamic> _$UnitDtoToJson(UnitDto instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'attackPoint': instance.attackPoint,
      'defensePoint': instance.defensePoint,
      'mercenaryPerRound': instance.mercenaryPerRound,
      'supplyPerRound': instance.supplyPerRound,
      'requiredMaterials': instance.requiredMaterials,
      'currentCount': instance.currentCount,
    };

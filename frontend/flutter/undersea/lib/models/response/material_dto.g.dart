// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'material_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MaterialDto _$MaterialDtoFromJson(Map<String, dynamic> json) {
  return MaterialDto(
    id: json['id'] as int,
    amount: json['amount'] as int,
    imageUrl: json['imageUrl'] as String?,
    name: json['name'] as String?,
  );
}

Map<String, dynamic> _$MaterialDtoToJson(MaterialDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'amount': instance.amount,
      'imageUrl': instance.imageUrl,
    };

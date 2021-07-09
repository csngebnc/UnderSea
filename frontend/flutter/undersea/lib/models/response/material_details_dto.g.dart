// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'material_details_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MaterialDetailsDto _$MaterialDetailsDtoFromJson(Map<String, dynamic> json) {
  return MaterialDetailsDto(
    production: json['production'] as int,
    id: json['id'] as int,
    amount: json['amount'] as int,
    imageUrl: json['imageUrl'] as String?,
    name: json['name'] as String?,
  );
}

Map<String, dynamic> _$MaterialDetailsDtoToJson(MaterialDetailsDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'amount': instance.amount,
      'production': instance.production,
      'imageUrl': instance.imageUrl,
    };

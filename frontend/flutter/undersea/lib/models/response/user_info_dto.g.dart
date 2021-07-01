// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_info_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserInfoDto _$UserInfoDtoFromJson(Map<String, dynamic> json) {
  return UserInfoDto(
    name: json['name'] as String?,
    placement: json['placement'] as int,
    id: json['id'] as int?,
    round: json['round'] as int,
  );
}

Map<String, dynamic> _$UserInfoDtoToJson(UserInfoDto instance) =>
    <String, dynamic>{
      'name': instance.name,
      'round': instance.round,
      'placement': instance.placement,
      'id': instance.id,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attackable_user_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AttackableUserDto _$AttackableUserDtoFromJson(Map<String, dynamic> json) {
  return AttackableUserDto(
    id: json['id'] as String?,
    countryId: json['countryId'] as int,
    userName: json['userName'] as String?,
  );
}

Map<String, dynamic> _$AttackableUserDtoToJson(AttackableUserDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userName': instance.userName,
      'countryId': instance.countryId,
    };

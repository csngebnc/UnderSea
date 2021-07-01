// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attackable_user_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AttackableUserDto _$AttackableUserDtoFromJson(Map<String, dynamic> json) {
  return AttackableUserDto(
    number: json['number'] as int,
    countryId: json['countryId'] as int,
    username: json['username'] as String,
  );
}

Map<String, dynamic> _$AttackableUserDtoToJson(AttackableUserDto instance) =>
    <String, dynamic>{
      'number': instance.number,
      'username': instance.username,
      'countryId': instance.countryId,
    };

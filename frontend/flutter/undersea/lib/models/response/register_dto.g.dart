// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegisterDto _$RegisterDtoFromJson(Map<String, dynamic> json) {
  return RegisterDto(
    userName: json['userName'] as String,
    password: json['password'] as String,
    confirmPassword: json['confirmPassword'] as String,
    countryName: json['countryName'] as String,
  );
}

Map<String, dynamic> _$RegisterDtoToJson(RegisterDto instance) =>
    <String, dynamic>{
      'userName': instance.userName,
      'password': instance.password,
      'confirmPassword': instance.confirmPassword,
      'countryName': instance.countryName,
    };

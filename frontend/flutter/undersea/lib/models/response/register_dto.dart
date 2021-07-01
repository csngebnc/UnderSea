import 'package:json_annotation/json_annotation.dart';

part 'register_dto.g.dart';

@JsonSerializable()
class RegisterDto {
  String userName;
  String password;
  String confirmPassword;
  String countryName;

  RegisterDto(
      {required this.userName,
      required this.password,
      required this.confirmPassword,
      required this.countryName});

  factory RegisterDto.fromJson(Map<String, dynamic> json) =>
      _$RegisterDtoFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$RegisterDtoToJson(this);
}

import 'package:json_annotation/json_annotation.dart';

part 'attackable_user_dto.g.dart';

@JsonSerializable()
class AttackableUserDto {
  int number;
  String username;
  int countryId;

  AttackableUserDto(
      {required this.number, required this.countryId, required this.username});

  factory AttackableUserDto.fromJson(Map<String, dynamic> json) =>
      _$AttackableUserDtoFromJson(json);

  Map<String, dynamic> toJson() => _$AttackableUserDtoToJson(this);
}

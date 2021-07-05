import 'package:json_annotation/json_annotation.dart';

part 'attackable_user_dto.g.dart';

@JsonSerializable()
class AttackableUserDto {
  String? id;
  String? userName;
  int countryId;

  AttackableUserDto({this.id, required this.countryId, this.userName});

  factory AttackableUserDto.fromJson(Map<String, dynamic> json) =>
      _$AttackableUserDtoFromJson(json);

  Map<String, dynamic> toJson() => _$AttackableUserDtoToJson(this);
}

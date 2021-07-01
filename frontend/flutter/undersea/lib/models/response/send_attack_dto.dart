import 'package:json_annotation/json_annotation.dart';

import 'attack_unit_dto.dart';

part 'send_attack_dto.g.dart';

@JsonSerializable()
class SendAttackDto {
  int attackedCountryId;
  List<AttackUnitDto> units;

  SendAttackDto({required this.attackedCountryId, required this.units});

  factory SendAttackDto.fromJson(Map<String, dynamic> json) =>
      _$SendAttackDtoFromJson(json);

  Map<String, dynamic> toJson() => _$SendAttackDtoToJson(this);
}

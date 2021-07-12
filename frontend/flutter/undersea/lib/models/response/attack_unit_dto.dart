import 'package:json_annotation/json_annotation.dart';

part 'attack_unit_dto.g.dart';

@JsonSerializable()
class AttackUnitDto {
  int unitId;
  int count;
  int level;

  AttackUnitDto(
      {required this.unitId, required this.count, required this.level});

  factory AttackUnitDto.fromJson(Map<String, dynamic> json) =>
      _$AttackUnitDtoFromJson(json);

  Map<String, dynamic> toJson() => _$AttackUnitDtoToJson(this);
}

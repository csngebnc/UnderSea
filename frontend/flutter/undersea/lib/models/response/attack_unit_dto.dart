import 'package:json_annotation/json_annotation.dart';

part 'attack_unit_dto.g.dart';

@JsonSerializable()
class AttackUnitDto {
  int unitId;
  int count;

  AttackUnitDto({required this.unitId, required this.count});

  factory AttackUnitDto.fromJson(Map<String, dynamic> json) =>
      _$AttackUnitDtoFromJson(json);

  Map<String, dynamic> toJson() => _$AttackUnitDtoToJson(this);
}

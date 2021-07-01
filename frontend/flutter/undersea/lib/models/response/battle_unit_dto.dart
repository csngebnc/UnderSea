import 'package:json_annotation/json_annotation.dart';

part 'battle_unit_dto.g.dart';

@JsonSerializable()
class BattleUnitDto {
  int id;
  String name;
  int count;

  BattleUnitDto({required this.id, required this.name, required this.count});

  factory BattleUnitDto.fromJson(Map<String, dynamic> json) =>
      _$BattleUnitDtoFromJson(json);

  Map<String, dynamic> toJson() => _$BattleUnitDtoToJson(this);
}

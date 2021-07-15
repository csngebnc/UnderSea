import 'package:json_annotation/json_annotation.dart';
import 'package:undersea/models/response/event_dto.dart';

part 'battle_unit_dto.g.dart';

@JsonSerializable()
class BattleUnitDto {
  int id;
  String name;
  int count;
  int level;
  String? iconImageUrl;
  EventDto? event;

  BattleUnitDto(
      {this.iconImageUrl,
      required this.id,
      required this.level,
      required this.name,
      required this.count,
      this.event});

  factory BattleUnitDto.fromJson(Map<String, dynamic> json) =>
      _$BattleUnitDtoFromJson(json);

  Map<String, dynamic> toJson() => _$BattleUnitDtoToJson(this);
}

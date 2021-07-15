import 'package:json_annotation/json_annotation.dart';
import 'package:undersea/models/response/effect_dto.dart';

part 'event_dto.g.dart';

@JsonSerializable()
class EventDto {
  int id;
  String? name;
  int eventRound;
  List<EffectDto>? effects;

  EventDto(
      {required this.id, required this.eventRound, this.name, this.effects});

  factory EventDto.fromJson(Map<String, dynamic> json) =>
      _$EventDtoFromJson(json);

  Map<String, dynamic> toJson() => _$EventDtoToJson(this);
}

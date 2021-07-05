import 'package:json_annotation/json_annotation.dart';

part 'send_spy_dto.g.dart';

@JsonSerializable()
class SendSpyDto {
  int spiedCountryId;
  int spyCount;

  SendSpyDto({required this.spiedCountryId, required this.spyCount});

  factory SendSpyDto.fromJson(Map<String, dynamic> json) =>
      _$SendSpyDtoFromJson(json);

  Map<String, dynamic> toJson() => _$SendSpyDtoToJson(this);
}

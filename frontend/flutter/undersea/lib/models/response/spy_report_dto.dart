import 'package:json_annotation/json_annotation.dart';
import 'package:undersea/models/fight_outcome.dart';

part 'spy_report_dto.g.dart';

@JsonSerializable()
class SpyReportDto {
  int spyReportId;
  FightOutcome outCome;
  String? spiedCountryName;
  int? defensePoints;

  SpyReportDto(
      {this.spiedCountryName,
      required this.outCome,
      this.defensePoints,
      required this.spyReportId});

  factory SpyReportDto.fromJson(Map<String, dynamic> json) =>
      _$SpyReportDtoFromJson(json);

  Map<String, dynamic> toJson() => _$SpyReportDtoToJson(this);
}

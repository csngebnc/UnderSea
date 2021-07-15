import 'package:json_annotation/json_annotation.dart';

part 'world_winner_dto.g.dart';

@JsonSerializable()
class WorldWinnerDto {
  int id;
  String? userName;
  String? countryName;
  int worldRound;
  DateTime date;
  int points;

  WorldWinnerDto(
      {required this.id,
      required this.points,
      required this.date,
      required this.worldRound,
      this.userName,
      this.countryName});

  factory WorldWinnerDto.fromJson(Map<String, dynamic> json) =>
      _$WorldWinnerDtoFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$WorldWinnerDtoToJson(this);
}

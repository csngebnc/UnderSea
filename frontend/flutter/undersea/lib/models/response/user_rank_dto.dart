import 'package:json_annotation/json_annotation.dart';

part 'user_rank_dto.g.dart';

@JsonSerializable()
class UserRankDto {
  String? name;
  int points;
  int placement;

  UserRankDto(
      {required this.name, required this.points, required this.placement});

  factory UserRankDto.fromJson(Map<String, dynamic> json) =>
      _$UserRankDtoFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$UserRankDtoToJson(this);
}

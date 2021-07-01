import 'package:json_annotation/json_annotation.dart';

part 'buy_building_dto.g.dart';

@JsonSerializable()
class BuyBuildingDto {
  int buildingId;

  BuyBuildingDto({
    required this.buildingId,
  });

  factory BuyBuildingDto.fromJson(Map<String, dynamic> json) =>
      _$BuyBuildingDtoFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$BuyBuildingDtoToJson(this);
}

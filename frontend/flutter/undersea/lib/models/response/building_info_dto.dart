import 'package:json_annotation/json_annotation.dart';

part 'building_info_dto.g.dart';

@JsonSerializable()
class BuildingInfoDto {
  String name;
  int buildingsCount;
  int activeConstructionCount;
  int id;
  String iconImageUrl;

  BuildingInfoDto(
      {required this.name,
      required this.buildingsCount,
      required this.id,
      required this.activeConstructionCount,
      required this.iconImageUrl});

  factory BuildingInfoDto.fromJson(Map<String, dynamic> json) =>
      _$BuildingInfoDtoFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$BuildingInfoDtoToJson(this);
}

import 'package:json_annotation/json_annotation.dart';
import 'package:undersea/models/response/building_details_dto.dart';
import 'effect_dto.dart';

part 'building_details_list.g.dart';

@JsonSerializable()
class BuildingDetailsList {
  List<BuildingDetailsDto> buildings;

  BuildingDetailsList({required this.buildings});

  factory BuildingDetailsList.fromJson(Map<String, dynamic> json) =>
      _$BuildingDetailsListFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$BuildingDetailsListToJson(this);
}

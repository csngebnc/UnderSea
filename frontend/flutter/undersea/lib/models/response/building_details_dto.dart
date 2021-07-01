import 'package:json_annotation/json_annotation.dart';
import 'effect_dto.dart';

part 'building_details_dto.g.dart';

@JsonSerializable()
class BuildingDetailsDto {
  int id;
  int count;
  int price;
  bool underConstruction;
  List<EffectDto>? effects;
  String? name;

  BuildingDetailsDto(
      {this.effects,
      required this.price,
      required this.id,
      required this.count,
      required this.name,
      required this.underConstruction});

  factory BuildingDetailsDto.fromJson(Map<String, dynamic> json) =>
      _$BuildingDetailsDtoFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$BuildingDetailsDtoToJson(this);
}

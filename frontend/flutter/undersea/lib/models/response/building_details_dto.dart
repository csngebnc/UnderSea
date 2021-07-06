import 'package:json_annotation/json_annotation.dart';
import 'effect_dto.dart';
import 'material_dto.dart';

part 'building_details_dto.g.dart';

@JsonSerializable()
class BuildingDetailsDto {
  int id;
  int count;
  List<MaterialDto>? requiredMaterials;
  bool underConstruction;
  List<EffectDto>? effects;
  String imageUrl;
  String? name;

  BuildingDetailsDto(
      {this.effects,
      this.requiredMaterials,
      required this.id,
      required this.count,
      required this.name,
      required this.underConstruction,
      required this.imageUrl});

  factory BuildingDetailsDto.fromJson(Map<String, dynamic> json) =>
      _$BuildingDetailsDtoFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$BuildingDetailsDtoToJson(this);
}

import 'package:json_annotation/json_annotation.dart';

import 'material_dto.dart';

part 'unit_dto.g.dart';

@JsonSerializable()
class UnitDto {
  int id;
  String name;
  int attackPoint;
  int defensePoint;
  int mercenaryPerRound;
  int supplyPerRound;
  List<MaterialDto>? requiredMaterials;
  int currentCount;

  UnitDto(
      {required this.id,
      required this.name,
      required this.attackPoint,
      required this.defensePoint,
      required this.currentCount,
      required this.mercenaryPerRound,
      this.requiredMaterials,
      required this.supplyPerRound});

  factory UnitDto.fromJson(Map<String, dynamic> json) =>
      _$UnitDtoFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$UnitDtoToJson(this);
}

import 'package:json_annotation/json_annotation.dart';

part 'material_dto.g.dart';

@JsonSerializable()
class MaterialDto {
  int id;
  String? name;
  int amount;
  String? imageUrl;

  MaterialDto(
      {required this.id, required this.amount, this.imageUrl, this.name});

  factory MaterialDto.fromJson(Map<String, dynamic> json) =>
      _$MaterialDtoFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$MaterialDtoToJson(this);
}

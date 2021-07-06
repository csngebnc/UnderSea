import 'package:json_annotation/json_annotation.dart';

part 'material_details_dto.g.dart';

@JsonSerializable()
class MaterialDetailsDto {
  int id;
  String? name;
  int amount;
  int production;
  String? imageUrl;

  MaterialDetailsDto(
      {required this.production,
      required this.id,
      required this.amount,
      this.imageUrl,
      this.name});

  factory MaterialDetailsDto.fromJson(Map<String, dynamic> json) =>
      _$MaterialDetailsDtoFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$MaterialDetailsDtoToJson(this);
}

import 'package:json_annotation/json_annotation.dart';

part 'image_raw_data.g.dart';

//flutter pub run build_runner build --delete-conflicting-outputs

@JsonSerializable()
class ImageRawData {
  ImageRawData(this.name, this.image);

  @JsonKey(name: 'name')
  String? name;

  @JsonKey(name: 'image')
  String? image;

  @JsonKey(name: 'isSelected')
  bool isSelected = false;

  factory ImageRawData.fromJson(Map<String, dynamic> json) => _$ImageRawDataFromJson(json);

  Map<String, dynamic> toJson() => _$ImageRawDataToJson(this);
}

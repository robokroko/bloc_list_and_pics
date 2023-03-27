import 'package:json_annotation/json_annotation.dart';

part 'image_details.g.dart';

//flutter pub run build_runner build --delete-conflicting-outputs

@JsonSerializable()
class ImageDetails {
  ImageDetails(this.name, this.image, this.text);

  @JsonKey(name: 'name')
  String name;

  @JsonKey(name: 'image')
  String image;

  @JsonKey(name: 'text')
  String text;

  factory ImageDetails.fromJson(Map<String, dynamic> json) => _$ImageDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$ImageDetailsToJson(this);
}

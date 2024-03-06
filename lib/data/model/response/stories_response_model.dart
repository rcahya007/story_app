import 'package:json_annotation/json_annotation.dart';

part 'stories_response_model.g.dart';

@JsonSerializable()
class StoriesResponseModel {
  final bool? error;
  final String? message;
  final List<ListStory>? listStory;

  StoriesResponseModel({
    this.error,
    this.message,
    this.listStory,
  });

  factory StoriesResponseModel.fromJson(Map<String, dynamic> json) =>
      _$StoriesResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$StoriesResponseModelToJson(this);
}

@JsonSerializable()
class ListStory {
  final String? id;
  final String? name;
  final String? description;
  final String? photoUrl;
  final DateTime? createdAt;
  final double? lat;
  final double? lon;

  ListStory({
    this.id,
    this.name,
    this.description,
    this.photoUrl,
    this.createdAt,
    this.lat,
    this.lon,
  });

  factory ListStory.fromJson(Map<String, dynamic> json) =>
      _$ListStoryFromJson(json);

  Map<String, dynamic> toJson() => _$ListStoryToJson(this);
}

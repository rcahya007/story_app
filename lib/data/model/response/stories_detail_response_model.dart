import 'package:json_annotation/json_annotation.dart';

part 'stories_detail_response_model.g.dart';

@JsonSerializable()
class StoriesDetailResponseModel {
  final bool? error;
  final String? message;
  final Story? story;

  StoriesDetailResponseModel({
    this.error,
    this.message,
    this.story,
  });

  factory StoriesDetailResponseModel.fromJson(Map<String, dynamic> json) =>
      _$StoriesDetailResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$StoriesDetailResponseModelToJson(this);
}

@JsonSerializable()
class Story {
  final String? id;
  final String? name;
  final String? description;
  final String? photoUrl;
  final DateTime? createdAt;
  final dynamic lat;
  final dynamic lon;

  Story({
    this.id,
    this.name,
    this.description,
    this.photoUrl,
    this.createdAt,
    this.lat,
    this.lon,
  });

  factory Story.fromJson(Map<String, dynamic> json) => _$StoryFromJson(json);
  Map<String, dynamic> toJson() => _$StoryToJson(this);
}

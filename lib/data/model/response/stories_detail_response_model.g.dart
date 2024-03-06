// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stories_detail_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StoriesDetailResponseModel _$StoriesDetailResponseModelFromJson(
        Map<String, dynamic> json) =>
    StoriesDetailResponseModel(
      error: json['error'] as bool?,
      message: json['message'] as String?,
      story: json['story'] == null
          ? null
          : Story.fromJson(json['story'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$StoriesDetailResponseModelToJson(
        StoriesDetailResponseModel instance) =>
    <String, dynamic>{
      'error': instance.error,
      'message': instance.message,
      'story': instance.story,
    };

Story _$StoryFromJson(Map<String, dynamic> json) => Story(
      id: json['id'] as String?,
      name: json['name'] as String?,
      description: json['description'] as String?,
      photoUrl: json['photoUrl'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      lat: json['lat'],
      lon: json['lon'],
    );

Map<String, dynamic> _$StoryToJson(Story instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'photoUrl': instance.photoUrl,
      'createdAt': instance.createdAt?.toIso8601String(),
      'lat': instance.lat,
      'lon': instance.lon,
    };

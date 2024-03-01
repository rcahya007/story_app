// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class StoriesResponseModel {
  final bool? error;
  final String? message;
  final List<ListStory>? listStory;

  StoriesResponseModel({
    this.error,
    this.message,
    this.listStory,
  });

  factory StoriesResponseModel.fromJson(String str) =>
      StoriesResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory StoriesResponseModel.fromMap(Map<String, dynamic> json) =>
      StoriesResponseModel(
        error: json["error"],
        message: json["message"],
        listStory: json["listStory"] == null
            ? []
            : List<ListStory>.from(
                json["listStory"]!.map((x) => ListStory.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "error": error,
        "message": message,
        "listStory": listStory == null
            ? []
            : List<dynamic>.from(listStory!.map((x) => x.toMap())),
      };
}

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

  factory ListStory.fromJson(String str) => ListStory.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ListStory.fromMap(Map<String, dynamic> json) => ListStory(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        photoUrl: json["photoUrl"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        lat: json["lat"]?.toDouble(),
        lon: json["lon"]?.toDouble(),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "description": description,
        "photoUrl": photoUrl,
        "createdAt": createdAt?.toIso8601String(),
        "lat": lat,
        "lon": lon,
      };

  ListStory copyWith({
    String? id,
    String? name,
    String? description,
    String? photoUrl,
    DateTime? createdAt,
    double? lat,
    double? lon,
  }) {
    return ListStory(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      photoUrl: photoUrl ?? this.photoUrl,
      createdAt: createdAt ?? this.createdAt,
      lat: lat ?? this.lat,
      lon: lon ?? this.lon,
    );
  }
}

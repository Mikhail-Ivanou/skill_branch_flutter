import 'dart:convert';

import 'package:FlutterGalleryApp/models/photo.dart';

List<Collection> collectionFromJson(String str) =>
    List<Collection>.from(json.decode(str).map((x) => Collection.fromJson(x)));

String collectionToJson(List<Collection> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Collection {
  Collection({
    this.id,
    this.title,
    this.description,
    this.publishedAt,
    this.lastCollectedAt,
    this.updatedAt,
    this.totalPhotos,
    this.private,
    this.shareKey,
    this.coverPhoto,
  });

  final String id;
  final String title;
  final String description;
  final DateTime publishedAt;
  final DateTime lastCollectedAt;
  final DateTime updatedAt;
  final int totalPhotos;
  final bool private;
  final String shareKey;
  final Photo coverPhoto;

  factory Collection.fromJson(Map<String, dynamic> json) => Collection(
        id: json["id"] == null ? null : json["id"],
        title: json["title"] == null ? null : json["title"],
        description: json["description"] == null ? null : json["description"],
        publishedAt: json["published_at"] == null ? null : DateTime.parse(json["published_at"]),
        lastCollectedAt: json["last_collected_at"] == null ? null : DateTime.parse(json["last_collected_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        totalPhotos: json["total_photos"] == null ? null : json["total_photos"],
        private: json["private"] == null ? null : json["private"],
        shareKey: json["share_key"] == null ? null : json["share_key"],
        coverPhoto: json["cover_photo"] == null ? null : Photo.fromJson(json["cover_photo"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "title": title == null ? null : title,
        "description": description == null ? null : description,
        "published_at": publishedAt == null ? null : publishedAt.toIso8601String(),
        "last_collected_at": lastCollectedAt == null ? null : lastCollectedAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
        "total_photos": totalPhotos == null ? null : totalPhotos,
        "private": private == null ? null : private,
        "share_key": shareKey == null ? null : shareKey,
        "cover_photo": coverPhoto == null ? null : coverPhoto.toJson(),
      };
}

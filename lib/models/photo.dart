import 'dart:convert';

import 'package:FlutterGalleryApp/models/user.dart';

Photo photoFromJson(String str) => Photo.fromJson(json.decode(str));

String photoToJson(Photo data) => json.encode(data.toJson());

class Photo {
  Photo({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.width,
    this.height,
    this.color,
    this.blurHash,
    this.downloads,
    this.likes,
    this.likedByUser,
    this.description,
    this.exif,
    this.location,
    this.tags,
    this.currentUserCollections,
    this.urls,
    this.links,
    this.user,
  });

  String id;
  DateTime createdAt;
  DateTime updatedAt;
  int width;
  int height;
  String color;
  String blurHash;
  int downloads;
  int likes;
  bool likedByUser;
  String description;
  Exif exif;
  Location location;
  List<Tag> tags;
  List<CurrentUserCollection> currentUserCollections;
  Urls urls;
  PhotoLinks links;
  User user;

  factory Photo.fromJson(Map<String, dynamic> json) => Photo(
        id: json["id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        width: json["width"],
        height: json["height"],
        color: json["color"],
        blurHash: json["blur_hash"],
        downloads: json["downloads"],
        likes: json["likes"],
        likedByUser: json["liked_by_user"],
        description: json["description"],
        exif: Exif.fromJson(json["exif"]),
        location: Location.fromJson(json["location"]),
        tags: json["tags"] == null ? null : List<Tag>.from(json["tags"].map((x) => Tag.fromJson(x))),
        currentUserCollections: json["current_user_collections"] == null
            ? null
            : List<CurrentUserCollection>.from(
                json["current_user_collections"].map((x) => CurrentUserCollection.fromJson(x))),
        urls: Urls.fromJson(json["urls"]),
        links: PhotoLinks.fromJson(json["links"]),
        user: User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "width": width,
        "height": height,
        "color": color,
        "blur_hash": blurHash,
        "downloads": downloads,
        "likes": likes,
        "liked_by_user": likedByUser,
        "description": description,
        "exif": exif.toJson(),
        "location": location.toJson(),
        "tags": List<dynamic>.from(tags.map((x) => x.toJson())),
        "current_user_collections": List<dynamic>.from(currentUserCollections.map((x) => x.toJson())),
        "urls": urls.toJson(),
        "links": links.toJson(),
        "user": user.toJson(),
      };
}

class CurrentUserCollection {
  CurrentUserCollection({
    this.id,
    this.title,
    this.publishedAt,
    this.lastCollectedAt,
    this.updatedAt,
    this.coverPhoto,
    this.user,
  });

  int id;
  String title;
  DateTime publishedAt;
  DateTime lastCollectedAt;
  DateTime updatedAt;
  dynamic coverPhoto;
  dynamic user;

  factory CurrentUserCollection.fromJson(Map<String, dynamic> json) => CurrentUserCollection(
        id: json["id"],
        title: json["title"],
        publishedAt: DateTime.parse(json["published_at"]),
        lastCollectedAt: DateTime.parse(json["last_collected_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        coverPhoto: json["cover_photo"],
        user: json["user"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "published_at": publishedAt.toIso8601String(),
        "last_collected_at": lastCollectedAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "cover_photo": coverPhoto,
        "user": user,
      };
}

class Exif {
  Exif({
    this.make,
    this.model,
    this.exposureTime,
    this.aperture,
    this.focalLength,
    this.iso,
  });

  String make;
  String model;
  String exposureTime;
  String aperture;
  String focalLength;
  int iso;

  factory Exif.fromJson(Map<String, dynamic> json) => json == null
      ? null
      : Exif(
          make: json["make"],
          model: json["model"],
          exposureTime: json["exposure_time"],
          aperture: json["aperture"],
          focalLength: json["focal_length"],
          iso: json["iso"],
        );

  Map<String, dynamic> toJson() => {
        "make": make,
        "model": model,
        "exposure_time": exposureTime,
        "aperture": aperture,
        "focal_length": focalLength,
        "iso": iso,
      };
}

class PhotoLinks {
  PhotoLinks({
    this.self,
    this.html,
    this.download,
    this.downloadLocation,
  });

  String self;
  String html;
  String download;
  String downloadLocation;

  factory PhotoLinks.fromJson(Map<String, dynamic> json) => json == null
      ? null
      : PhotoLinks(
          self: json["self"],
          html: json["html"],
          download: json["download"],
          downloadLocation: json["download_location"],
        );

  Map<String, dynamic> toJson() => {
        "self": self,
        "html": html,
        "download": download,
        "download_location": downloadLocation,
      };
}

class Location {
  Location({
    this.city,
    this.country,
    this.position,
  });

  String city;
  String country;
  Position position;

  factory Location.fromJson(Map<String, dynamic> json) => json == null
      ? null
      : Location(
          city: json["city"],
          country: json["country"],
          position: Position.fromJson(json["position"]),
        );

  Map<String, dynamic> toJson() => {
        "city": city,
        "country": country,
        "position": position.toJson(),
      };
}

class Position {
  Position({
    this.latitude,
    this.longitude,
  });

  double latitude;
  double longitude;

  factory Position.fromJson(Map<String, dynamic> json) => json == null
      ? null
      : Position(
          latitude: json["latitude"].toDouble(),
          longitude: json["longitude"].toDouble(),
        );

  Map<String, dynamic> toJson() => {
        "latitude": latitude,
        "longitude": longitude,
      };
}

class Tag {
  Tag({
    this.title,
  });

  String title;

  factory Tag.fromJson(Map<String, dynamic> json) => json == null
      ? null
      : Tag(
          title: json["title"],
        );

  Map<String, dynamic> toJson() => {
        "title": title,
      };
}

class Urls {
  Urls({
    this.raw,
    this.full,
    this.regular,
    this.small,
    this.thumb,
  });

  String raw;
  String full;
  String regular;
  String small;
  String thumb;

  factory Urls.fromJson(Map<String, dynamic> json) => Urls(
        raw: json["raw"],
        full: json["full"],
        regular: json["regular"],
        small: json["small"],
        thumb: json["thumb"],
      );

  Map<String, dynamic> toJson() => {
        "raw": raw,
        "full": full,
        "regular": regular,
        "small": small,
        "thumb": thumb,
      };
}

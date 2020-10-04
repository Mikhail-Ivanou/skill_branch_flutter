import 'dart:convert';

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
        tags: json["tags"] == null
            ? null
            : List<Tag>.from(json["tags"].map((x) => Tag.fromJson(x))),
        currentUserCollections: json["current_user_collections"] == null
            ? null
            : List<CurrentUserCollection>.from(json["current_user_collections"]
                .map((x) => CurrentUserCollection.fromJson(x))),
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
        "current_user_collections":
            List<dynamic>.from(currentUserCollections.map((x) => x.toJson())),
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

  factory CurrentUserCollection.fromJson(Map<String, dynamic> json) =>
      CurrentUserCollection(
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

class User {
  User({
    this.id,
    this.updatedAt,
    this.username,
    this.name,
    this.firstName,
    this.lastName,
    this.twitterUsername,
    this.portfolioUrl,
    this.bio,
    this.location,
    this.links,
    this.profileImage,
    this.instagramUsername,
    this.totalCollections,
    this.totalLikes,
    this.totalPhotos,
    this.acceptedTos,
  });

  final String id;
  final DateTime updatedAt;
  final String username;
  final String name;
  final String firstName;
  final String lastName;
  final String twitterUsername;
  final String portfolioUrl;
  final String bio;
  final String location;
  final UserLinks links;
  final ProfileImage profileImage;
  final String instagramUsername;
  final int totalCollections;
  final int totalLikes;
  final int totalPhotos;
  final bool acceptedTos;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"] == null ? null : json["id"],
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        username: json["username"] == null ? null : json["username"],
        name: json["name"] == null ? null : json["name"],
        firstName: json["first_name"] == null ? null : json["first_name"],
        lastName: json["last_name"] == null ? null : json["last_name"],
        twitterUsername:
            json["twitter_username"] == null ? null : json["twitter_username"],
        portfolioUrl:
            json["portfolio_url"] == null ? null : json["portfolio_url"],
        bio: json["bio"] == null ? null : json["bio"],
        location: json["location"] == null ? null : json["location"],
        links: json["links"] == null ? null : UserLinks.fromJson(json["links"]),
        profileImage: json["profile_image"] == null
            ? null
            : ProfileImage.fromJson(json["profile_image"]),
        instagramUsername: json["instagram_username"] == null
            ? null
            : json["instagram_username"],
        totalCollections: json["total_collections"] == null
            ? null
            : json["total_collections"],
        totalLikes: json["total_likes"] == null ? null : json["total_likes"],
        totalPhotos: json["total_photos"] == null ? null : json["total_photos"],
        acceptedTos: json["accepted_tos"] == null ? null : json["accepted_tos"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
        "username": username == null ? null : username,
        "name": name == null ? null : name,
        "first_name": firstName == null ? null : firstName,
        "last_name": lastName == null ? null : lastName,
        "twitter_username": twitterUsername == null ? null : twitterUsername,
        "portfolio_url": portfolioUrl == null ? null : portfolioUrl,
        "bio": bio == null ? null : bio,
        "location": location == null ? null : location,
        "links": links == null ? null : links.toJson(),
        "profile_image": profileImage == null ? null : profileImage.toJson(),
        "instagram_username":
            instagramUsername == null ? null : instagramUsername,
        "total_collections": totalCollections == null ? null : totalCollections,
        "total_likes": totalLikes == null ? null : totalLikes,
        "total_photos": totalPhotos == null ? null : totalPhotos,
        "accepted_tos": acceptedTos == null ? null : acceptedTos,
      };
}

class UserLinks {
  UserLinks({
    this.self,
    this.html,
    this.photos,
    this.likes,
    this.portfolio,
    this.following,
    this.followers,
  });

  final String self;
  final String html;
  final String photos;
  final String likes;
  final String portfolio;
  final String following;
  final String followers;

  factory UserLinks.fromJson(Map<String, dynamic> json) => json == null
      ? null
      : UserLinks(
          self: json["self"] == null ? null : json["self"],
          html: json["html"] == null ? null : json["html"],
          photos: json["photos"] == null ? null : json["photos"],
          likes: json["likes"] == null ? null : json["likes"],
          portfolio: json["portfolio"] == null ? null : json["portfolio"],
          following: json["following"] == null ? null : json["following"],
          followers: json["followers"] == null ? null : json["followers"],
        );

  Map<String, dynamic> toJson() => {
        "self": self == null ? null : self,
        "html": html == null ? null : html,
        "photos": photos == null ? null : photos,
        "likes": likes == null ? null : likes,
        "portfolio": portfolio == null ? null : portfolio,
        "following": following == null ? null : following,
        "followers": followers == null ? null : followers,
      };
}

class ProfileImage {
  ProfileImage({
    this.small,
    this.medium,
    this.large,
  });

  final String small;
  final String medium;
  final String large;

  factory ProfileImage.fromJson(Map<String, dynamic> json) => json == null
      ? null
      : ProfileImage(
          small: json["small"] == null ? null : json["small"],
          medium: json["medium"] == null ? null : json["medium"],
          large: json["large"] == null ? null : json["large"],
        );

  Map<String, dynamic> toJson() => {
        "small": small == null ? null : small,
        "medium": medium == null ? null : medium,
        "large": large == null ? null : large,
      };
}

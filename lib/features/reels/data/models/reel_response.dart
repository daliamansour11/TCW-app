

class ReelsResponse {
  ReelsResponse({
    required this.userId,
    required this.videoPath,
    required this.caption,
    required this.updatedAt,
    required this.createdAt,
    required this.id,
    required this.videoUrl,
    required this.thumbnailUrl,
    required this.user,
  });

  final int? userId;
  final String? videoPath;
  final String? caption;
  final DateTime? updatedAt;
  final DateTime? createdAt;
  final int? id;
  final String? videoUrl;
  final dynamic thumbnailUrl;
  final User? user;

  factory ReelsResponse.fromJson(Map<String, dynamic> json){
    return ReelsResponse(
      userId: json["user_id"],
      videoPath: json["video_path"],
      caption: json["caption"],
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      id: json["id"],
      videoUrl: json["video_url"],
      thumbnailUrl: json["thumbnail_url"],
      user: json["user"] == null ? null : User.fromJson(json["user"]),
    );
  }

}

class User {
  User({
    required this.id,
    required this.name,
    required this.image,
    required this.imageUrl,
  });

  final int? id;
  final String? name;
  final dynamic image;
  final String? imageUrl;

  factory User.fromJson(Map<String, dynamic> json){
    return User(
      id: json["id"],
      name: json["name"],
      image: json["image"],
      imageUrl: json["image_url"],
    );
  }

}

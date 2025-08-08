class AddCommentResponseModel {

  factory AddCommentResponseModel.fromJson(Map<String, dynamic> json){
    return AddCommentResponseModel(
      userId: json['user_id'],
      content: json['content'],
      reelId: json['reel_id'],
      updatedAt: DateTime.tryParse(json['updated_at'] ?? ''),
      createdAt: DateTime.tryParse(json['created_at'] ?? ''),
      id: json['id'],
      user: json['user'] == null ? null : User.fromJson(json['user']),
      commentsCount: json['comments_count'],
    );
  }
  AddCommentResponseModel({
    required this.userId,
    required this.content,
    required this.reelId,
    required this.updatedAt,
    required this.createdAt,
    required this.id,
    required this.user,
    this.commentsCount,
  });

  final int? userId;
  final String? content;
  final int? reelId;
  final DateTime? updatedAt;
  final DateTime? createdAt;
  final int? id;
  final User? user;
  final int? commentsCount;

}

class User {

  factory User.fromJson(Map<String, dynamic> json){
    return User(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      imageUrl: json['image_url'],
    );
  }
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

}

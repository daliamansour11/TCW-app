
import 'package:tcw/features/reels/data/models/reel_model.dart';

class ReelHistoryModel {
  factory ReelHistoryModel.fromJson(Map<String, dynamic> json) =>
      ReelHistoryModel(
        id: json['id'] as int? ?? 0,
        caption: json['caption'] as String? ?? '',
        watchedAt: DateTime.tryParse(json['watchedAt'] as String? ?? '') ?? DateTime.now(),
        viewsCount: _parseInt(json['views_count']),
        likesCount: _parseInt(json['likes_count']),
        commentsCount: _parseInt(json['comments_count']),
        isActive: _parseInt(json['is_active']),
        createdAt: DateTime.tryParse(json['created_at'] as String? ?? ''),
        updatedAt: DateTime.tryParse(json['updated_at'] as String? ?? ''),
        videoUrl: json['video_url'] as String? ?? '',
        thumbnailUrl: json['thumbnail_url'] as String? ?? '',
        user: json['user'] != null
            ? User.fromJson(json['user'] as Map<String, dynamic>)
            : User(id: 0, name: '', image: '', imageUrl: ''),
        isLiked: json['is_liked'] == true || json['is_liked']?.toString() == '1',
        userId: _parseInt(json['user_id']),
        videoPath: json['video_path'] as String? ?? '',
        thumbnailPath: json['thumbnail_path'] as String? ?? '',
      );

  static int _parseInt(dynamic value) {
    if (value == null) return 0;
    if (value is int) return value;
    if (value is String) return int.tryParse(value) ?? 0;
    return 0;
  }

  ReelHistoryModel({
    required this.id,
    required this.userId,
    required this.videoPath,
    required this.thumbnailPath,
    required this.caption,
    required this.viewsCount,
    required this.likesCount,
    required this.commentsCount,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
    required this.videoUrl,
    required this.thumbnailUrl,
    required this.user,
    required this.isLiked,
    required this.watchedAt,
  });

  final int id;
  final String caption;
  final String thumbnailUrl;
  final String videoUrl;
  final DateTime watchedAt;
  final int viewsCount;
  final int userId;
  final String videoPath;
  final String thumbnailPath;

  final int likesCount;
  final int commentsCount;
  final int isActive;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  final User user;
  final bool isLiked;
  ReelHistoryModel copyWith({
    int? id,
    String? caption,
    String? thumbnailUrl,
    String? videoUrl,
    DateTime? watchedAt,
    int? viewsCount,
    int? userId,
    String? videoPath,
    String? thumbnailPath,
    int? likesCount,
    int? commentsCount,
    int? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
    User? user,
    bool? isLiked,
  }) {
    return ReelHistoryModel(
      id: id ?? this.id,
      caption: caption ?? this.caption,
      thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
      videoUrl: videoUrl ?? this.videoUrl,
      watchedAt: watchedAt ?? this.watchedAt,
      viewsCount: viewsCount ?? this.viewsCount,
      userId: userId ?? this.userId,
      videoPath: videoPath ?? this.videoPath,
      thumbnailPath: thumbnailPath ?? this.thumbnailPath,
      likesCount: likesCount ?? this.likesCount,
      commentsCount: commentsCount ?? this.commentsCount,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      user: user ?? this.user,
      isLiked: isLiked ?? this.isLiked,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'caption': caption,
      'watchedAt': watchedAt.toIso8601String(),
      'views_count': viewsCount,
      'likes_count': likesCount,
      'comments_count': commentsCount,
      'is_active': isActive,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
      'video_url': videoUrl,
      'thumbnail_url': thumbnailUrl,
      'user': user.toJson(),
      'is_liked': isLiked ? 1 : 0,
      'user_id': userId,
      'video_path': videoPath,
      'thumbnail_path': thumbnailPath,
    };
  }
}

// Add toJson method to User class
extension on User {
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'image_url': imageUrl,
    };
  }
}
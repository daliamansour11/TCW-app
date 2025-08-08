
import 'package:tcw/features/reels/data/models/reel_history_model.dart';

class ReelModel {

  factory ReelModel.fromJson(Map<String, dynamic> json){
    return ReelModel(
      currentPage: json['current_page'],
      data: json['data'] == null
          ? []
          : List<Datum>.from(
          (json['data'] as List).map((x) =>
              Datum.fromJson(x as Map<String, dynamic>))
      ),
      firstPageUrl: json['first_page_url'],
      from: json['from'],
      lastPage: json['last_page'],
      lastPageUrl: json['last_page_url'],
      links: json['links'] == null ? [] : List<Link>.from(
          json['links']!.map((x) => Link.fromJson(x))),
      nextPageUrl: json['next_page_url'],
      path: json['path'],
      perPage: json['per_page'],
      prevPageUrl: json['prev_page_url'],
      to: json['to'],
      total: json['total'],
    );
  }

  ReelModel({
    required this.currentPage,
    required this.data,
    required this.firstPageUrl,
    required this.from,
    required this.lastPage,
    required this.lastPageUrl,
    required this.links,
    required this.nextPageUrl,
    required this.path,
    required this.perPage,
    required this.prevPageUrl,
    required this.to,
    required this.total,
  });

  final int? currentPage;
  final List<Datum> data;
  final String? firstPageUrl;
  final int? from;
  final int? lastPage;
  final String? lastPageUrl;
  final List<Link> links;
  final dynamic nextPageUrl;
  final String? path;
  final int? perPage;
  final dynamic prevPageUrl;
  final int? to;
  final int? total;

  ReelModel copyWith({
    int? currentPage,
    List<Datum>?data,
  }) {
    ata:    return ReelModel(
      currentPage: currentPage,
      data: data !, firstPageUrl: firstPageUrl,from:from, lastPage: lastPage, lastPageUrl: lastPageUrl, links: links, nextPageUrl: nextPageUrl, path: path, perPage: perPage, prevPageUrl: prevPageUrl, to: to, total: total,
    );
  }

}
class Datum {
  factory Datum.fromJson(Map<String, dynamic> json) {
    try {
      print('📦 Parsing Datum: ${json['id']}');
      return Datum(
        id: json['id'],
        userId: json['user_id'],
        videoPath: json['video_path'],
        thumbnailPath: json['thumbnail_path'],
        caption: json['caption'],
        viewsCount: json['views_count'] is int
            ? json['views_count']
            : int.tryParse(json['views_count']?.toString() ?? '0') ?? 0,
        likesCount: json['likes_count'] is int
            ? json['likes_count']
            : int.tryParse(json['likes_count']?.toString() ?? '0') ?? 0,
        commentsCount: json['comments_count'] is int
            ? json['comments_count']
            : int.tryParse(json['comments_count']?.toString() ?? '0') ?? 0,
        isActive: json['is_active'] is int
            ? json['is_active']
            : int.tryParse(json['is_active']?.toString() ?? '0') ?? 0,
        createdAt: DateTime.tryParse(json['created_at'] ?? ''),
        updatedAt: DateTime.tryParse(json['updated_at'] ?? ''),
        videoUrl: json['video_url'],
        thumbnailUrl: json['thumbnail_url']?.toString(),
        user: json['user'] == null ? null : User.fromJson(json['user']),
        isLiked: json['is_liked'] == 1 || json['is_liked'] == true,
      );
    } catch (e, stack) {
      print(' Error parsing Datum: $e');
      print(stack);
      rethrow;
    }

  }
  factory Datum.fromHistory(ReelHistoryModel history) {
    return Datum(
      id: history.id,
      userId: history.userId,
      videoPath: history.videoPath,
      thumbnailPath: history.thumbnailPath,
      caption: history.caption,
      viewsCount: history.viewsCount,
      likesCount: history.likesCount,
      commentsCount: history.commentsCount,
      isActive: history.isActive,
      createdAt: history.createdAt,
      updatedAt: history.updatedAt,
      videoUrl: history.videoUrl,
      thumbnailUrl: history.thumbnailUrl,
      user:history.user,
      isLiked: history.isLiked,
    );
  }

  Datum({
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
  });

  final int? id;
  final int? userId;
  final String? videoPath;
  final String? thumbnailPath;
  final String? caption;
  final int? viewsCount;
  final int? likesCount;
  final int? commentsCount;
  final int? isActive;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? videoUrl;
  final String? thumbnailUrl;
  final User? user;
  final bool? isLiked;

  Datum copyWith({
    bool? isLiked,
    int? likesCount,
    int? commentsCount,
    String? caption,
    int? viewsCount,
    int? id,
    String? thumbnailUrl,
    String? videoUrl,
    DateTime? watchedAt,
    int? userId,
    String? videoPath,
    String? thumbnailPath,
    int? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
    User? user,
  }) {
    return Datum(
      id: id,
      userId: userId,
      videoPath: videoPath,
      thumbnailPath: thumbnailPath,
      caption: caption ?? this.caption,
      viewsCount: viewsCount,
      likesCount: likesCount ?? this.likesCount,
      commentsCount: commentsCount ?? this.commentsCount,
      isActive: isActive,
      createdAt: createdAt,
      updatedAt: updatedAt,
      videoUrl: videoUrl,
      thumbnailUrl: thumbnailUrl,
      user: user,
      isLiked: isLiked ?? this.isLiked,
    );
  }
}


class User {

  factory User.fromJson(Map<String, dynamic> json){
    return User(
      id: json['id'] is int ? json['id'] : int.tryParse(json['id']?.toString() ?? '0'),
      name: json['name']??'',
      image: json['image'],
      imageUrl: json['image_url']?.toString(),
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

class Link {

  factory Link.fromJson(Map<String, dynamic> json){
    return Link(
      url: json['url'],
      label: json['label'],
      active: json['active'],
    );
  }
  Link({
    required this.url,
    required this.label,
    required this.active,
  });

  final String? url;
  final String? label;
  final bool? active;

}

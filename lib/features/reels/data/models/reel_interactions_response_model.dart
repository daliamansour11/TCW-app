class ReelsInteractionsResonseModel {
  final int id;
  final int likesCount;
  final int commentsCount;
  final bool isLiked;

  ReelsInteractionsResonseModel({
    required this.id,
    required this.likesCount,
    required this.commentsCount,
    required this.isLiked,
  });

  factory ReelsInteractionsResonseModel.fromJson(Map<String, dynamic> json) {
    return ReelsInteractionsResonseModel(
      id: json['id'] as int,
      likesCount: json['likes_count'] as int,
      commentsCount: json['comments_count'] as int,
      isLiked: json['is_liked'] as bool,
    );
  }

  ReelsInteractionsResonseModel copyWith({
    int? likesCount,
    int? commentsCount,
    bool? isLiked,
  }) {
    return ReelsInteractionsResonseModel(
      id: this.id,
      likesCount: likesCount ?? this.likesCount,
      commentsCount: commentsCount ?? this.commentsCount,
      isLiked: isLiked ?? this.isLiked,
    );
  }
}

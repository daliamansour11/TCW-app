class WishlistModel {
  final String message;
  final bool isWishlisted;

  WishlistModel({
    required this.message,
    required this.isWishlisted,
  });

  factory WishlistModel.fromJson(Map<String, dynamic> json) {
    return WishlistModel(
      message: json['message'] as String,
      isWishlisted: json['is_wishlisted'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'is_wishlisted': isWishlisted,
    };
  }
}

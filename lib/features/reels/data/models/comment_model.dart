class CommentModel {

  factory CommentModel.fromJson(Map<String, dynamic> json){
    return CommentModel(
      currentPage: json['current_page'],
      data: json['data'] == null ? [] : List<Datum>.from(json['data']!.map((x) => Datum.fromJson(x))),
      firstPageUrl: json['first_page_url'],
      from: json['from'],
      lastPage: json['last_page'],
      lastPageUrl: json['last_page_url'],
      links: json['links'] == null ? [] : List<Link>.from(json['links']!.map((x) => Link.fromJson(x))),
      nextPageUrl: json['next_page_url'],
      path: json['path'],
      perPage: json['per_page'],
      prevPageUrl: json['prev_page_url'],
      to: json['to'],
      total: json['total'],
    );
  }
  CommentModel({
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

}

class Datum {

  factory Datum.fromJson(Map<String, dynamic> json){
    return Datum(
      id: json['id'],
      userId: json['user_id'],
      reelId: json['reel_id'],
      content: json['content'],
      createdAt: DateTime.tryParse(json['created_at'] ?? ''),
      updatedAt: DateTime.tryParse(json['updated_at'] ?? ''),
      user: json['user'] == null ? null : User.fromJson(json['user']),
    );
  }
  Datum({
    required this.id,
    required this.userId,
    required this.reelId,
    required this.content,
    required this.createdAt,
    required this.updatedAt,
    required this.user,
  });

  final int? id;
  final int? userId;
  final int? reelId;
  final String? content;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final User? user;

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


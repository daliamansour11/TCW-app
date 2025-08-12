class InboxResponse {
  final String? status;
  final PaginatedInboxData data;

  InboxResponse({
    required this.status,
    required this.data,
  });

        factory InboxResponse.fromJson(Map<String, dynamic> json) {
      return InboxResponse(
        status: json['status']?.toString() ?? '',
        data: json['data'] != null
            ? PaginatedInboxData.fromJson(json['data'])
            : PaginatedInboxData(limit: 0, offset: 0, total: 0, lastPage: 0, data: []),
      );
    }


    Map<String, dynamic> toJson() => {
    'status': status,
    'data': data.toJson(),
  };
}

class PaginatedInboxData {
  final int limit;
  final int offset;
  final int total;
  final int lastPage;
  final List<InboxMessage> data;

  PaginatedInboxData({
    required this.limit,
    required this.offset,
    required this.total,
    required this.lastPage,
    required this.data,
  });

  factory PaginatedInboxData.fromJson(Map<String, dynamic> json) {
    return PaginatedInboxData(
      limit: json['limit'] as int,
      offset: json['offset'] as int,
      total: json['total'] as int,
      lastPage: json['last_page'] as int,
      data: (json['data'] as List)
          .map((item) => InboxMessage.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
    'limit': limit,
    'offset': offset,
    'total': total,
    'last_page': lastPage,
    'data': data.map((e) => e.toJson()).toList(),
  };
}

class InboxMessage {
  final int id;
  final int userId;
  final String? userName;
  final String? userImage;
  final String ?lastMessagedAt;
  final String? lastMessage;

  InboxMessage({
    required this.id,
    required this.userId,
    required this.userName,
    required this.userImage,
    required this.lastMessagedAt,
    this.lastMessage,
  });

  factory InboxMessage.fromJson(Map<String, dynamic> json) {
    return InboxMessage(
      id: json['id'] as int,
      userId: json['user_id'] as int,
      userName: json['user_name'] as String?,
      userImage: json['user_image'] as String?,
      lastMessagedAt: json['last_messaged_at'] as String?,
      lastMessage: json['last_message'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'user_id': userId,
    'user_name': userName,
    'user_image': userImage,
    'last_messaged_at': lastMessagedAt,
    'last_message': lastMessage, // NEW
  };
}



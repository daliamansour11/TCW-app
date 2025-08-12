
class InboxResponse {
  final String status;
  final PaginatedInboxData data;

  InboxResponse({
    required this.status,
    required this.data,
  });

  factory InboxResponse.fromJson(Map<String, dynamic> json) {
    return InboxResponse(
      status: json['status'] as String,
      data: PaginatedInboxData.fromJson(json['data'] as Map<String, dynamic>),
    );
  }
}

class PaginatedInboxData {
  final int limit;
  final int offset;
  final int total;
  final int lastPage;
  final List<InboxMessage> messages;

  PaginatedInboxData({
    required this.limit,
    required this.offset,
    required this.total,
    required this.lastPage,
    required this.messages,
  });

  factory PaginatedInboxData.fromJson(Map<String, dynamic> json) {
    return PaginatedInboxData(
      limit: json['limit'] as int,
      offset: json['offset'] as int,
      total: json['total'] as int,
      lastPage: json['last_page'] as int,
      messages: (json['data'] as List)
          .map((msg) => InboxMessage.fromJson(msg))
          .toList(),
    );
  }
}

class InboxMessage {
  final String id;
  final String name;
  final String email;
  final String timeAgo;
  final String preview;
  final bool isRead;
  final DateTime sentAt;

  final String message;
  final String imageUrl;
  final bool isMe;

  InboxMessage( {
    required this.id,
    required this.name,
    required this.email,
    required this.timeAgo,
    required this.preview,
    required this.isRead,
    required this.sentAt,
    required this.isMe,
    required this.message,
    required this.imageUrl,
  });

  factory InboxMessage.fromJson(Map<String, dynamic> json) {
    return InboxMessage(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      timeAgo: json['time_ago'] as String,
      preview: json['preview'] as String,
      isRead: json['is_read'] as bool,
      sentAt: DateTime.parse(json['sent_at'] as String), message: json['message'], imageUrl: '', isMe: false,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'email': email,
    'time_ago': timeAgo,
    'preview': preview,
    'is_read': isRead,
    'sent_at': sentAt.toIso8601String(),
  };
}
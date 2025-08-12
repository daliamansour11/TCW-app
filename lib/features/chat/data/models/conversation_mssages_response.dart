class ConversationMessagesResponse {
  final String status;
  final PaginatedConversationData data;

  ConversationMessagesResponse({
    required this.status,
    required this.data,
  });

  factory ConversationMessagesResponse.fromJson(Map<String, dynamic> json) {
    return ConversationMessagesResponse(
      status: json['status'] ?? '',
      data: PaginatedConversationData.fromJson(json['data'] ?? {}),
    );
  }
}

class PaginatedConversationData {
  final int limit;
  final int offset;
  final int total;
  final List<ChatMessage> messages;

  PaginatedConversationData({
    required this.limit,
    required this.offset,
    required this.total,
    required this.messages,
  });

  factory PaginatedConversationData.fromJson(Map<String, dynamic> json) {
    return PaginatedConversationData(
      limit: json['limit'] ?? 0,
      offset: json['offset'] ?? 0,
      total: json['total'] ?? 0,
      messages: (json['data'] as List<dynamic>? ?? [])
          .map((e) => ChatMessage.fromJson(e))
          .toList(),
    );
  }
}

class ChatMessage {
  final String content;
  final int senderId;
  final int receiverId;
  final int conversationId;
  final DateTime createdAt;
  final bool isReceived;

  ChatMessage({
    required this.content,
    required this.senderId,
    required this.receiverId,
    required this.conversationId,
    required this.createdAt,
    required this.isReceived,
  });

  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    return ChatMessage(
      content: json['content'] ?? '',
      senderId: json['sender_id'] ?? 0,
      receiverId: json['receiver_id'] ?? 0,
      conversationId: json['conversation_id'] ?? 0,
      createdAt: DateTime.tryParse(json['created_at'] ?? '') ?? DateTime.now(),
      isReceived: json['is_received'] ?? false,
    );
  }
}

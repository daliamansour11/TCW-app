class Message {
  final String text;
  final String time;
  final bool isMe;
  final String? avatarUrl;

  Message({
    required this.text,
    required this.time,
    required this.isMe,
  this.avatarUrl,
  });
}

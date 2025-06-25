class Message {

  Message({
    required this.text,
    required this.time,
    required this.isMe,
  this.avatarUrl,
  });
  final String text;
  final String time;
  final bool isMe;
  final String? avatarUrl;
}

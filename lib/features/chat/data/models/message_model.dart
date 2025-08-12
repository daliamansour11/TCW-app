class Message {

  Message({
    required this.time,
    required this.isMe,
    required this.name, required this.email, required this.message,
    this.avatarUrl,

  });
  final String time;
  final bool isMe;
  final String? avatarUrl;
  final String name;
  final String email;
  final String message;

}


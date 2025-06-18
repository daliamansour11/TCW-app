
import 'package:flutter/material.dart';
import 'package:tcw/features/chat/data/models/message_model.dart';

class MessageBubble extends StatelessWidget {
  final Message message;

  const MessageBubble({required this.message});

  @override
  Widget build(BuildContext context) {
    final bgColor = message.isMe ? const Color(0xFFF2E5CF) : const Color(0xFFF3F3F3);
    final align = message.isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start;
    final radius = message.isMe
        ? const BorderRadius.only(
            topLeft: Radius.circular(12),
            topRight: Radius.circular(12),
            bottomLeft: Radius.circular(12),
          )
        : const BorderRadius.only(
            topLeft: Radius.circular(12),
            topRight: Radius.circular(12),
            bottomRight: Radius.circular(12),
          );

    return Column(
      crossAxisAlignment: align,
      children: [
        if (!message.isMe)
          Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: CircleAvatar(
              radius: 12,
              backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=2'),
            ),
          ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 4),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: radius,
          ),
          child: Text(message.text),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Text(
            message.time,
            style: const TextStyle(fontSize: 12, color: Colors.grey),
          ),
        )
      ],
    );
  }
}

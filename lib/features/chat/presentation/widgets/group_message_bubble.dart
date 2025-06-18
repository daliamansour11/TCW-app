

import 'package:flutter/material.dart';
import 'package:tcw/features/chat/data/models/message_model.dart';

class GroupMessageBubble extends StatelessWidget {
  final Message message;

  const GroupMessageBubble({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!message.isMe) ...[
            CircleAvatar(
              radius: 16,
              backgroundImage: NetworkImage(message.avatarUrl ?? 'https://i.pravatar.cc/150'),
            ),
            const SizedBox(width: 8),
          ],
          Expanded(
            child: Column(
              crossAxisAlignment:
                  message.isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  margin: const EdgeInsets.only(right: 40),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    message.text,
                    style: const TextStyle(color: Colors.black87),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  message.time,
                  style: const TextStyle(fontSize: 12, color: Colors.black45),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

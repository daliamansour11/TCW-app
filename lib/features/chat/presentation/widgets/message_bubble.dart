
import 'package:flutter/material.dart';
import 'package:tcw/core/shared/shared_widget/custom_text.dart';
import 'package:tcw/features/chat/data/models/message_model.dart';

class MessageBubble extends StatelessWidget {
  const MessageBubble({
    super.key,
    required this.message,
    required this.showAvatar,
    required this.showTime,
  });

  final Message message;
  final bool showAvatar;
  final bool showTime;

  @override
  Widget build(BuildContext context) {
    final bgColor = message.isMe
        ? const Color(0xFFF2E5CF)
        : const Color(0xFFF3F3F3);
    final align =
        message.isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start;
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
        if (!message.isMe && showAvatar)
          const Padding(
            padding: EdgeInsets.only(bottom: 4),
            child: CircleAvatar(
              radius: 12,
            ),
          ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 2),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: radius,
          ),
          child: CustomText(
            message.text,
            fontWeight: FontWeight.w400,
          ),
        ),
        if (showTime)
          Padding(
            padding: const EdgeInsets.only(bottom: 8, top: 4),
            child: CustomText(
              message.time,
              fontSize: 12,
              color: Colors.grey,
            ),
          ),
      ],
    );
  }
}

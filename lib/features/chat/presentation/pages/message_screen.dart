import 'package:flutter/material.dart';
import 'package:tcw/core/shared/shared_widget/custom_text.dart';
import 'package:tcw/core/theme/app_colors.dart';
import 'package:tcw/features/chat/data/models/message_model.dart';
import 'package:tcw/features/chat/presentation/widgets/chat_input_widget.dart';
import 'package:tcw/features/chat/presentation/widgets/message_bubble.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  static final List<Message> messages = [
    Message(
      text:
          'Lorem ipsum dolor sit amet consectetur non arcu non mauris quis diam lectus commodo.',
      time: '10:40 AM',
      isMe: false,
    ),
    Message(text: 'Thank you', time: '10:40 AM', isMe: false),
    Message(text: 'Hey Sophie! How are you?', time: '11:41 AM', isMe: true),
    Message(
      text:
          'Lorem ipsum dolor sit amet consectetur non arcu non mauris quis diam lectus commodo.',
      time: '11:41 AM',
      isMe: true,
    ),
    Message(
        text: 'Lorem ipsum dolor sit amet consectetur',
        time: '11:45 AM',
        isMe: false),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisSize: MainAxisSize.min,
          spacing: 10,
          children: [
            CircleAvatar(
              radius: 18,
            ),
            CustomText(
              'Ramy Ahmed',
              fontWeight: FontWeight.bold,
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.call, color: AppColors.primaryColor),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final current = messages[index];
                final previous = index > 0 ? messages[index - 1] : null;
                final next =
                    index < messages.length - 1 ? messages[index + 1] : null;

                return MessageBubble(
                  message: current,
                  showAvatar: previous == null || previous.isMe != current.isMe,
                  showTime: next == null || next.isMe != current.isMe,
                );
              },
            ),
          ),
          const ChatInputWidget(),
        ],
      ),
    );
  }
}

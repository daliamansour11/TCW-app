import 'package:flutter/material.dart';
import 'package:tcw/core/shared/shared_widget/custom_text.dart';
import 'package:tcw/core/theme/app_colors.dart';
import 'package:tcw/features/chat/data/models/message_model.dart';
import 'package:tcw/features/chat/presentation/widgets/chat_input_widget.dart';
import 'package:tcw/features/chat/presentation/widgets/group_message_bubble.dart';

class GroupChatScreen extends StatelessWidget {
  const GroupChatScreen({super.key, this.isWidgetOnly = false});
  final bool isWidgetOnly;
  static final List<Message> messages = [
    Message(
      text:
          'Lorem ipsum dolor sit amet consectetur non arcu non mauris quis diam lectus commodo.',
      time: '10:40 AM',
      isMe: false,
      avatarUrl: 'https://i.pravatar.cc/150?img=1',
    ),
    Message(
      text: 'Thank you',
      time: '10:40 AM',
      isMe: false,
      avatarUrl: 'https://i.pravatar.cc/150?img=1',
    ),
    Message(
      text: 'Lorem ipsum dolor sit amet consectetur',
      time: '11:45 AM',
      isMe: false,
      avatarUrl: 'https://i.pravatar.cc/150?img=1',
    ),
    Message(
      text:
          'Lorem ipsum dolor sit amet consectetur non arcu non mauris quis diam lectus commodo.',
      time: '10:40 AM',
      isMe: false,
      avatarUrl: 'https://i.pravatar.cc/150?img=1',
    ),
    Message(
      text: 'Thank you',
      time: '10:40 AM',
      isMe: true,
      avatarUrl: 'https://i.pravatar.cc/150?img=1',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    if (isWidgetOnly) {
      return Column(
        children: [
          ...messages.map((e) => GroupMessageBubble(message: e)),
          const ChatInputWidget(),
        ],
      );
    }
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            //back to the previous screen
            Navigator.pop(context);
          },
        ),
        title: const Column(
          children: [
            CustomText('UI Group',
                fontSize: 16, fontWeight: FontWeight.bold),
            CustomText('Ahmed Mohamed  •  Coach',
                fontSize: 12, color: Colors.grey),
          ],
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: CircleAvatar(
              backgroundColor: AppColors.primaryColor.withValues(alpha: 0.1),
              child: const Icon(
                Icons.search,
                color: AppColors.primaryColor,
              ),
            ),
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
                return GroupMessageBubble(message: messages[index]);
              },
            ),
          ),
          const ChatInputWidget(),
        ],
      ),
    );
  }
}

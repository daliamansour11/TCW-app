import 'package:flutter/material.dart';
import 'package:tcw/core/constansts/context_extensions.dart';
import 'package:tcw/core/theme/app_colors.dart';
import 'package:tcw/features/chat/data/models/message_model.dart';
import 'package:tcw/features/chat/presentation/widgets/message_bubble.dart';

class ChatScreen extends StatelessWidget {
  final List<Message> messages = [
    Message(
      text: "Lorem ipsum dolor sit amet consectetur non arcu non mauris quis diam lectus commodo.",
      time: "10:40 AM",
      isMe: false,
    ),
    Message(text: "Thank you", time: "10:40 AM", isMe: false),
    Message(text: "Hey Sophie! How are you?", time: "11:41 AM", isMe: true),
    Message(
      text: "Lorem ipsum dolor sit amet consectetur non arcu non mauris quis diam lectus commodo.",
      time: "11:41 AM",
      isMe: true,
    ),
    Message(text: "Lorem ipsum dolor sit amet consectetur", time: "11:45 AM", isMe: false),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(context),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                return MessageBubble(message: messages[index]);
              },
            ),
          ),
          ChatInputBar(),
        ],
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: BackButton(color: Colors.black),
      title: Row(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(
                'https://i.pravatar.cc/300?img=2'), // Replace with user's profile image
            radius: 18,
          ),
           SizedBox(width: context.propWidth(8)),
           Text(
            'Ramy Ahmed',
            style: context.textTheme.headlineMedium
          ),
        ],
      ),
      actions: [
        IconButton(
          icon:  Icon(Icons.call, color: AppColors.primaryColor),
          onPressed: () {},
        ),
      ],
    );
  }
}



class ChatInputBar extends StatelessWidget {
  const ChatInputBar();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: const BoxDecoration(
        color: Color(0xFFF3F3F3),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: Row(
        children: [
          const Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Type a message',
                border: InputBorder.none,
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.camera_alt_outlined),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.attach_file),
            onPressed: () {},
          ),
          Container(
            decoration: BoxDecoration(
              color: const Color(0xFFD3A85D),
              borderRadius: BorderRadius.circular(24),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: const Text(
              'Send now',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:tcw/features/chat/data/models/message_model.dart';
import 'package:tcw/features/chat/presentation/widgets/group_message_bubble.dart';

class GroupChatScreen extends StatelessWidget {
  final List<Message> messages = [
    Message(
      text: 'Lorem ipsum dolor sit amet consectetur non arcu non mauris quis diam lectus commodo.',
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
      text: 'Lorem ipsum dolor sit amet consectetur non arcu non mauris quis diam lectus commodo.',
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
    return Scaffold(
      backgroundColor: Colors.white,
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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("UI Group", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
            SizedBox(height: 2),
            Text("Ahmed Mohamed  •  Coach", style: TextStyle(fontSize: 12, color: Colors.grey)),
          ],
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.black),
            onPressed: () {
             
            },
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: messages.length,
        itemBuilder: (context, index) {
          return GroupMessageBubble(message: messages[index]);
        },
      ),
    );
  }
}
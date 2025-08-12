import 'package:flutter/material.dart';
import 'package:tcw/features/chat/data/models/message_model.dart';
import 'package:tcw/features/chat/presentation/widgets/chat_input_widget.dart';
import 'package:tcw/features/chat/presentation/widgets/message_bubble.dart';

class ChatScreen extends StatefulWidget {
  final int liveId;
  const ChatScreen({super.key, required this.liveId});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final List<Message> messages = [];

  void addMessage(String text, {required bool isMe}) {
    setState(() {
      messages.add(
        Message(message: text, time: _getCurrentTime(), isMe: isMe, name: '', email: ''),
      );
    });
  }
  String _getCurrentTime() {
    final now = TimeOfDay.now();
    final hour = now.hourOfPeriod == 0 ? 12 : now.hourOfPeriod;
    final minute = now.minute.toString().padLeft(2, '0');
    final period = now.period == DayPeriod.am ? 'AM' : 'PM';
    return "$hour:$minute $period";
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Chat')),
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
          ChatInputWidget(
            liveId: widget.liveId,
            onLocalSend: (text) => addMessage(text, isMe: true),
          ),
        ],
      ),
    );
  }
}
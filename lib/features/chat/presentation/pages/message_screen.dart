import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../auth/data/datasources/auth_local_datasource_impl.dart';
import '../../../auth/data/models/user_model.dart';
import '../../data/models/message_model.dart';
import '../widgets/chat_input_widget.dart';
import '../widgets/message_bubble.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/_chat_cubit.dart'; // adjust path

class ChatScreen extends StatefulWidget {
  final int chatId;
  const ChatScreen({super.key, required this.chatId});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  UserModel? currentUser;
  Future<void> _loadCurrentUser() async {
    final authLocal = AuthLocalDatasourceImpl();
    final user = await authLocal.getLoggedUser();
    setState(() {
      currentUser = user;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Chat')),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<ChatCubit, ChatState>(
              builder: (context, state) {
                if (state is ConversationLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is ConversationMessagesLoaded) {
                  final messageList =
                      state.messages;
                  if (messageList.isEmpty) {
                    return const Center(child: Text('No messages'));
                  }
                  return ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: messageList.length,
                    itemBuilder: (context, index) {
                      final current = messageList[index];
                      final previous =
                          index > 0 ? messageList[index - 1] : null;
                      final next = index < messageList.length - 1
                          ? messageList[index + 1]
                          : null;

                      return MessageBubble(
                        message: Message(
                          message: current.content,
                          time: DateFormat('hh:mm a').format(current.createdAt),
                          isMe: !current.isReceived,
                          name: '',
                          email: '',
                        ),
                        showAvatar: previous == null ||
                            previous.senderId != current.senderId,
                        showTime:
                            next == null || next.senderId != current.senderId,
                      );
                    },
                  );
                } else if (state is ConversationError) {
                  return Center(child: Text('Error: ${state.error}'));
                }
                return const SizedBox.shrink();
              },
            ),
          ),

          // Send Message
          ChatInputWidget(
            chatId: widget.chatId,
            onLocalSend: (text) {
              context.read<ChatCubit>().sendMessage(widget.chatId, text);
            },
          ),
        ],
      ),
    );
  }
}

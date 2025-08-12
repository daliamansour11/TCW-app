import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tcw/core/shared/shared_widget/custom_text.dart';
import 'package:tcw/core/theme/app_colors.dart';
import 'package:tcw/features/chat/presentation/widgets/chat_input_widget.dart';
import 'package:tcw/features/chat/presentation/widgets/group_message_bubble.dart';
import 'package:tcw/features/event/presentation/cubit/event_cubit.dart';

class GroupChatScreen extends StatelessWidget {
  final bool isWidgetOnly;
  final int liveId;

  const GroupChatScreen({
    super.key,
    this.isWidgetOnly = false,
    required this.liveId,
  });

  @override
  Widget build(BuildContext context) {
    if (isWidgetOnly) {
      return Column(
        children: [
          Expanded(
            child: BlocBuilder<EventCubit, EventState>(
              builder: (context, state) {
                final messages = state is EventCommentLoaded ? state.liveComments : [];

                return ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    return GroupMessageBubble(message: messages[index]);
                  },
                );
              },
            )

          ),
          ChatInputWidget(chatId: liveId, onLocalSend: (String ) {  },),
        ],
      );
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
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
            child: BlocBuilder<EventCubit, EventState>(
              builder: (context, state) {
                final messages = state is EventCommentLoaded ? state.liveComments : [];

                if (messages.isEmpty) {
                  return const Center(
                    child: Text('No messages yet'),
                  );
                }
                return ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    return GroupMessageBubble(message: messages[index]);
                  },
                );
              },
            )

          ),
          ChatInputWidget(chatId: liveId, onLocalSend: (String ) {  },),
        ],
      ),
    );
  }
}

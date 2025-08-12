import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tcw/core/shared/shared_widget/custom_button.dart';
import 'package:tcw/core/theme/app_colors.dart';
import 'package:tcw/features/event/presentation/cubit/event_cubit.dart';
import 'package:zap_sizer/zap_sizer.dart';
class ChatInputWidget extends StatefulWidget {
  final int liveId;
  final Function(String) onLocalSend;

  const ChatInputWidget({
    super.key,
    required this.liveId,
    required this.onLocalSend,
  });

  @override
  State<ChatInputWidget> createState() => _ChatInputWidgetState();
}

class _ChatInputWidgetState extends State<ChatInputWidget> {
  final TextEditingController _controller = TextEditingController();

  void _sendMessage() {
    final text = _controller.text.trim();
    if (text.isNotEmpty) {
      widget.onLocalSend(text);

      context.read<EventCubit>().addCommentInLive(
        liveId: widget.liveId,
        body: text,
      );

      _controller.clear();
    }
  }

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
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: const InputDecoration(
                hintText: 'Type a message',
                border: InputBorder.none,
              ),
              onSubmitted: (_) => _sendMessage(),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.emoji_emotions_outlined, color: AppColors.primaryColor),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.attach_file, color: AppColors.primaryColor),
            onPressed: () {},
          ),
          CustomButton(
            title: 'Send',
            onPressed: _sendMessage,
            width: 15.w,
          ),
        ],
      ),
    );
  }
}

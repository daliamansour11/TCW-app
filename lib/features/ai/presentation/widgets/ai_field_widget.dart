import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tcw/core/shared/shared_widget/custom_button.dart';
import 'package:tcw/core/shared/shared_widget/custom_container.dart';
import 'package:tcw/core/shared/shared_widget/custom_text.dart';
import 'package:tcw/core/shared/shared_widget/custom_text_form_field.dart';
import 'package:tcw/core/theme/app_colors.dart';
import 'package:tcw/features/ai/presentation/cubit/ai_cubit.dart';
class AiFieldWidget extends StatefulWidget {
  const AiFieldWidget({super.key});

  @override
  State<AiFieldWidget> createState() => _AiFieldWidgetState();
}

class _AiFieldWidgetState extends State<AiFieldWidget> {
  final TextEditingController _controller = TextEditingController();
  final List<_AiMessage> _messages = [];
  bool _isLoading = false;
  void _sendMessage() {
    final userInput = _controller.text.trim();
    if (userInput.isEmpty) return;

    setState(() {
      _messages.add(_AiMessage(role: 'user', content: userInput));
      _controller.clear();
    });

    context.read<AiCubit>().askChatGpt(userInput);
  }

  @override
  Widget build(BuildContext context) {
    final color = const Color(0xffffffff).withOpacity(0.2);

    return Column(
      children: [
        ..._messages.map(
              (msg) => Align(
            alignment: msg.role == 'user' ? Alignment.centerRight : Alignment.centerLeft,
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 4),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: msg.role == 'user' ? AppColors.darkGreen : Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(16),
              ),
              child: CustomText(
                msg.content,
                color: Colors.white,
              ),
            ),
          ),
        ),
        BlocListener<AiCubit, AiState>(
          listener: (context, state) {
            if (state is ChatGptLoading) {
              setState(() => _isLoading = true);
            } else if (state is ChatGptSuccess) {
              setState(() {
                _isLoading = false;
                _messages.add(_AiMessage(role: 'ai', content: state.response));
              });
            } else if (state is ChatGptError) {
              setState(() {
                _isLoading = false;
                _messages.add(_AiMessage(role: 'ai', content: state.message));
              });
            }
          },
          child: const SizedBox.shrink(),
        ),


        CustomContainer(
          color: color,
          padding: 8,
          borderRadius: 24,
          child: Column(
            children: [
              CustomTextField(
                controller: _controller,
                minLines: 3,
                maxLines: 5,
                hintText: 'What do you want to ask?',
                backgroundColor: Colors.transparent,
                borderRadius: 24,
                borderColor: Colors.transparent,
                textColor: Colors.white,
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: CustomContainer(
                      padding: 5,
                      isCircle: true,
                      border: Border.all(color: Colors.white),
                      child: const Icon(
                        Icons.add,
                        size: 17,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  CustomButton.icon(
                    title: 'Search',
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    icon: const Icon(Icons.language, size: 17, color: Colors.white),
                    iconAlignment: IconAlignment.start,
                    backgroundColor: Colors.transparent,
                    borderColor: Colors.white,
                    onPressed: () {},
                  ),
                  CustomButton.icon(
                    title: 'Think',
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    icon: const Icon(Icons.lightbulb_outline, size: 17, color: Colors.white),
                    iconAlignment: IconAlignment.start,
                    backgroundColor: Colors.transparent,
                    borderColor: Colors.white,
                    onPressed: () {},
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: _sendMessage,
                    icon: const CircleAvatar(
                      backgroundColor: AppColors.darkGreen,
                      child: Icon(Icons.send, size: 17, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _AiMessage {
  final String role;
  final String content;

  _AiMessage({required this.role, required this.content});
}

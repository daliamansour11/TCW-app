import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tcw/core/shared/shared_widget/custom_container.dart';
import 'package:tcw/core/shared/shared_widget/custom_text.dart';
import 'package:tcw/core/shared/shared_widget/custom_text_form_field.dart';
import 'package:tcw/core/theme/app_colors.dart';
import 'package:tcw/features/chat/presentation/pages/group_chat_screen.dart';
import 'package:tcw/features/event/data/models/poll_model.dart';
import 'package:tcw/features/event/data/models/question_model.dart';
import 'package:zap_sizer/zap_sizer.dart';

class LiveEventScreen extends StatefulWidget {
  const LiveEventScreen({super.key, required this.questions});
  final List<QuestionModel> questions;

  @override
  State<LiveEventScreen> createState() => _LiveEventScreenState();
}

class _LiveEventScreenState extends State<LiveEventScreen> {
  List<PollOption> pollOptions = [
    PollOption(text: 'Pomodoro Technique', votes: 1),
    PollOption(text: 'Eisenhower Matrix'),
  ];

  void selectPollOption(int index) {
    setState(() {
      for (int i = 0; i < pollOptions.length; i++) {
        pollOptions[i].isSelected = i == index;
      }
      pollOptions[index].votes += 1;
    });
  }

  int get totalVotes => pollOptions.fold(0, (sum, o) => sum + o.votes);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: ListView(padding: const EdgeInsets.all(10), children: [
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              const CustomText(
                'master time management and\nachieve peak productivity!',
                fontWeight: FontWeight.bold,
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 4,
            children: [
              IconButton(
                  onPressed: () {
                    Clipboard.setData(
                        const ClipboardData(text: 'www.tcw-event.com/live'));
                  },
                  icon: const Icon(Icons.copy,
                      color: AppColors.primaryColor, size: 12)),
              const CustomText(
                'www.tcw-event.com/live',
                color: AppColors.primaryColor,
                fontSize: 14,
                fontWeight: FontWeight.w400,
                decoration: TextDecoration.underline,
              ),
            ],
          ),
          const SizedBox(height: 12),
          // // Video area
          CustomContainer(
            height: 50.h,
            borderRadius: 16,
            color: Colors.grey.shade300,
            image: const DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(
                'https://img.freepik.com/free-photo/speaker-stage-conference-hall_23-2148918160.jpg',
              ),
            ),
            child: Stack(
              children: [
                Positioned(
                  right: 12,
                  top: 12,
                  child: Row(
                    spacing: 10,
                    children: [
                      CustomContainer(
                        color: Colors.black.withValues(alpha: 0.6),
                        padding: 5,
                        borderRadius: 12,
                        child: const Row(
                          spacing: 4,
                          children: [
                            Icon(Icons.group, color: Colors.white, size: 16),
                            CustomText('15+',
                                color: Colors.white, fontSize: 12),
                          ],
                        ),
                      ),
                      Badge.count(
                        count: 5,
                        backgroundColor: Colors.green,
                        child: const Icon(
                          CupertinoIcons.chat_bubble,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),

                // Control buttons
                Positioned(
                  bottom: 12,
                  left: 0,
                  right: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CircleAvatar(
                          backgroundColor: Colors.black.withValues(alpha: 0.6),
                          child: const Icon(Icons.present_to_all,
                              color: Colors.white)),
                      CircleAvatar(
                          backgroundColor: Colors.black.withValues(alpha: 0.6),
                          child:
                              const Icon(Icons.videocam, color: Colors.white)),
                      CustomContainer(
                        color: const Color(0xFFF7000E),
                        radius: BorderRadius.circular(12.37),
                        child: const Icon(Icons.call_end, color: Colors.white),
                      ),
                      CircleAvatar(
                          backgroundColor: Colors.black.withValues(alpha: 0.6),
                          child: const Icon(Icons.mic, color: Colors.white)),
                      CircleAvatar(
                        backgroundColor: Colors.black.withValues(alpha: 0.6),
                        child:
                            const Icon(Icons.more_horiz, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 12),
          const Row(
            spacing: 5,
            children: [
              CustomText(
                'Messages',
              ),
              CustomText(
                '(4)',
                color: AppColors.primaryColor,
              ),
            ],
          ),
          const SizedBox(height: 12),
        const  GroupChatScreen(
            isWidgetOnly: true,
          ),
          // Live Questions
          const SizedBox(height: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 12,
            children: [
              const CustomText(
                'Live Questions (Q&A)',
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
              ...widget.questions.map(
                (q) => Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 6,
                    children: [
                      CustomText(
                        '${q.id}- ${q.question}',
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                      const CustomTextField(
                        hintText: 'Type your answer...',
                        hintStyle: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ),
              buildPollSection(),
            ],
          ),
        ]));
  }

  Widget buildPollSection() {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Poll Questions',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
          const SizedBox(height: 12),
          const Text(
            'Which time management technique do you find most effective?',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 4),
          const Row(
            children: [
              Icon(Icons.group, size: 14, color: Colors.grey),
              SizedBox(width: 4),
              Text(
                'Select one or more',
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ...pollOptions.asMap().entries.map((entry) {
            final index = entry.key;
            final option = entry.value;
            final percent =
                totalVotes == 0 ? 0.0 : option.votes / totalVotes.toDouble();

            return GestureDetector(
              onTap: () => selectPollOption(index),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        option.isSelected
                            ? Icons.check_circle
                            : Icons.circle_outlined,
                        color: option.isSelected
                            ? AppColors.primaryColor
                            : Colors.grey,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          option.text,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      if (option.votes > 0)
                        const CircleAvatar(
                          radius: 10,
                          backgroundImage: NetworkImage(
                              'https://i.pravatar.cc/100'), // example avatar
                        ),
                      const SizedBox(width: 4),
                      Text(
                        '${option.votes}',
                        style: const TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Container(
                    height: 6,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    clipBehavior: Clip.hardEdge,
                    child: FractionallySizedBox(
                      alignment: Alignment.centerLeft,
                      widthFactor: percent,
                      child: Container(color: Colors.grey[300]),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';
import 'package:tcw/core/shared/shared_widget/custom_container.dart';
import 'package:tcw/core/shared/shared_widget/custom_text.dart';
import 'package:tcw/core/theme/app_colors.dart';
import 'package:tcw/core/utils/asset_utils.dart';
import 'package:tcw/features/event/data/models/event_model.dart';

class EventDetailsScreen extends StatefulWidget {
  const EventDetailsScreen({super.key, required this.eventItem});
  final EventItem eventItem;

  @override
  State<EventDetailsScreen> createState() => _EventDetailsScreenState();
}

class _EventDetailsScreenState extends State<EventDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

       body:ListView(padding: const EdgeInsets.all(10), children: [
       Row(
       children: [
       IconButton(
       icon: const Icon(Icons.arrow_back, color: Colors.black),
      onPressed: () {
        Navigator.pop(context);
      },
    ),
         const SizedBox(width: 30),

     Center(
       child: CustomText(
           widget.eventItem.title??'',
           fontWeight: FontWeight.bold,
         fontSize: 16,
           ),
     ),
    ],
    ),
    const SizedBox(height: 12),
         Padding(
           padding: const EdgeInsets.only(left: 28.0),
           child: Center(
             child: Row(
               children: [
                 const Icon(Icons.date_range,
                     size: 14, color: AppColors.primaryColor),
                 const SizedBox(width: 4),
                 const      CustomText(
                   'Monday, 4 Mar 2025',
                   fontSize: 12,
                 ),
                 const SizedBox(width: 8),
                 const Icon(Icons.person,
                     size: 14, color: AppColors.primaryColor),
                 const SizedBox(width: 4),
                 CustomText(
                   widget.eventItem.instructor?.name ?? '',
                   fontSize: 12,
                   color: Colors.grey.shade600,
                 ),
               ],
             ),
           ),
         ),


            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  const SizedBox(height: 16),
                  _buildVideoSection(),
                  const SizedBox(height: 16),
                  _buildAboutEvent(),
                  const SizedBox(height: 16),
                  _buildQandA(),
                  const SizedBox(height: 16),
                  _buildPollQuestion(),
                ],
              ),
            ),

        ],
      ),
    );
  }

  Widget _buildVideoSection() {
    return CustomContainer(
      height: 200,
      borderRadius: 16,
      color: Colors.grey.shade300,
      image: DecorationImage(
        fit: BoxFit.cover,
        image: NetworkImage(
          widget.eventItem.thumbUrl ??
              'https://img.freepik.com/free-photo/speaker-stage-conference-hall_23-2148918160.jpg',
        ),
      ),
      // child:const Stack(
      //   children: [
      //     Positioned(
      //       right: 12,
      //       top: 12,
      //       child: Icon(
      //         Icons.play_circle_fill,
      //         size: 60,
      //         color: Colors.white,
      //       ),
      //     ),
      //   ],
      // ),
    );
  }

  Widget _buildAboutEvent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'About Event',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Text(
          widget.eventItem.subTitle ?? '',
          style: const TextStyle(fontSize: 14),
        ),
      ],
    );
  }

  Widget _buildQandA() {
    final questions = [
      '1- What are the best techniques to overcome procrastination?',
      '2- How can I create a daily routine that maximizes productivity?',
      '3- What tools do you recommend for effective time management?',
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Live Questions (Q&A)',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        ...questions.map((q) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Text(q, style: const TextStyle(fontSize: 14)),
        )),
      ],
    );
  }

  Widget _buildPollQuestion() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Poll Questions',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        const Text(
          'Which time management technique do you find most effective?',
          style: TextStyle(fontSize: 14),
        ),
        const SizedBox(height: 12),
        _buildPollBar('Pomodoro Technique', 0.4),
        const SizedBox(height: 8),
        _buildPollBar('Eisenhower Matrix', 0.6),
      ],
    );
  }

  Widget _buildPollBar(String title, double value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontSize: 13)),
        const SizedBox(height: 4),
        Stack(
          children: [
            Container(
              height: 8,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            FractionallySizedBox(
              widthFactor: value,
              child: Container(
                height: 8,
                decoration: BoxDecoration(
                  color: const Color(0xffB7924F),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

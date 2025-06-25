import 'package:flutter/material.dart';
import 'package:tcw/core/shared/shared_widget/custom_container.dart';
import 'package:tcw/core/shared/shared_widget/custom_text.dart';

class DailyScheduleWidget extends StatelessWidget {
  const DailyScheduleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final tasks = [
      _Task(
        time: '1:00 PM',
        title: 'Design Review',
        color: Colors.lightBlue.shade100,
        dotColor: Colors.blue,
      ),
      _Task(
        time: '11:00 AM',
        title: 'Onboarding Presentation',
        color: Colors.amber.shade100,
        dotColor: Colors.brown,
      ),
      _Task(
        time: '4:00 PM',
        title: 'Marketing in the Digital Age',
        color: Colors.red.shade100,
        dotColor: Colors.red,
      ),
      _Task(
        time: '10:00 AM',
        title: 'Mastering Productivity',
        color: Colors.purple.shade100,
        dotColor: Colors.purple,
      ),
    ];

    final times = ['08:00 am', '09:45 am', '10:50 am', '02:40 pm'];

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      itemCount: tasks.length,
      separatorBuilder: (_, __) => const SizedBox(height: 24),
      itemBuilder: (context, index) {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 70,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                spacing: 8,
                children: [
                  CustomText(
                    times[index],
                    color: Colors.black87,
                    fontSize: 12,
                  ),
                  CustomContainer(
                    width: 2,
                    height: 60,
                    padding: 0,
                    color: tasks[index].dotColor.withValues(alpha: 0.5),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: CustomContainer(
                padding: 16,
                color: tasks[index].color,
                borderRadius: 12,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 8,
                  children: [
                    Row(
                      spacing: 8,
                      children: [
                        CustomText(
                          tasks[index].time,
                          fontWeight: FontWeight.bold,
                          color: tasks[index].dotColor,
                        ),
                        CustomContainer(
                          padding: 3,
                          color: tasks[index].dotColor,
                          child: Icon(Icons.videocam,size: 12,
                          color: tasks[index].dotColor.shade200,
                          ),
                        )
                      ],
                    ),
                    CustomText(
                      tasks[index].title,
                      fontSize: 16,
                      color: tasks[index].dotColor.shade900,
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _Task {
  _Task({
    required this.time,
    required this.title,
    required this.color,
    required this.dotColor,
  });
  final String time;
  final String title;
  final Color color;
  final MaterialColor dotColor;
}

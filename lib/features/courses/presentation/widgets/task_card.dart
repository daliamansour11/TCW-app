import 'package:flutter/material.dart';
import 'package:tcw/core/constansts/context_extensions.dart';
import 'package:tcw/features/courses/data/models/task_model.dart';
import 'package:tcw/core/routes/app_routes.dart';
import 'package:zapx/zapx.dart';

class TaskCard extends StatelessWidget {
  const TaskCard({super.key, required this.task});
  final Task task;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Zap.toNamed(
        AppRoutes.taskDetailScreen,
        arguments: task,
      ),
      child: Container(
        width: context.propHeight(300),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withValues(alpha: 0.2),
                blurRadius: 6,
                offset: const Offset(0, 3))
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Created by Ahmed Mohamed • Sun, 9 March 2025',
                style: TextStyle(fontSize: 10, color: Colors.grey)),
            const SizedBox(height: 10),
            Text(task.title,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: task.isCompleted ? Colors.green[100] : Colors.brown[100],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(task.status, style: const TextStyle(fontSize: 12)),
            ),
            const SizedBox(height: 10),
            Text(task.subtitle,
                style: TextStyle(fontSize: 12, color: Colors.grey[700])),
            const SizedBox(height: 10),
            Row(
              children: [
                const Icon(Icons.calendar_today_outlined,
                    size: 14, color: Colors.red),
                const SizedBox(width: 5),
                Text(task.date,
                    style: const TextStyle(color: Colors.red, fontSize: 12)),
              ],
            ),
            if (task.isCompleted && task.fileSize != null) ...[
              const SizedBox(height: 10),
              Row(
                children: [
                  const Icon(Icons.insert_drive_file,
                      size: 20, color: Colors.red),
                  const SizedBox(width: 5),
                  const Text('ReactJS-task 1', style: TextStyle(fontSize: 12)),
                  const Spacer(),
                  Text(task.fileSize!,
                      style: const TextStyle(fontSize: 12, color: Colors.grey)),
                ],
              )
            ]
          ],
        ),
      ),
    );
  }
}

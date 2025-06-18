
import 'package:flutter/material.dart';
import 'package:tcw/core/constansts/context_extensions.dart';
import 'package:tcw/features/courses/data/models/task_model.dart';

class TaskCard extends StatelessWidget {
  final Task task;

  TaskCard({required this.task});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.propHeight(300),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.grey.withOpacity(0.2), blurRadius: 6, offset: Offset(0, 3))
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Created by Ahmed Mohamed • Sun, 9 March 2025", style: TextStyle(fontSize: 10, color: Colors.grey)),
          SizedBox(height: 10),
          Text(task.title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
          SizedBox(height: 10),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: task.isCompleted ? Colors.green[100] : Colors.brown[100],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(task.status, style: TextStyle(fontSize: 12)),
          ),
          SizedBox(height: 10),
          Text(task.subtitle, style: TextStyle(fontSize: 12, color: Colors.grey[700])),
          SizedBox(height: 10),
          Row(
            children: [
              Icon(Icons.calendar_today_outlined, size: 14, color: Colors.red),
              SizedBox(width: 5),
              Text("${task.date}", style: TextStyle(color: Colors.red, fontSize: 12)),
            ],
          ),
          if (task.isCompleted && task.fileSize != null) ...[
            SizedBox(height: 10),
            Row(
              children: [
                Icon(Icons.insert_drive_file, size: 20, color: Colors.red),
                SizedBox(width: 5),
                Text("ReactJS-task 1", style: TextStyle(fontSize: 12)),
                Spacer(),
                Text(task.fileSize!, style: TextStyle(fontSize: 12, color: Colors.grey)),
              ],
            )
          ]
        ],
      ),
    );
  }
}

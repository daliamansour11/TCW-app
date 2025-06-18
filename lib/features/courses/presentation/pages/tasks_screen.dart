import 'package:flutter/material.dart';
import 'package:tcw/core/constansts/context_extensions.dart';
import 'package:tcw/core/shared/shared_widget/app_bar.dart';
import 'package:tcw/features/courses/data/models/task_model.dart';
import 'package:tcw/features/courses/presentation/widgets/section_header.dart';
import 'package:tcw/features/courses/presentation/widgets/task_card.dart';
import 'package:tcw/features/home/presentation/widgets/search_widget.dart';

class TasksScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: context.propHeight(32)),
                CustomAppBar(title: 'Tasks'),
                SizedBox(height: context.propHeight(24)),
                SearchWidget( context: context,),
                SizedBox(height: context.propHeight(24)),
                SectionHeader(title: "Tasks To Do", count: 4),
                SizedBox(height: context.propHeight(10)),
                TaskCardList(
                  tasks: [
                    Task(
                      title: "Understanding Concept Of React (Lesson 6)",
                      subtitle: "Build an interactive UI using React with state management and components.",
                      status: "Pending",
                      date: "Wed, 12 March 2025",
                      isCompleted: false,
                    ),
                    Task(
                      title: "Understanding Concept Of React (Lesson 7)",
                      subtitle: "Implement routing in a React application using React Router.",
                      status: "Pending",
                      date: "Thu, 13 March 2025",
                      isCompleted: false,
                    ),
                    Task(
                      title: "Understanding Concept Of React (Lesson 8)",
                      subtitle: "Create a responsive layout using CSS Flexbox and Grid.",
                      status: "Pending",
                      date: "Fri, 14 March 2025",
                      isCompleted: false,
                    ),
                  ],
                ),
                SizedBox(height: context.propHeight(24)),
                SectionHeader(title: "Completed Tasks", count: 2),
                SizedBox(height: context.propHeight(10)),
                TaskCardList(
                  tasks: [
                    Task(
                      title: "Understanding Concept Of React (Lesson 1)",
                      subtitle: "Create a simple React component that displays a dynamic welcome message.",
                      status: "Completed",
                      date: "Sun, 23 Feb 2025",
                      isCompleted: true,
                      fileSize: "4.5 MB",
                    ),
                    Task(
                      title: "Understanding Concept Of React (Lesson 2)",
                      subtitle: "Build a simple React application with props and state.",
                      status: "Completed",
                      date: "Mon, 24 Feb 2025",
                      isCompleted: true,
                      fileSize: "3.2 MB",
                    ),
                    Task(
                      title: "Understanding Concept Of React (Lesson 3)",
                      subtitle: "Implement a form in React and handle user input.",
                      status: "Completed",
                      date: "Tue, 25 Feb 2025",
                      isCompleted: true,
                      fileSize: "2.8 MB",
                    ),
              
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      
    );
  }
}

class TaskCardList extends StatelessWidget {
  final List<Task> tasks;

  TaskCardList({required this.tasks});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.propHeight(300),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: tasks.length,
        separatorBuilder: (_, __) => SizedBox(width: 10),
        itemBuilder: (context, index) => TaskCard(task: tasks[index]),
      ),
    );
  }
}

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:tcw/core/constansts/context_extensions.dart';
import 'package:tcw/core/routes/app_routes.dart';
import 'package:tcw/core/shared/shared_widget/custom_action_dropdown.dart';
import 'package:tcw/features/courses/data/models/task_model.dart';
import 'package:tcw/features/courses/presentation/widgets/task_card.dart';
import 'package:tcw/features/tasks/presentation/tasks_viewmodel.dart';
import 'package:zapx/zapx.dart';



class TaskCardList extends StatelessWidget {
  const TaskCardList({super.key, required this.tasks, required this.viewmodel});
  final List<Task> tasks;
  final TasksViewmodel viewmodel;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.propHeight(300),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: tasks.length,
        separatorBuilder: (_, __) => const SizedBox(width: 10),
        itemBuilder: (context, index) => Builder(
          builder: (context) => GestureDetector(
            onLongPressStart: (details) => showPopup(
                context: context,
                position: details.globalPosition,
                actions: [
                  ActionItem(
                    title: 'edit'.tr(),
                    icon: Icons.edit_document,
                    onTap: ()=>Zap.toNamed(AppRoutes.newTaskScreen, arguments: tasks[index]),
                  ),
                  ActionItem(
                    title: 'delete'.tr(),
                    icon: CupertinoIcons.delete,
                    textColor: Colors.red,
                    iconColor: Colors.red,
                    onTap: viewmodel.showDeleteDialog,
                  ),
                ]),
            child: TaskCard(task: tasks[index]),
          ),
        ),
      ),
    );
  }
}

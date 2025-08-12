import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tcw/core/shared/shared_widget/custom_icon_dialog.dart';
import 'package:tcw/features/tasks/presentation/cubit/course_tasks_cubit.dart';
import 'package:zapx/zapx.dart';

class TasksViewmodel {
  TasksViewmodel(this.ctx);
  final BuildContext ctx;

  showDeleteDialog() {
    customIconDialog(ctx,
        title: 'Are You Sure You Want To Delete This Task?',
        icon: const Icon(CupertinoIcons.delete),
            buttons: CustomIconDialogButtons(
            firstTitle: 'Cancel',
            secondTitle: 'Delete',
            firstOnPressed: Zap.back,
            secondOnPressed: () {}),
      );
  }
  Future<void> getCourseTasks(int courseId) async {
     return await ctx.read<CourseTasksCubit>().getCourseTasks(courseId);
  }
}

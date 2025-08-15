import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:tcw/core/constansts/context_extensions.dart';
import 'package:tcw/core/shared/shared_widget/app_bar.dart';
import 'package:tcw/core/shared/shared_widget/custom_button.dart';
import 'package:tcw/core/shared/shared_widget/search_filter_widget.dart';
import 'package:tcw/features/tasks/presentation/cubit/course_tasks_cubit.dart';
import 'package:tcw/features/tasks/presentation/pages/widgets/task_card_list.dart';
import 'package:tcw/features/tasks/presentation/tasks_viewmodel.dart';
import 'package:tcw/features/courses/presentation/widgets/section_header.dart';
import 'package:tcw/features/courses/presentation/widgets/task_card.dart';
import 'package:tcw/core/routes/app_routes.dart';
import 'package:zapx/zapx.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({super.key});

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  late final TasksViewmodel viewmodel;

  @override
  void initState() {
    super.initState();
    viewmodel = TasksViewmodel(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'tasks'.tr()), // Localized
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SearchFilterWidget(),
                SizedBox(height: context.propHeight(24)),

                BlocBuilder<CourseTasksCubit, CourseTasksState>(
                  builder: (context, state) {
                    if (state is CourseTasksLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is CourseTasksLoaded || state is CourseLoadingMore) {
                      final allTasks = context.read<CourseTasksCubit>().allTasks;

                      final todoTasks = allTasks.where((t) => t.status == 'Pending').toList();
                      final completedTasks = allTasks.where((t) => t.status == 'Completed').toList();
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SectionHeader(
                            count: todoTasks.length,
                              title: 'tasks_to_do'.tr(),
                          ),
                          SizedBox(
                            height: context.propHeight(200),
                            child: todoTasks.isEmpty
                                ? Center(child: Text('no_task_found'.tr()))
                                : ListView.separated(
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              itemCount: todoTasks.length,
                              separatorBuilder: (_, __) => const SizedBox(width: 12),
                              itemBuilder: (context, index) {
                                return SizedBox(
                                  width: context.propWidth(300),
                                  child: TaskCard(
                                    task: todoTasks[index],
                                  ),
                                );
                              },
                            ),
                          ),
                          SizedBox(height: context.propHeight(24)),

                          SectionHeader(
                            count: completedTasks.length,
                            title: 'completed_tasks'.tr(), // Localized
                          ),
                          SizedBox(
                            height: context.propHeight(200),
                            child: completedTasks.isEmpty
                                ? Center(child: Text('no_task_found'.tr()))
                                : ListView.separated(
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              itemCount: completedTasks.length,
                              separatorBuilder: (_, __) => const SizedBox(width: 12),
                              itemBuilder: (context, index) {
                                return SizedBox(
                                  width: context.propWidth(300),
                                  child: TaskCard(
                                    task: completedTasks[index],
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      );
                    } else if (state is CourseTasksError) {
                      return Center(child: Text(state.message));
                    }

                    return const SizedBox.shrink();
                  },
                ),

                SizedBox(height: context.propHeight(24)),
                CustomButton(
                  title: 'add_tasks'.tr(), // Localized
                  onPressed: () => Zap.toNamed(AppRoutes.newTaskScreen),
                  backgroundColor: Colors.black,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

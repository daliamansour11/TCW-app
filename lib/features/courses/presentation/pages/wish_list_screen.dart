import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/shared/shared_widget/app_bar.dart';

import '../cubit/course/courses_cubit.dart';
import '../widgets/programme_item_widget.dart';

class WishListScreen extends StatelessWidget {
  const WishListScreen({super.key,});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'wish_list'.tr()), // localized title
    body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocBuilder<CourseCubit, CourseState>(
          builder: (context, state) {
            final wishlist = context.read<CourseCubit>().favoriteCourses;

            if (wishlist.isEmpty) {
              return  Center(child: Text('wishlist_empty'.tr()));
            }

            return ListView.builder(
              itemCount: wishlist.length,
              itemBuilder: (context, index) {
                final lesson = wishlist[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: CourseItemWidget(program: lesson) // pass your LessonModel
                );
              },
            );
          },
        ),
      ),
    );
  }
}

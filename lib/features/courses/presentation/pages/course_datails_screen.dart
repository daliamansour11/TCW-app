
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/shared/shared_widget/app_bar.dart';
import '../../../../core/shared/shared_widget/custom_button.dart';
import '../../../../core/shared/shared_widget/custom_container.dart';
import '../../../../core/shared/shared_widget/custom_text.dart';
import '../../../../core/shared/shared_widget/riyal_logo.dart';
import '../cubit/course/courses_cubit.dart';
import '../widgets/program_expansion_tile_widget.dart';
import '../widgets/program_subscribe_rounds_widget.dart';
import '../widgets/course_topbar_details.dart';
import '../../../../core/routes/app_routes.dart';
import 'package:zap_sizer/zap_sizer.dart';
import 'package:zapx/zapx.dart';

class CourseDetailsScreen extends StatefulWidget {
  const CourseDetailsScreen({required this.courseId, super.key});

  final int courseId;

  @override
  State<CourseDetailsScreen> createState() => _ProgrameDetailsViewState();
}

class _ProgrameDetailsViewState extends State<CourseDetailsScreen> {
  bool  _isLoading = true;

  @override
  void initState() {
    super.initState();
    context.read<CourseCubit>()..fetchCourseDetails(widget.courseId);
    Timer(Duration(seconds: 12), () {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    });}


  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CourseCubit, CourseState>(
      builder: (context, state) {
        String appBarTitle = 'TCWTIR';

        if (state is CourseDetailLoaded && state.course != null) {
          final isSubscribed = state.course.data!.isSubscribed ?? false;
          appBarTitle = isSubscribed? 'TCWTIR' : (state.course.data!.title ?? 'Program Details');
        }

        return Scaffold(
            appBar: CustomAppBar(title: appBarTitle),
            body: Builder(
              builder: (_) {
                if (state is CourseLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is CourseDetailLoaded) {
                  final details = state.course;
                  if (details.data == null) {
                    return const Center(child: Text('No data available'));
                  }
                  final  isSubscribed = state.course.data?.isSubscribed ?? false;
                  return ListView(
                    padding: const EdgeInsets.all(10),
                    children: [
                      if (isSubscribed==true)
                        const CustomText('Round 1'),
                      CourseTopBarDetails(details),
                      if (isSubscribed==true)
                        ProgramSubscribeRoundsWidget(details)
                      else
                        ProgramUnSubscribeExpansionTileWidget(details),
                    ],
                  );
                } else if (state is CourseError) {
                  return Center(child: Text(state.message));
                }
                return const SizedBox.shrink();
              },
            ),
            bottomNavigationBar: (state is CourseDetailLoaded && state.course.data != null&& state.course.data?.isSubscribed==false)

                ?
            CustomContainer(
              height: 15.h,
              padding: 8,
              child: Row(
                spacing: 5,
                children: [
                  Flexible(
                    child: CustomButton(
                      title: 'Enroll Now',
                      onPressed: () => Zap.toNamed(AppRoutes.proccessPayScreen),
                      backgroundColor: Colors.black,
                    ),
                  ),
                  const SizedBox.shrink(),
                  const RiyalLogo(),
                  CustomText('${state.course.data?.price ?? 200} SAR'),
                ],
              ),
            ):const SizedBox.shrink()
        );
      },
    );
  }


}
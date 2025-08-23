import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tcw/core/shared/shared_widget/custom_container.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../../core/shared/shared_widget/search_filter_widget.dart';
import '../../data/models/enrolled_course_model.dart';
import '../../data/models/student_course_details.dart';
import '../courses_viewmodel.dart';
import '../cubit/student/student_course_cubit.dart';
import 'lesson_card.dart';

class ProgramSubscribeRoundsWidget extends StatefulWidget {
  const ProgramSubscribeRoundsWidget(this.courseId, {super.key});
  final int courseId;

  @override
  State<ProgramSubscribeRoundsWidget> createState() => _ProgramSubscribeRoundsWidgetState();
}

class _ProgramSubscribeRoundsWidgetState extends State<ProgramSubscribeRoundsWidget> {
  EnrolledCourseModel? detail;
  bool _isLoading = true;
  late final CoursesViewmodel viewmodel;



  @override
  void dispose() {
    viewmodel.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    viewmodel = CoursesViewmodel(context)..init(recommended: true);

    context.read<StudentCourseCubit>().getEnrolledCourseDetails(widget.courseId);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
           const Center(
              child:  Text(
              'Understanding Concept Of React',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
                        ),
            ),
          const SizedBox(height: 4),
              const   Center(
            child:  Text(
              'Ramy Badr  Sun, 9 July 2025',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
          ),
          const SizedBox(height: 16),
          // Search bar
              Padding(
                  padding:const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: SearchFilterWidget(
                    onChanged: (value) {
                      print('Searching for: $value');
                      CoursesViewmodel(context).onSearch(value);
                    },
                  )),
          const SizedBox(height: 16),

          // Round information
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Round 1',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                Text(
                  '12 lesson  16 h : 30 m  8h',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

           CustomContainer(
      padding:16,
      child: BlocListener<StudentCourseCubit, StudentCourseState>(
        listener: (context, state) {
          if (state is StudentCourseDetailsLoaded) {
            setState(() {
              detail = state.enrolledCourseDetails;
              _isLoading = false;
            });
          } else if (state is StudentCourseError) {
            setState(() => _isLoading = false);
          }
        },
        child: BlocBuilder<StudentCourseCubit, StudentCourseState>(
          builder: (context, state) {
            if (_isLoading || state is StudentCourseLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is StudentCourseError) {
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(state.message),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        setState(() => _isLoading = true);
                        context.read<StudentCourseCubit>().getEnrolledCourseDetails(widget.courseId);
                      },
                      child: Text(tr('retry')),
                    ),
                  ],
                ),
              );
            } else if (state is StudentCourseDetailsLoaded) {
              final sections = state.enrolledCourseDetails.sections ?? [];
              final lessons = sections.expand((section) => section.lessons).toList();

              if (lessons.isEmpty) {
                return Center(child: Text(tr('no_lessons_available')));
              }


                  // Lessons list
               return   ListView.separated(
                    itemCount: lessons.length,
                    shrinkWrap: true,
                    separatorBuilder: (context, index) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final lesson = lessons[index];
                      return LessonCard(
                        lesson: lesson,
                        index: index,
                      );
                    },

               );}

            return const SizedBox.shrink();
          },
        ),
      ),
    )])));
  }
}
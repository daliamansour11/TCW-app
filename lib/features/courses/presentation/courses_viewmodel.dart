import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tcw/features/courses/data/models/last_viewed_model.dart';
import 'package:tcw/features/courses/presentation/cubit/course/courses_cubit.dart';
import 'package:tcw/features/courses/presentation/cubit/student/student_course_cubit.dart';

class CoursesViewmodel {
  CoursesViewmodel(this.ctx);
  final BuildContext ctx;
  final int limit = 20;
  int page = 1;
  bool hasMore = true;
  String search = '';
  final ScrollController scrollController = ScrollController();
  bool isRecommended = false;

  CourseCubit get courseCubit => BlocProvider.of<CourseCubit>(ctx, listen: false);
  StudentCourseCubit get studentCourseCubit => BlocProvider.of<StudentCourseCubit>(ctx, listen: false);

  void init({bool recommended = false}) {
    isRecommended = recommended;
    scrollController.addListener(_scrollListener);
    fetchCourses(reset: true);
  }

  void dispose() {
    scrollController.removeListener(_scrollListener);
    scrollController.dispose();
  }

  void _scrollListener() {
    if (scrollController.position.pixels >=
        scrollController.position.maxScrollExtent - 200) {
      if (hasMore && courseCubit.state is! CourseLoadingMore) {
        page++;
        fetchCourses(loadMore: true);
      }
    }
  }

  Future<void> fetchCourses({bool reset = false, bool loadMore = false}) async {
    if (reset) {
      page = 1;
      hasMore = true;
    }

    try {
      if (isRecommended) {
        await courseCubit.fetchRecommendedCourses(
          limit: limit,
          offset: page,
          loadMore: loadMore,
        );
      } else {
        await courseCubit.fetchCourses(
          limit: limit,
          offset: page,
          search: search,
          loadMore: loadMore,
        );
      }

      if (!ctx.mounted) return;

      final state = courseCubit.state;
      if (state is CoursesLoaded) {
        hasMore = state.hasMore;
      } else if (state is CoursesLoaded) {
        hasMore = state.hasMore;
      }
    } catch (e) {
      if (!ctx.mounted) return;
      // Handle error state
    }
  }
  Future<void> fetchStudentCourses({bool reset = false, bool loadMore = false}) async {
    if (reset) {
      page = 1;
      hasMore = true;
    }

    try {
      if (isRecommended) {
        await courseCubit.fetchRecommendedCourses(
          limit: limit,
          offset: page,
          loadMore: loadMore,
        );
      } else {
        await studentCourseCubit.fetchEnrolledCourses(
          limit: limit,
          offset: page,

        );
      }

      if (!ctx.mounted) return;

      final state = studentCourseCubit.state;
      if (state is EnrolledCoursesLoaded) {

      }
    } catch (e) {
      if (!ctx.mounted) return;
      // Handle error state
    }
  }

  void onSearch(String value) {
    if (isRecommended) return;
    search = value;
    fetchCourses(reset: true);
  }
  Future<void> getLastViewed() async {
    try{
      await ctx.read<StudentCourseCubit>().getLastViewed();
    }catch(e){
      debugPrint('Error updating Last Viewed: $e');

    }
  }


    Future<void> updateLastViewed(LastViewedModel model) async {
    try{
      await ctx.read<StudentCourseCubit>().updateLastViewed(
           model );
    } catch (e) {
      debugPrint('Error updating Last Viewed: $e');
    }
  }
}
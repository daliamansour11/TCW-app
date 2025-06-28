import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tcw/features/courses/presentation/cubit/course/courses_cubit.dart';

class CoursesViewmodel {
  CoursesViewmodel(this.ctx);
  final BuildContext ctx;
  final int limit = 20;
  int page = 1;
  bool hasMore = true;
  String search = '';
  final ScrollController scrollController = ScrollController();

  CourseCubit get courseCubit => ctx.read<CourseCubit>();

  void init() {
    scrollController.addListener(_scrollListener);
    fetchCourses(reset: true);
  }

  void dispose() {
    scrollController.removeListener(_scrollListener);
    scrollController.dispose();
  }

  void _scrollListener() {
    if (scrollController.position.pixels >= scrollController.position.maxScrollExtent - 200) {
      if (hasMore && ctx.read<CourseCubit>().state is! CourseLoadingMore) {
        page++;
        fetchCourses(loadMore: true);
      }
    }
  }

  Future<void> fetchCourses({bool reset = false, bool loadMore = false}) async {
    if (reset) {
      page = 1;
      hasMore = true;
      await courseCubit.fetchCourses(limit: limit, offset: page, search: search, loadMore: false);
    } else {
      await courseCubit.fetchCourses(limit: limit, offset: page, search: search, loadMore: loadMore);
    }
    if(!ctx.mounted)return;
    final state = ctx.read<CourseCubit>().state;
    if (state is CoursesLoaded) {
      hasMore = state.hasMore;
    }
  }

  void onSearch(String value) {
    search = value;
    fetchCourses(reset: true);
  }}

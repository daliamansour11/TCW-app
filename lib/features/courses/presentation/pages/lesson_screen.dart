import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';
import 'package:tcw/core/constansts/context_extensions.dart';
import 'package:tcw/core/shared/shared_widget/custom_text.dart';
import 'package:tcw/core/theme/app_colors.dart';
import 'package:tcw/features/courses/data/models/task_model.dart';
import 'package:tcw/core/routes/app_routes.dart';
import 'package:tcw/features/tasks/presentation/cubit/course_tasks_cubit.dart';
import 'package:zapx/zapx.dart';

import '../../../../core/shared/shared_widget/custom_container.dart';
import '../../../../core/storage/secure_storage_service.dart';
import '../../../auth/data/models/user_model.dart';
import '../../../programmes/data/models/program_detail_model.dart';
import '../../data/models/last_viewed_model.dart';

import '../widgets/video_player_widget.dart';
class LessonScreen extends StatefulWidget {
  final LessonModel lesson;
// final  Instructor? instructorName;
  const LessonScreen({super.key, required this.lesson, });

  @override
  State<LessonScreen> createState() => _LessonScreenState();
}
class _LessonScreenState extends State<LessonScreen> {
  int? _userId;
  VideoPlayerController? _controller;
  bool _addedToContinueWatching = false;
  Timer? _periodicSaveTimer;
  Timer? _youtubeWatchTimer; // NEW for YouTube videos

  @override
  void initState() {
    super.initState();
    _loadUserId();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _updateLastViewed();
    });

    // Init YouTube or normal video tracking
    final videoUrl = widget.lesson.video?.linkPath ?? '';
    if (_isYoutubeUrl(videoUrl)) {
      _startYoutubeWatchTimer();
    } else {
      _initVideoControllerIfNeeded(videoUrl);
    }
  }

  Future<void> _loadUserId() async {
    final storage = SecureStorageService.instance;
    final data = await storage.get(StorageKey.userData);
    if (data != null) {
      final userMap = data as Map<String, dynamic>;
      final user = UserModel.fromJson(userMap);
      setState(() {
        _userId = user.id;
      });
    }
  }
  int _lastPosition = 0;
  void _updateLastViewed() {
    // ContinueWatchingManager.addOrUpdateLesson(
    //   section: widget.lesson.sectionId,
    //   lesson: widget.lesson,
    //   resumePositionMs: _playerController.currentPositionMs,
    // );
    if (_userId == null) return;
    if (_addedToContinueWatching) return; // prevent duplicates

    _addedToContinueWatching = true;
    // context.read<StudentCourseCubit>().updateLastViewed(
    //   widget.lesson.courseId ?? 0,
    //   widget.lesson.sectionId ?? 0,
    //   widget.lesson.id ?? 0,
    // );
  }void _videoListener() {
    if (_controller == null) return;
    final pos = _controller!.value.position.inSeconds;
    _lastPosition = pos; // Track current position

    if (pos >= 10 && !_addedToContinueWatching) {
      _updateLastViewed();
    }
  }
  bool _isYoutubeUrl(String? url) {
    if (url == null) return false;
    final uri = Uri.tryParse(url);
    if (uri == null) return false;
    return uri.host.contains('youtube.com') || uri.host.contains('youtu.be');
  }

  void _initVideoControllerIfNeeded(String videoUrl) async {
    if (videoUrl.isEmpty) return;

    _controller = VideoPlayerController.network(videoUrl);
    try {
      await _controller!.initialize();
      _controller!.addListener(_videoListener);
      _controller!.play();

      if (mounted) setState(() {});
    } catch (_) {}
  }


  void _startYoutubeWatchTimer() {
    int secondsWatched = 0;
    _youtubeWatchTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      secondsWatched++;
      if (secondsWatched >= 10 && !_addedToContinueWatching) {
        _updateLastViewed();
        timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    _youtubeWatchTimer?.cancel();
    _periodicSaveTimer?.cancel();
    _controller?.removeListener(_videoListener);
    _controller?.dispose();

    if (!_addedToContinueWatching) {
      _updateLastViewed();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final lesson = widget.lesson;
    final videoUrl = lesson.video?.linkPath ?? '';

    return Scaffold(
      appBar: AppBar(
        title: Text(
          lesson.title ?? '',
          style: context.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: Text(
                  'Ramy Badr • Sun, 9 March 2025',
                  style: TextStyle(color: Colors.grey),
                ),
              ),

              Container(
                height: 220,
                width: double.infinity,
                margin: const EdgeInsets.only(top: 12, bottom: 12),
                child: _isYoutubeUrl(videoUrl)
                    ? VideoPlayerWidget(
                  videoUrl: videoUrl,
                   lessonId: widget.lesson.id??0,
                )
                    : _controller != null && _controller!.value.isInitialized
                    ? AspectRatio(
                  aspectRatio: _controller!.value.aspectRatio,
                  child: VideoPlayer(_controller!),
                )
                    : Center(child: CircularProgressIndicator()),
              ),

              _buildLessonInfo(context),
              _buildTaskCard(context),
              _buildSectionHeader(
                'Continue Watching',
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomContainer(
                      padding: 3,
                      isCircle: true,
                      color: Colors.transparent,
                      border: Border.all(color: Colors.black),
                      child: const Icon(
                        Icons.arrow_back_ios_new,
                        size: 12,
                      ),
                    ),
                    const SizedBox(width: 8),
                    const CustomContainer(
                      padding: 3,
                      isCircle: true,
                      color: Colors.black,
                      child: Icon(
                        Icons.arrow_forward_ios,
                        size: 12,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
              ),

              // SizedBox(
              //   height: 150,
              //   child: _continueWatching.isEmpty
              //       ? Center(
              //     child: Text(
              //       'No items yet.',
              //       style: context.textTheme.bodyMedium?.copyWith(color: const Color(0xFF9E9E9E)),
              //     ),
              //   )
              //       : ListView.separated(
              //     scrollDirection: Axis.horizontal,
              //     itemCount: _continueWatching.length,
              //     separatorBuilder: (_, __) => const SizedBox(width: 12),
              //     itemBuilder: (context, index) {
              //       final item = _continueWatching[index];
              //       final itemVideoUrl = item['videoUrl'] as String? ?? '';
              //       final title = item['title'] as String? ?? 'Untitled';
              //       final thumbnail = getVideoThumbnail(itemVideoUrl);
              //       return GestureDetector(
              //         onTap: () async {
              //           // Navigate to lesson screen. we pass a Map — adapt on receiver if needed.
              //           Zap.toNamed(AppRoutes.lessonScreen, arguments: item);
              //         },
              //         child: Column(
              //           children: [
              //             ClipRRect(
              //               borderRadius: BorderRadius.circular(12),
              //               child: Image.network(
              //                 thumbnail,
              //                 height: 100,
              //                 width: 160,
              //                 fit: BoxFit.cover,
              //               ),
              //             ),
              //             const SizedBox(height: 8),
              //             SizedBox(
              //               width: 160,
              //               child: Text(
              //                 title,
              //                 style: context.textTheme.bodyMedium?.copyWith(
              //                   fontWeight: FontWeight.w600,
              //                 ),
              //                 maxLines: 2,
              //                 overflow: TextOverflow.ellipsis,
              //               ),
              //             ),
              //           ],
              //         ),
              //       );
              //     },
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTaskItem(BuildContext context, Task task) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                task.title,
                style: context.textTheme.headlineSmall?.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0x1A951111),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                '1 Day Left',
                style: context.textTheme.labelMedium?.copyWith(
                  color: const Color(0xFF951111),
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          task.description ?? '',
          style: context.textTheme.bodyMedium?.copyWith(
            color: const Color(0xFF9E9E9E),
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(height: 16),
        Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: () => Zap.toNamed(AppRoutes.tasksScreen),
            style: TextButton.styleFrom(
              foregroundColor: AppColors.primaryColor,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
                side: const BorderSide(color: AppColors.primaryColor),
              ),
            ),
            child: Text(
              'View Details',
              style: context.textTheme.labelMedium?.copyWith(
                fontSize: 12,
                color: AppColors.primaryColor,
              ),
            ),
          ),
        ),
        const Divider(height: 32, color: Color(0xFFF1F1F5)),
      ],
    );
  }
  Widget _buildContinueWatchingCard(LastViewedModel? lastViewed) {
    if (lastViewed == null) return SizedBox.shrink();

    return GestureDetector(
      child: Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 6,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            // Thumbnail
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                // _getVideoThumbnail(lastViewed.),
                '',
                width: 120,
                height: 80,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 16),
            // Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Continue Watching',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text("",
                    style: TextStyle(fontSize: 14),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 8),
                  LinearProgressIndicator(
                    value: 4,
                    backgroundColor: Colors.grey[300],
                    color: AppColors.primaryColor,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  // String _getVideoThumbnail(String? url) {
  //   // Your existing thumbnail generation logic
  // }
  Widget _buildLessonInfo(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: _boxDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            decoration: BoxDecoration(
              color: const Color(0x33B7924F),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              'Lesson ${widget.lesson.id}',
              style: context.textTheme.labelMedium?.copyWith(
                fontSize: 12,
                color: AppColors.primaryColor,
              ),
            ),
          ),
          Text(
            '${widget.lesson.title ?? ''}',
            style: context.textTheme.headlineSmall?.copyWith(
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            widget.lesson.description ??
                'This lesson covers how to apply styles dynamically and conditionally...,This lesson covers how to apply styles dynamically and conditionally...}',
            style: context.textTheme.bodyMedium?.copyWith(
              color: const Color(0xFF9E9E9E),
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTaskCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: _boxDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Task',
            style: context.textTheme.headlineSmall?.copyWith(
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),

          BlocConsumer<CourseTasksCubit, CourseTasksState>(
              listener: (context, state) {
                if (state is CourseTasksError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.message)),
                  );
                }
              },
              builder: (context, state) {
                if (state is CourseTasksLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is CourseTasksLoaded || state is CourseLoadingMore) {
                  final tasks = (state is CourseTasksLoaded)
                      ? state.tasks
                      : context.read<CourseTasksCubit>().allTasks;
                  if (tasks.isEmpty) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          'No Task Found.',
                          style: context.textTheme.bodyMedium?.copyWith(
                            color: const Color(0xFF9E9E9E),
                          ),
                        ),
                      ),
                    );
                  }
                  return CustomContainer(
                    padding: 16,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Task',
                              style: context.textTheme.headlineSmall?.copyWith(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Text(
                              '1/2',
                              style: context.textTheme.bodyMedium?.copyWith(
                                color: const Color(0xFF9E9E9E),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        ...tasks.map((task) => _buildTaskItem(context, task)).toList(),
                      ],
                    ),
                  );
                }
                return const SizedBox.shrink();
              })
        ],
      ),
    );
  }

  Widget _buildSectionHeader(
      String title, {
        String? subTitle,
        Widget? trailing,
      }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  title,
                  fontType: FontType.Poppins,
                  fontWeight: FontWeight.bold,
                ),
                if (subTitle != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 2),
                    child: CustomText(
                      subTitle,
                      fontType: FontType.Poppins,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Colors.grey,
                    ),
                  ),
              ],
            ),
          ),
          if (trailing != null) trailing,
        ],
      ),
    );
  }

  BoxDecoration _boxDecoration() {
    return const BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(12),
        topRight: Radius.circular(12),
      ),
      boxShadow: [
        BoxShadow(
          color: Color(0x0F080F34),
          blurRadius: 42,
          offset: Offset(0, 14),
        ),
      ],
    );
  }
}

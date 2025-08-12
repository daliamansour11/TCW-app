import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tcw/core/shared/log/logger.dart';
import 'package:tcw/core/shared/shared_widget/custom_button.dart';
import 'package:tcw/core/shared/shared_widget/custom_container.dart';
import 'package:tcw/core/shared/shared_widget/custom_text.dart';
import 'package:tcw/core/shared/shared_widget/search_filter_widget.dart';
import 'package:tcw/core/utils/asset_utils.dart';
import 'package:tcw/core/shared/shared_widget/show_more_tile_widget.dart';
import 'package:tcw/core/theme/app_colors.dart';
import 'package:tcw/features/auth/data/models/user_model.dart';
import 'package:tcw/features/courses/data/models/enrolled_course_model.dart';
import 'package:tcw/features/courses/presentation/courses_viewmodel.dart';
import 'package:tcw/features/courses/presentation/cubit/student/student_course_cubit.dart';
import 'package:tcw/features/courses/presentation/widgets/vertical_course_card.dart';
import 'package:tcw/features/courses/presentation/widgets/courses_list_screen.dart';
import 'package:tcw/features/event/data/models/event_model.dart';
import 'package:tcw/features/event/presentation/cubit/event_cubit.dart';
import 'package:tcw/features/event/presentation/widgets/event_slider_widget.dart';
import 'package:tcw/features/notification/presentation/cubit/notification_cubit.dart';
import 'package:tcw/features/profile/data/model/video_item.dart';
import 'package:tcw/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:tcw/features/profile/presentation/widgets/hour_chart.dart';
import 'package:tcw/features/profile/presentation/widgets/state_item_widget.dart';
import 'package:tcw/features/profile/presentation/widgets/user_header_widget.dart';
import 'package:tcw/features/programmes/presentation/cubit/program_cubit.dart';
import 'package:tcw/features/reels/data/datasource/local_data_source/reel_history.dart';
import 'package:tcw/features/reels/data/models/reel_history_model.dart';
import 'package:tcw/features/reels/data/models/reel_model.dart';
import 'package:tcw/core/routes/app_routes.dart';
import 'package:zap_sizer/zap_sizer.dart';
import 'package:zapx/zapx.dart';

import '../../../courses/data/local_data_source/local_storage.dart';
import '../../../courses/data/models/lesson_model.dart';
import '../../../courses/presentation/widgets/lesson_card.dart';
import '../../../event/data/models/live_model_details.dart' hide Meeting;

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  EnrolledCourseModel? courses;
  CoursesViewmodel? viewmodel;
  bool  _isLoading = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<NotificationCubit>().fetchStudentPushNotification();
      context.read<StudentCourseCubit>()..fetchEnrolledCourses(limit: 10,offset: 1);
      context.read<EventCubit>()..getEvents();
      WidgetsBinding.instance.addPostFrameCallback((_) {
        viewmodel = CoursesViewmodel(context);
        viewmodel?.init();
        Timer(Duration(seconds: 12), () {
          if (mounted) {
            setState(() {
              _isLoading = false;
            });
          }
        });}

      );});
    // _continueWatchingFuture = _continueWatchingManager.getContinueWatchingVideos();
  }


  late  final List<VideoItem> videos;
  final List<Meeting> sampleMeetings = [
    Meeting(
      id: 1,
      title: "Intro to Programming",
      meetingLink: "https://meet.google.com/poa-dgpu-etr",
      scheduledAt: DateTime.parse("2025-08-15 10:00:00"),
      scheduledForHumans: "4 days from now",
      course: Course(id: 3, title: "Design"),
      subTitle: 'null',
      // instructor: Instructor(id: 37, name: "Dalia Mansour"),
      enrolledStudentsCount: 0,
      comments: [],
      thumbUrl: "https://example.com/image1.jpg", instructor: Instructor(id: 37, name: "Dalia Mansour"),
    ),
    Meeting(
      id: 2,
      title: "Advanced Design",
      meetingLink: "https://meet.google.com/xyz-abc-def",
      scheduledAt: DateTime.parse("2025-08-20 15:00:00"),
      scheduledForHumans: "9 days from now",
      course: Course(id: 4, title: "Advanced Course"),
      subTitle: '',
      instructor: Instructor(id: 38, name: "John Doe"),
      enrolledStudentsCount: 4,
      comments: [],
      thumbUrl: "https://example.com/image2.jpg",
    ),
  ];



  @override
  Widget build(BuildContext context) {



    logger.d(userData?.email);
    return Scaffold(

      key: _scaffoldKey,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          const Icon(Icons.calendar_today_outlined, size: 25),
          const SizedBox(width: 8),
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: _scaffoldKey.currentState?.openDrawer,
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(

          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 10,
            children: [
              BlocProvider(
                create: (context) => ProfileCubit(),
                child: const UserHeader(),
              ),
              _buildStats(),
              SearchFilterWidget(
                onChanged: (value) {
                  context.read<StudentCourseCubit>().fetchEnrolledCourses(search: value);
                },
              ),
              EventSlider(events: sampleMeetings),
              // BlocBuilder<EventCubit, EventState>(
              //   builder: (context, state) {
              //     if (state is EventLoading) {
              //       if (_isLoading) {
              //         return const Center(child: CircularProgressIndicator());
              //       } else {
              //         return Center(
              //           child: Column(
              //             mainAxisSize: MainAxisSize.min,
              //             children: [
              //               const Text('Something went wrong or took too long.'),
              //               const SizedBox(height: 10),
              //               ElevatedButton(
              //                 onPressed: () {
              //                   setState(() {
              //                     _isLoading = true;
              //                   });
              //                   context.read<EventCubit>()..getEvents();
              //                   Timer(const Duration(seconds: 12), () {
              //                     if (mounted) {
              //                       setState(() {
              //                         _isLoading = false;
              //                       });
              //                     }
              //                   });
              //                 },
              //                 child: const Text('Retry'),
              //               ),
              //             ],
              //           ),
              //         );
              //       }          } else if (state is EventLoaded) {
              //       final events = state.event.data;
              //       if (events.isEmpty) {
              //         return Center(child: const CustomText('No Events Available'));
              //       }
              //       return EventSlider(events: events);
              //     } else if (state is EventError) {
              //       return CustomText('Error: ${state.message}');
              //     } else {
              //       return const SizedBox();
              //     }
              //   },
              //
              // ),
              _buildSectionHeader(
                'Reels History',
                trailing: ShowMoreTileWidget(
                  onTab: () => Zap.toNamed(AppRoutes.reelsHistoryPage),
                ),
              ),
              FutureBuilder<List<ReelHistoryModel>>(
                future: fetchLimitedReelsFromHistory(limit: 5),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const CustomText('No recently watched reels.');
                  }

                  final reels = snapshot.data!;
                  return SizedBox(
                    height: 25.h,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: reels.length,
                      separatorBuilder: (_, __) => const SizedBox(width: 8),
                      itemBuilder: (context, index) {
                        final reel = reels[index];
                        return GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                AppRoutes.reelViewScreen,
                                arguments: Datum.fromHistory(reel),
                              );
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: CachedNetworkImage(
                                height: 25.h, width:30.w, fit: BoxFit.cover,
                                placeholder: (context, url) => Image.asset(AssetUtils.programPlaceHolder),
                                errorWidget: (context, url, error) =>
                                    Image.asset(
                                      AssetUtils.reel,
                                      fit: BoxFit.cover,),                        imageUrl:                               reel.thumbnailUrl,
                              ),
                            ));
                      },
                    ),
                  );
                },
              ),

              _buildSectionHeader(
                'Continue Watching',
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  spacing: 5,
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
              //   height: 160,
              //   child: FutureBuilder<List<Map<String, dynamic>>>(
              //     future: _continueWatchingFuture,
              //     builder: (context, snapshot) {
              //       if (snapshot.connectionState == ConnectionState.waiting) {
              //         return const Center(child: CircularProgressIndicator());
              //       }
              //       if (!snapshot.hasData || snapshot.data!.isEmpty) {
              //         return const Center(child: Text('No videos to continue watching.'));
              //       }
              //
              //       final videos = snapshot.data!;
              //
              //       return ListView.separated(
              //         scrollDirection: Axis.horizontal,
              //         itemCount: videos.length,
              //         separatorBuilder: (_, __) => const SizedBox(width: 8),
              //         itemBuilder: (context, index) {
              //           final video = videos[index];
              //           final position = video['position'] ?? 0;
              //           final videoUrl = video['videoUrl'] ?? '';
              //           final videoId = video['videoId'] ?? '';
              //
              //           return GestureDetector(
              //             onTap: () {
              //               final lesson = LessonModel(
              //                 id: videoId,
              //                 video: videoUrl, resumePositionMs: null,
              //               );
              //
              //               Zap.toNamed(
              //                 AppRoutes.lessonScreen,
              //                 arguments: lesson,
              //               );
              //             },
              //
              //             child: ClipRRect(
              //               borderRadius: BorderRadius.circular(10),
              //               child: CachedNetworkImage(
              //                 width: 130,
              //                 height: 160,
              //                 fit: BoxFit.cover,
              //                 imageUrl: videoUrl,
              //                 placeholder: (context, url) =>
              //                     Image.asset(AssetUtils.programPlaceHolder),
              //                 errorWidget: (context, url, error) =>
              //                     Image.asset(AssetUtils.programPlaceHolder),
              //               ),
              //             ),
              //           );
              //         },
              //       );
              //     },
              //   ),
              // ),
              _buildSectionHeader('Your Programs',
                  trailing: ShowMoreTileWidget(
                    onTab: () => Zap.toNamed(AppRoutes.programmesView),
                  )),
              BlocBuilder<StudentCourseCubit, StudentCourseState>(
                builder: (context, state) {
                  if (state is StudentCourseLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is EnrolledCoursesLoaded) {
                    if (state.courses.isEmpty) {
                      return const Center(child: Text('No Programs found.'));
                    }

                    return CourseListScreen(courses: state.courses);

                  } else if (state is StudentCourseError) {
                    return Center(child: Text('Error: ${state.message}'));
                  } else {
                    return const Center(child: Text('Something went wrong.'));
                  }
                },
              ),



              _buildSectionHeader('Your Mentor',
                  trailing: const Icon(Icons.add_circle_outline_sharp,
                      color: Colors.grey)),
              CustomContainer(
                color: Colors.white,
                boxShadow: AppColors.cardShadow,
                child: ListTile(
                    leading: const CircleAvatar(
                      backgroundImage: AssetImage(AssetUtils.ex_2),
                    ),
                    title: Text('Rawan',
                        style:
                        GoogleFonts.poppins(fontWeight: FontWeight.bold)),
                    subtitle: Text('Mentor',
                        style: GoogleFonts.poppins(color: Colors.grey)),
                    trailing: CustomButton(
                      onPressed: () {},
                      width: 10.w,
                      backgroundColor: Colors.black,
                      title: 'Contact Now',
                      style: CustomText.style(fontSize: 14),
                    )),
              ),

              const SizedBox(),
              _buildSectionHeader('Weekly Study Hours'),
              const HourChart(),
              const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStats() {
    return BlocBuilder<NotificationCubit, NotificationState>(
      builder: (context, state) {
        final unreadCount = context.read<NotificationCubit>().unreadCount;

        final List<Map<String, dynamic>> statsItems = [
          {
            'lable': 'Notification',
            'icon': AssetUtils.notification,
            'count': '$unreadCount',
            'route': AppRoutes.notificationScreen,
            'args': true,
          },
          {
            'lable': 'Points',
            'icon': AssetUtils.point,
            'count': '100',
            'route': AppRoutes.pointsRewardsScreen,
            'args': true,
          },
          {
            'lable': 'Rewards',
            'icon': AssetUtils.rewards,
            'count': '2',
            'route': AppRoutes.pointsRewardsScreen,
            'args': false,
          },
        ];

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: statsItems
              .map(
                (item) => StateItem(
              context: context,
              icon: item['icon'],
              count: item['count'],
              label: item['lable'],
              onTab: () => Zap.toNamed(
                item['route'],
                arguments: item['args'],
              ),
            ),
          )
              .toList(),
        );
      },
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
                      fontSize: 12,
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
}

import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/shared/shared_widget/custom_button.dart';
import '../../../../core/shared/shared_widget/custom_container.dart';
import '../../../../core/shared/shared_widget/custom_text.dart';
import '../../../../core/shared/shared_widget/search_filter_widget.dart';
import '../../../../core/utils/asset_utils.dart';
import '../../../../core/shared/shared_widget/show_more_tile_widget.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../auth/data/datasources/auth_local_datasource_impl.dart';
import '../../../courses/data/models/enrolled_course_model.dart';
import '../../../courses/presentation/courses_viewmodel.dart';
import '../../../courses/presentation/cubit/course/courses_cubit.dart';
import '../../../courses/presentation/cubit/student/student_course_cubit.dart';
import '../../../courses/presentation/pages/your_courses_screen.dart';
import '../../../courses/presentation/widgets/courses_list_screen.dart';
import '../../../event/presentation/cubit/event_cubit.dart';
import '../../../event/presentation/widgets/event_slider_widget.dart';
import '../../../notification/presentation/cubit/notification_cubit.dart';
import '../cubit/profile_cubit.dart';
import '../widgets/hour_chart.dart';
import '../widgets/state_item_widget.dart';
import '../widgets/user_header_widget.dart';
import '../../../reels/data/datasource/local_data_source/reel_history.dart';
import '../../../reels/data/models/reel_history_model.dart';
import '../../../reels/data/models/reel_model.dart';
import '../../../../core/routes/app_routes.dart';
import 'package:zap_sizer/zap_sizer.dart';
import 'package:zapx/zapx.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  EnrolledCourseModel? courses;
  CoursesViewmodel? viewmodel;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<NotificationCubit>().fetchStudentPushNotification();
      context
          .read<StudentCourseCubit>()
          .fetchEnrolledCourses(limit: 10, offset: 1);
      context.read<CourseCubit>().fetchCourses(limit: 10, offset: 1);
      context.read<EventCubit>().getEvents();
      WidgetsBinding.instance.addPostFrameCallback((_) {
        viewmodel = CoursesViewmodel(context);
        viewmodel?.init();
        Timer(const Duration(seconds: 12), () {
          if (mounted) {
            setState(() {
              _isLoading = false;
            });
          }
        });
      });
    });
  }
  Future<int?> getCurrentUserId() async {
    final authLocal = AuthLocalDatasourceImpl();
    final user = await authLocal.getLoggedUser();
    return user?.id;
  }

  @override
  Widget build(BuildContext context) {

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
                  context
                      .read<StudentCourseCubit>()
                      .fetchEnrolledCourses(search: value);
                },
              ),
              BlocBuilder<EventCubit, EventState>(
                builder: (context, state) {
                  if (state is EventLoading) {
                    if (_isLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else {
                      return Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text('error.something_went_wrong'.tr()),
                            const SizedBox(height: 10),
                            ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  _isLoading = true;
                                });
                                context.read<EventCubit>()
                                  ..getEvents();
                                Timer(const Duration(seconds: 12), () {
                                  if (mounted) {
                                    setState(() {
                                      _isLoading = false;
                                    });
                                  }
                                });
                              },
                              child: Text('retry'.tr()),
                            ),
                          ],
                        ),
                      );
                    }
                  } else if (state is EventLoaded) {
                    final events = state.event.data;
                    if (events.isEmpty) {
                      return Center(child: CustomText('profile.no_events'
                          .tr()));
                    }
                    return EventSlider(events: events);
                  } else if (state is EventError) {
                    return CustomText('Error: ${state.message}');
                  } else {
                    return const SizedBox();
                  }
                },

              ),
              _buildSectionHeader(
                'profile.reels_history'.tr(),
                trailing: ShowMoreTileWidget(
                  onTab: () => Zap.toNamed(AppRoutes.reelsHistoryPage),
                ),
              ),

              const SizedBox(height: 8),
              FutureBuilder<List<ReelHistoryModel>>(
                future: fetchUserReelHistory(limit: 5),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const SizedBox(
                      height: 150,
                      child: Center(child: CircularProgressIndicator()),
                    );
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return SizedBox(
                      height: 150,
                      child: Center(
                        child: Text(
                          'profile.no_recent_reels'.tr(),
                          style: const TextStyle(color: Colors.grey),
                        ),
                      ),
                    );
                  }

                  final reels = snapshot.data!;
                  return SizedBox(
                    height: 150,
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
                              imageUrl: reel.thumbnailUrl,
                              width: 120,
                              height: 150,
                              fit: BoxFit.cover,
                              placeholder: (context, url) =>
                                  Container(
                                    color: Colors.grey.shade300,
                                  ),
                              errorWidget: (context, url, error) =>
                                  Container(
                                    color: Colors.grey,
                                    child: const Icon(
                                        Icons.error, color: Colors.white),
                                  ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),

              _buildSectionHeader(
                'profile.continue_watching'.tr(),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  spacing: 5,
                  children: [
                    CustomContainer(
                      padding: 3,
                      isCircle: true,
                      color: Colors.transparent,
                      border: Border.all(color: Colors.black),
                      child: const Icon(Icons.arrow_back_ios_new, size: 12),
                    ),
                    const CustomContainer(
                      padding: 3,
                      isCircle: true,
                      color: Colors.black,
                      child: Icon(Icons.arrow_forward_ios,
                          size: 12, color: Colors.white),
                    )
                  ],
                ),
              ),
              _buildSectionHeader('profile.your_programs'.tr(),
                  trailing: ShowMoreTileWidget(
                    onTab: () => Zap.toNamed(AppRoutes.coursesScreen),
                  )), BlocBuilder<StudentCourseCubit, StudentCourseState>(
                builder: (context, state) {
                  if (state is StudentCourseLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is EnrolledCoursesLoaded) {
                    if (state.courses.isEmpty) {
                      return Center(child: Text('profile.no_programs_found'
                          .tr()));
                    }
                    return CourseListScreen(courses: state.courses);
                  } else if (state is StudentCourseError) {
                   return Center(
                        child: Text('${'error'.tr()}: ${state.message}'));
                  } else {
                    return Center(
                        child: Text('error.something_went_wrong'.tr()));
                  }
                },
              ),
              _buildSectionHeader('profile.your_mentor'.tr(),
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
                    subtitle: Text('profile.mentor'.tr(),
                        style: GoogleFonts.poppins(color: Colors.grey)),
                    trailing: CustomButton(
                      onPressed: () {},
                      width: 10.w,
                      backgroundColor: Colors.black,
                      title: 'profile.contact_now'.tr(),
                      style: CustomText.style(fontSize: 14),
                    )),
              ),
              const SizedBox(),
              _buildSectionHeader('profile.weekly_study_hours'.tr()),
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
            'lable': 'profile.notification'.tr(),
            'icon': AssetUtils.notification,
            'count': '$unreadCount',
            'route': AppRoutes.notificationScreen,
            'args': true,
          },
          {
            'lable': 'profile.points'.tr(),
            'icon': AssetUtils.point,
            'count': '100',
            'route': AppRoutes.pointsRewardsScreen,
            'args': true,
          },
          {
            'lable': 'profile.rewards'.tr(),
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

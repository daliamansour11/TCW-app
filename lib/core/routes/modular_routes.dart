import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
// ignore: implementation_imports
import 'package:modular_interfaces/src/route/modular_arguments.dart';
import 'package:tcw/features/ai/presentation/pages/ai_screen.dart';
import 'package:tcw/features/auth/data/datasources/auth_local_datasource_impl.dart';
import 'package:tcw/features/auth/data/datasources/auth_remote_datasource_impl.dart';
import 'package:tcw/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:tcw/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:tcw/features/auth/presentation/pages/forget_password_screen.dart';
import 'package:tcw/features/auth/presentation/pages/login_screen.dart';
import 'package:tcw/features/auth/presentation/pages/next_or_back_screen.dart';
import 'package:tcw/features/auth/presentation/pages/on_bording_screens.dart';
import 'package:tcw/features/auth/presentation/pages/reset_password_screen.dart';
import 'package:tcw/features/auth/presentation/pages/splash_screen.dart';
import 'package:tcw/features/auth/presentation/pages/verification_screen.dart';
import 'package:tcw/features/chat/presentation/pages/group_chat_screen.dart';
import 'package:tcw/features/chat/presentation/pages/groups_screen.dart';
import 'package:tcw/features/chat/presentation/pages/inbox_screen.dart';
import 'package:tcw/features/chat/presentation/pages/message_screen.dart';
import 'package:tcw/features/chat/presentation/pages/new_group_screen.dart';
import 'package:tcw/features/courses/data/models/task_model.dart';
import 'package:tcw/features/courses/data/repositories/student_course_repository_impl.dart';
import 'package:tcw/features/courses/presentation/cubit/student/student_course_cubit.dart';
import 'package:tcw/features/courses/presentation/pages/course_datails_screen.dart';
import 'package:tcw/features/courses/presentation/pages/courses_screen.dart';
import 'package:tcw/features/courses/presentation/pages/lesson_screen.dart';
import 'package:tcw/features/courses/presentation/pages/my_library_screen.dart';
import 'package:tcw/features/courses/presentation/pages/recommended_courses_screen.dart';
import 'package:tcw/features/payment/presentation/pages/new_card_screen.dart';
import 'package:tcw/features/payment/presentation/pages/proccess_pay_screen.dart';
import 'package:tcw/features/tasks/presentation/pages/new_task_screen.dart';
import 'package:tcw/features/tasks/presentation/pages/task_detail_screen.dart';
import 'package:tcw/features/event/presentation/pages/event_calendar_screen.dart';
import 'package:tcw/features/programmes/presentation/pages/programe_details_view.dart';
import 'package:tcw/features/programmes/presentation/pages/programmes_view.dart';
import 'package:tcw/features/reels/presentation/pages/create_reel_page.dart';
import 'package:tcw/features/reels/presentation/pages/reel_view_screen.dart';
import 'package:tcw/features/tasks/presentation/pages/tasks_screen.dart';
import 'package:tcw/features/courses/presentation/pages/wish_list_screen.dart';
import 'package:tcw/features/courses/presentation/pages/your_courses_screen.dart';
import 'package:tcw/features/event/data/models/question_model.dart';
import 'package:tcw/features/event/presentation/pages/event_screen.dart';
import 'package:tcw/features/event/presentation/pages/live_event_screen.dart';
import 'package:tcw/features/home/presentation/pages/home_layout_screen.dart';
import 'package:tcw/features/notification/presentation/pages/notification_screen.dart';
import 'package:tcw/features/payment/presentation/pages/payment_screen.dart';
import 'package:tcw/features/points/presentation/pages/points_rewards_screen.dart';
import 'package:tcw/features/reels/data/models/reel_model.dart';
import 'package:tcw/features/reels/presentation/pages/media_screen.dart';
import 'package:tcw/features/reels/presentation/pages/reels_history_page.dart';
import 'package:tcw/features/setting/presentation/pages/personal_details_screen.dart';
import 'package:tcw/features/setting/presentation/pages/setting_screen.dart';
import 'package:tcw/features/setting/presentation/pages/support_screen.dart';
import 'package:tcw/core/routes/app_routes.dart';
import 'package:tcw/features/profile/presentation/cubit/profile_cubit.dart';
TransitionType transition = TransitionType.upToDown;
List<ModularRoute> modularRoutes = <ChildRoute>[
  ChildRoute(
    AppRoutes.aiScreen,
    child: (_, ModularArguments args) => const AiScreen(),
    transition: transition,
  ),
  ChildRoute(
    AppRoutes.start,
    child: (_, ModularArguments args) => const SplashScreen(),
    transition: transition,
  ),
  ChildRoute(
    AppRoutes.onboarding,
    child: (_, ModularArguments args) => const OnboardingScreen(),
    transition: transition,
  ),
  ChildRoute(
    AppRoutes.newOrOldUserScreen,
    child: (_, ModularArguments args) => const NextOrBackScreen(),
    transition: transition,
  ),
  ChildRoute(
    AppRoutes.loginPage,
    child: (_, ModularArguments args) => BlocProvider(
      create: (context) => AuthCubit(
        AuthRepositoryImpl(
          AuthRemoteDatasourceImpl(),
          AuthLocalDatasourceImpl(),
        ),
      ),
      child: const LoginPage(),
    ),
    transition: transition,
  ),
  ChildRoute(
    AppRoutes.resetPasswordScreen,
    child: (_, ModularArguments args) => BlocProvider(
        create: (context) => AuthCubit(
              AuthRepositoryImpl(
                AuthRemoteDatasourceImpl(),
                AuthLocalDatasourceImpl(),
              ),
            ),
        child: ResetPasswordScreen(
          email: args.data['email'],
          otp: args.data['otp'],
        )),
    transition: transition,
  ),
  ChildRoute(
    AppRoutes.forgetPasswordScreen,
    child: (_, ModularArguments args) => BlocProvider(
      create: (context) => AuthCubit(
        AuthRepositoryImpl(
          AuthRemoteDatasourceImpl(),
          AuthLocalDatasourceImpl(),
        ),
      ),
      child: const ForgetPasswordScreen(),
    ),
    transition: transition,
  ),
  ChildRoute(
    AppRoutes.oTPVerificationScreen,
    child: (_, ModularArguments args) => BlocProvider(
      create: (context) => AuthCubit(
        AuthRepositoryImpl(
          AuthRemoteDatasourceImpl(),
          AuthLocalDatasourceImpl(),
        ),
      ),
      child: OTPVerificationScreen(args.data),
    ),
    transition: transition,
  ),
  ChildRoute(
    AppRoutes.homeLayout,
    child: (_, ModularArguments args) => const HomeLayout(),
    transition: transition,
  ),
  ChildRoute(
    AppRoutes.tCWMediaScreen,
    child: (_, ModularArguments args) => MediaScreen(reels: reels),
    transition: transition,
  ),
  ChildRoute(
    AppRoutes.notificationScreen,
    child: (_, ModularArguments args) => NotificationScreen(),
    transition: transition,
  ),
  ChildRoute(
    AppRoutes.pointsRewardsScreen,
    child: (_, ModularArguments args) => const PointsRewardsScreen(),
    transition: transition,
  ),
  ChildRoute(
    AppRoutes.recommendedCoursesScreen,
    child: (_, ModularArguments args) => const RecommendedCoursesScreen(),
    transition: transition,
  ),
  ChildRoute(
    AppRoutes.myLibraryScreen,
    child: (_, ModularArguments args) => const MyLibraryScreen(),
    transition: transition,
  ),
  ChildRoute(
    AppRoutes.settingsScreen,
    child: (_, ModularArguments args) => const SettingsScreen(),
    transition: transition,
  ),
  ChildRoute(
    AppRoutes.personalDetailsScreen,
    child: (_, ModularArguments args) => BlocProvider(
      create: (context) => ProfileCubit(),
      child: const PersonalDetailsScreen(),
    ),
    transition: transition,
  ),
  ChildRoute(
    AppRoutes.supportScreen,
    child: (_, ModularArguments args) => const SupportScreen(),
    transition: transition,
  ),
  ChildRoute(
    AppRoutes.wishListScreen,
    child: (_, ModularArguments args) => const WishListScreen(),
    transition: transition,
  ),
  ChildRoute(
    AppRoutes.eventScreen,
    child: (_, ModularArguments args) => const EventScreen(),
    transition: transition,
  ),
  ChildRoute(
    AppRoutes.eventCalendarScreen,
    child: (_, ModularArguments args) => const EventCalendarScreen(),
    transition: transition,
  ),
  ChildRoute(
    AppRoutes.coursesScreen,
    child: (_, ModularArguments args) => BlocProvider(
        create: (c) => StudentCourseCubit(StudentCourseRepositoryImpl()),
        child: const CoursesScreen()),
    transition: transition,
  ),
  ChildRoute(
    AppRoutes.paymentsScreen,
    child: (_, ModularArguments args) => const PaymentsScreen(),
    transition: transition,
  ),
  ChildRoute(
    AppRoutes.proccessPayScreen,
    child: (_, ModularArguments args) => const ProccessPayScreen(),
    transition: transition,
  ),
  ChildRoute(
    AppRoutes.newCardScreen,
    child: (_, ModularArguments args) => const NewCardScreen(),
    transition: transition,
  ),

  ChildRoute(
    AppRoutes.courseDetailsScreen,
    child: (_, ModularArguments args) => const CourseDetailsScreen(),
    transition: transition,
  ),
  ChildRoute(
    AppRoutes.liveEventScreen,
    child: (_, ModularArguments args) => LiveEventScreen(
      questions: [
        QuestionModel(
            id: 1,
            question:
                'What are the best techniques to overcome procrastination?'),
        QuestionModel(
            id: 2,
            question:
                'How can I create a daily routine that maximizes productivity?'),
        QuestionModel(
            id: 3,
            question:
                'What tools do you recommend for effective time management?'),
      ],
    ),
    transition: transition,
  ),
  ChildRoute(
    AppRoutes.myCourseScreen,
    child: (_, ModularArguments args) => const MyCourseScreen(),
    transition: transition,
  ),
  ChildRoute(
    AppRoutes.lessonScreen,
    child: (_, ModularArguments args) => LessonScreen(
      lessonModel: args.data,
    ),
    transition: transition,
  ),
  ChildRoute(
    AppRoutes.tasksScreen,
    child: (_, ModularArguments args) => const TasksScreen(),
    transition: transition,
  ),
  ChildRoute(
    AppRoutes.newTaskScreen,
    child: (_, ModularArguments args) =>
        NewTaskScreen(task: args.data as Task?),
    transition: transition,
  ),
  ChildRoute(
    AppRoutes.taskDetailScreen,
    child: (_, ModularArguments args) => TaskDetailScreen(args.data),
    transition: transition,
  ),
  ChildRoute(
    AppRoutes.reelViewScreen,
    child: (_, ModularArguments args) => ReelViewScreen(
      reel: args.data as ReelModel,
    ),
    transition: transition,
  ),
  ChildRoute(
    AppRoutes.createReelPage,
    child: (_, ModularArguments args) => const CreateReelPage(),
    transition: transition,
  ),
  //

  ChildRoute(
    AppRoutes.reelsHistoryPage,
    child: (_, ModularArguments args) => const ReelsHistoryPage(),
    transition: transition,
  ),
  ChildRoute(
    AppRoutes.inboxScreen,
    child: (_, ModularArguments args) => const InboxScreen(),
    transition: transition,
  ),
  ChildRoute(
    AppRoutes.chatScreen,
    child: (_, ModularArguments args) => const ChatScreen(),
    transition: transition,
  ),
  // groups
  ChildRoute(
    AppRoutes.groupsScreen,
    child: (_, ModularArguments args) => const GroupsScreen(),
    transition: transition,
  ),
  ChildRoute(
    AppRoutes.groupChatScreen,
    child: (_, ModularArguments args) => const GroupChatScreen(),
    transition: transition,
  ),
  ChildRoute(
    AppRoutes.newGroupScreen,
    child: (_, ModularArguments args) => const NewGroupScreen(),
    transition: transition,
  ),
  // programmes
  ChildRoute(
    AppRoutes.programmesView,
    child: (_, ModularArguments args) =>BlocProvider(
        create: (c) => StudentCourseCubit(StudentCourseRepositoryImpl()),
        child: const ProgrammesView()),
    transition: transition,
  ),
  // programmeDetails
  ChildRoute(
    AppRoutes.programmeDetails,
    child: (_, ModularArguments args) => ProgrameDetailsView(args.data),
    transition: transition,
  ),
];

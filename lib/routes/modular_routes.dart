// routes/modular_routes.dart
// ignore_for_file: prefer_const_constructors// ignore_for_file: prefer_const_constructors
import 'package:flutter_modular/flutter_modular.dart';
import 'package:modular_interfaces/src/route/modular_arguments.dart';
import 'package:tcw/core/constansts/asset_manger.dart';
import 'package:tcw/features/auth/presentation/pages/forget_password_screen.dart';
import 'package:tcw/features/auth/presentation/pages/logIn_screen.dart';
import 'package:tcw/features/auth/presentation/pages/next_or_back_screen.dart';
import 'package:tcw/features/auth/presentation/pages/on_bording_screens.dart';
import 'package:tcw/features/auth/presentation/pages/splash_screen.dart';
import 'package:tcw/features/auth/presentation/pages/verification_screen.dart';
import 'package:tcw/features/chat/presentation/pages/group_chat_screen.dart';
import 'package:tcw/features/chat/presentation/pages/groups_screen.dart';
import 'package:tcw/features/chat/presentation/pages/inbox_screen.dart';
import 'package:tcw/features/chat/presentation/pages/message_screen.dart';
import 'package:tcw/features/courses/data/models/reel_model.dart';
import 'package:tcw/features/courses/presentation/pages/course_datails_screen.dart';
import 'package:tcw/features/courses/presentation/pages/courses_screen.dart';
import 'package:tcw/features/courses/presentation/pages/lesson_screen.dart';
import 'package:tcw/features/courses/presentation/pages/media_screen.dart';
import 'package:tcw/features/courses/presentation/pages/my_library_screen.dart';
import 'package:tcw/features/courses/presentation/pages/recommended_courses_screen.dart';
import 'package:tcw/features/courses/presentation/pages/tasks_screen.dart';
import 'package:tcw/features/courses/presentation/pages/wish_list_screen.dart';
import 'package:tcw/features/courses/presentation/pages/your_courses_screen.dart';
import 'package:tcw/features/event/data/models/question_model.dart';
import 'package:tcw/features/event/presentation/pages/event_screen.dart';
import 'package:tcw/features/event/presentation/pages/live_event_screen.dart';
import 'package:tcw/features/home/presentation/pages/home_layout_screen.dart';
import 'package:tcw/features/notification/presentation/pages/notification_screen.dart';
import 'package:tcw/features/payment/presentation/pages/payment_screen.dart';
import 'package:tcw/features/points/presentation/pages/points_rewards_screen.dart';
import 'package:tcw/features/setting/presentation/pages/personal_details_screen.dart';
import 'package:tcw/features/setting/presentation/pages/setting_screen.dart';
import 'package:tcw/features/setting/presentation/pages/support_screen.dart';
import 'package:tcw/routes/routes_names.dart';

List<ModularRoute> modularRoutes = <ChildRoute<dynamic>>[
  ChildRoute<dynamic>(
    AppRoutes.start,
    child: (_, ModularArguments args) => const SplashScreen(),
    transition: TransitionType.upToDown,
  ),
  ChildRoute<dynamic>(
    AppRoutes.onboarding,
    child: (_, ModularArguments args) => OnboardingScreen(),
    transition: TransitionType.upToDown,
  ),
  ChildRoute<dynamic>(
    AppRoutes.newOrOldUserScreen,
    child: (_, ModularArguments args) => NextOrBackScreen(),
    transition: TransitionType.upToDown,
  ),
  ChildRoute<dynamic>(
    AppRoutes.loginPage,
    child: (_, ModularArguments args) => const LoginPage(),
    transition: TransitionType.upToDown,
  ),
  ChildRoute<dynamic>(
    AppRoutes.forgotPasswordScreen,
    child: (_, ModularArguments args) => const ForgotPasswordScreen(),
    transition: TransitionType.upToDown,
  ),
  ChildRoute<dynamic>(
    AppRoutes.oTPVerificationScreen,
    child: (_, ModularArguments args) => OTPVerificationScreen(),
    transition: TransitionType.upToDown,
  ),
  ChildRoute<dynamic>(
    AppRoutes.homeLayout,
    child: (_, ModularArguments args) => const HomeLayout(),
    transition: TransitionType.upToDown,
  ),
  ChildRoute<dynamic>(
    AppRoutes.tCWMediaScreen,
    child: (_, ModularArguments args) => TCWMediaScreen(
      reels: [
        Reel(
          thumbnail: AssetManger.reel,
          views: 4,
        ),
        Reel(
          thumbnail: AssetManger.reel,
          views: 4,
        ),
        Reel(
          thumbnail: AssetManger.reel,
          views: 4,
        ),
        Reel(
          thumbnail: AssetManger.reel,
          views: 4,
        ),
      ],
    ),
    transition: TransitionType.upToDown,
  ),
  ChildRoute<dynamic>(
    AppRoutes.notificationScreen,
    child: (_, ModularArguments args) => NotificationScreen(),
    transition: TransitionType.upToDown,
  ),
  ChildRoute<dynamic>(
    AppRoutes.pointsRewardsScreen,
    child: (_, ModularArguments args) => PointsRewardsScreen(
      showPointsTabFirst: args.data ?? true,
    ),
    transition: TransitionType.upToDown,
  ),
  ChildRoute<dynamic>(
    AppRoutes.recommendedCoursesScreen,
    child: (_, ModularArguments args) => RecommendedCoursesScreen(),
    transition: TransitionType.upToDown,
  ),
  ChildRoute<dynamic>(
    AppRoutes.myLibraryScreen,
    child: (_, ModularArguments args) => MyLibraryScreen(),
    transition: TransitionType.upToDown,
  ),
  ChildRoute<dynamic>(
    AppRoutes.settingsScreen,
    child: (_, ModularArguments args) => const SettingsScreen(),
    transition: TransitionType.upToDown,
  ),
  ChildRoute<dynamic>(
    AppRoutes.personalDetailsScreen,
    child: (_, ModularArguments args) => const PersonalDetailsScreen(),
    transition: TransitionType.upToDown,
  ),
  ChildRoute<dynamic>(
    AppRoutes.supportScreen,
    child: (_, ModularArguments args) => const SupportScreen(),
    transition: TransitionType.upToDown,
  ),
  ChildRoute<dynamic>(
    AppRoutes.wishListScreen,
    child: (_, ModularArguments args) => const WishListScreen(),
    transition: TransitionType.upToDown,
  ),
  ChildRoute<dynamic>(
    AppRoutes.eventScreen,
    child: (_, ModularArguments args) => EventScreen(),
    transition: TransitionType.upToDown,
  ),
  ChildRoute<dynamic>(
    AppRoutes.coursesScreen,
    child: (_, ModularArguments args) => CoursesScreen(),
    transition: TransitionType.upToDown,
  ),
  ChildRoute<dynamic>(
    AppRoutes.paymentsScreen,
    child: (_, ModularArguments args) => PaymentsScreen(),
    transition: TransitionType.upToDown,
  ),
  ChildRoute<dynamic>(
    AppRoutes.courseDetailsScreen,
    child: (_, ModularArguments args) => CourseDetailsScreen(),
    transition: TransitionType.upToDown,
  ),
  ChildRoute<dynamic>(
    AppRoutes.liveEventScreen,
    child: (_, ModularArguments args) => LiveEventScreen(
      
       questions: [
        QuestionModel(id: 1, question: "What are the best techniques to overcome procrastination?"),
        QuestionModel(id: 2, question: "How can I create a daily routine that maximizes productivity?"),
        QuestionModel(id: 3, question: "What tools do you recommend for effective time management?"),
      ],
    ),
    transition: TransitionType.upToDown,
  ), 
  ChildRoute<dynamic>(
    AppRoutes.myCourseScreen,
    child: (_, ModularArguments args) => MyCourseScreen(
     
    ),
    transition: TransitionType.upToDown,
  ),
  ChildRoute<dynamic>(
    AppRoutes.lessonScreen,
    child: (_, ModularArguments args) => LessonScreen(
     
      lessonModel: args.data,
    ),
    transition: TransitionType.upToDown,
  ),
  ChildRoute<dynamic>(
    AppRoutes.TasksScreen,
    child: (_, ModularArguments args) => TasksScreen(
    
    ),
    transition: TransitionType.upToDown,
  ),
  ChildRoute<dynamic>(
    AppRoutes.inboxScreen,
    child: (_, ModularArguments args) => InboxScreen(),
    transition: TransitionType.upToDown,
  ),
  ChildRoute<dynamic>(
    AppRoutes.chatScreen,
    child: (_, ModularArguments args) => ChatScreen(
    
    ),
    transition: TransitionType.upToDown,
  ),
  ChildRoute<dynamic>(
    AppRoutes.groupsScreen,
    child: (_, ModularArguments args) => GroupsScreen(),
    transition: TransitionType.upToDown,
  ),
  ChildRoute<dynamic>(
    AppRoutes.groupChatScreen,
    child: (_, ModularArguments args) => GroupChatScreen(
     
    ),
    transition: TransitionType.upToDown,
  ),
];

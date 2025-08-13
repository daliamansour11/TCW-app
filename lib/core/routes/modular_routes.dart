import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'package:modular_interfaces/src/route/modular_arguments.dart';
import '../../features/ai/presentation/pages/ai_screen.dart';
import '../../features/auth/data/datasources/auth_local_datasource_impl.dart';
import '../../features/auth/data/datasources/auth_remote_datasource_impl.dart';
import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/auth/presentation/cubit/auth_cubit.dart';
import '../../features/auth/presentation/pages/forget_password_screen.dart';
import '../../features/auth/presentation/pages/login_screen.dart';
import '../../features/auth/presentation/pages/next_or_back_screen.dart';
import '../../features/auth/presentation/pages/on_bording_screens.dart';
import '../../features/auth/presentation/pages/register_screen.dart';
import '../../features/auth/presentation/pages/reset_password_screen.dart';
import '../../features/auth/presentation/pages/splash_screen.dart';
import '../../features/auth/presentation/pages/verification_screen.dart';
import '../../features/chat/presentation/pages/group_chat_screen.dart';
import '../../features/chat/presentation/pages/groups_screen.dart';
import '../../features/chat/presentation/pages/inbox_screen.dart';
import '../../features/chat/presentation/pages/message_screen.dart';
import '../../features/chat/presentation/pages/new_group_screen.dart';
import '../../features/courses/data/datasources/course_datasource_impl.dart';
import '../../features/courses/data/models/task_model.dart';
import '../../features/courses/data/repositories/course_repository_impl.dart';
import '../../features/courses/data/repositories/student_course_repository_impl.dart';
import '../../features/courses/presentation/cubit/course/courses_cubit.dart';
import '../../features/courses/presentation/cubit/student/student_course_cubit.dart';
import '../../features/courses/presentation/pages/course_datails_screen.dart';
import '../../features/courses/presentation/pages/courses_screen.dart';
import '../../features/courses/presentation/pages/lesson_screen.dart';
import '../../features/courses/presentation/pages/my_library_screen.dart';
import '../../features/courses/presentation/pages/recommended_courses_screen.dart';
import '../../features/event/data/data_source/event_data_source.dart';
import '../../features/event/data/models/event_model.dart';
import '../../features/event/data/repositories/event_repository.dart';
import '../../features/event/presentation/cubit/event_cubit.dart';
import '../../features/event/presentation/pages/subscribe_event_details.dart';
import '../../features/notification/data/data_scource/notification_data_source.dart';
import '../../features/notification/data/repositories/notification_repository.dart';
import '../../features/notification/presentation/cubit/notification_cubit.dart';
import '../../features/payment/presentation/pages/new_card_screen.dart';
import '../../features/payment/presentation/pages/proccess_pay_screen.dart';
import '../../features/profile/presentation/pages/profile_screen.dart';
import '../../features/programmes/data/data_source/program_datasource_impl.dart';
import '../../features/programmes/data/repositories/programs_repository_impl.dart';
import '../../features/programmes/presentation/cubit/program_cubit.dart';

import '../../features/reels/data/models/reel_history_model.dart';
import '../../features/reels/data/repositories/reel_repository_imp.dart';
import '../../features/reels/presentation/cubit/create_reel_cubit.dart';
import '../../features/reels/presentation/cubit/reel_interactions/add_comment_cubit.dart';
import '../../features/reels/presentation/cubit/reel_interactions/get_comment_cubit.dart';
import '../../features/reels/presentation/cubit/reel_interactions/reel_toggle_on_like_cubit.dart';
import '../../features/reels/presentation/cubit/reels_cubit.dart';
import '../../features/tasks/data/data_source/task_data_source_imp.dart';
import '../../features/tasks/data/repositories/course_task_repositories.dart';
import '../../features/tasks/presentation/cubit/course_tasks_cubit.dart';
import '../../features/tasks/presentation/pages/new_task_screen.dart';
import '../../features/tasks/presentation/pages/task_detail_screen.dart';
import '../../features/event/presentation/pages/event_calendar_screen.dart';
import '../../features/programmes/presentation/pages/programe_details_view.dart';
import '../../features/programmes/presentation/pages/programmes_view.dart';
import '../../features/reels/presentation/pages/create_reel_page.dart';
import '../../features/reels/presentation/pages/reel_view_screen.dart';
import '../../features/tasks/presentation/pages/tasks_screen.dart';
import '../../features/courses/presentation/pages/wish_list_screen.dart';
import '../../features/courses/presentation/pages/your_courses_screen.dart';
import '../../features/event/data/models/question_model.dart';
import '../../features/event/presentation/pages/event_screen.dart';
import '../../features/event/presentation/pages/live_event_screen.dart';
import '../../features/home/presentation/pages/home_layout_screen.dart';
import '../../features/notification/presentation/pages/notification_screen.dart';
import '../../features/points/presentation/pages/points_rewards_screen.dart';
import '../../features/reels/data/models/reel_model.dart';
import '../../features/reels/presentation/pages/media_screen.dart';
import '../../features/reels/presentation/pages/reels_history_page.dart';
import '../../features/setting/presentation/pages/personal_details_screen.dart';
import '../../features/setting/presentation/pages/setting_screen.dart';
import '../../features/setting/presentation/pages/support_screen.dart';
import 'app_routes.dart';
import '../../features/profile/presentation/cubit/profile_cubit.dart';

import '../../features/chat/data/chat_data_source/chat_data_source.dart';
import '../../features/chat/data/chat_repo/chat_repositories.dart';
import '../../features/chat/presentation/cubit/_chat_cubit.dart';
import '../../features/courses/data/models/lesson_model.dart';

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
    AppRoutes.registerPage,
    child: (_, ModularArguments args) => BlocProvider(
      create: (context) => AuthCubit(
        AuthRepositoryImpl(
          AuthRemoteDatasourceImpl(),
          AuthLocalDatasourceImpl(),
        ),
      ),
      child: const RegisterScreen(),
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
    child: (_, ModularArguments args) {

      return BlocProvider(
      create: (context) => AuthCubit(
        AuthRepositoryImpl(
          AuthRemoteDatasourceImpl(),
          AuthLocalDatasourceImpl(),
        ),
      ),
      child: OTPVerificationScreen(args.data as String),
 );},
    transition: transition,
  ),
  ChildRoute(
    AppRoutes.homeLayout,
    child: (_, ModularArguments args) => MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => ProgramCubit(ProgramRepositoryImpl(ProgramDatasourceImpl()))..fetchPrograms(),
        ),  BlocProvider(
          create: (_) => NotificationCubit(NotificationRepositoryImp(NotificationDataSourceImpl()))..fetchStudentPushNotification(),
        ),
        BlocProvider(
          create: (_) => StudentCourseCubit(StudentCourseRepositoryImpl()),
        ),
        BlocProvider(
          create: (c) => ReelsCubit(ReelRepositoryImpl()),
        ), BlocProvider(
            create: (c) => AuthCubit(AuthRepositoryImpl(AuthRemoteDatasourceImpl(),AuthLocalDatasourceImpl())),
        ),
        BlocProvider(
        create: (context) => EventCubit(
            EventRepositoryImp(EventDataSourceImpl())
        )..getEvents(),        //
        //
        ),
   BlocProvider(
        create: (context) => ChatCubit(
            ChatRepositoriesImp(ChatDataSourceImp())
        )..fetchConversationList(),        //
        //
        ),   BlocProvider(
        create: (context) => CourseCubit(
            CourseRepositoryImpl(CourseDatasourceImpl())
        )..fetchCourses(),        //
        //
        ),



      ], child: const HomeLayout(),),

    transition: transition,
  ),
  ChildRoute(
    AppRoutes.tCWMediaScreen,
    child: (_, ModularArguments args) => BlocProvider(
        create: (c) => ReelsCubit(ReelRepositoryImpl()),
        child: const MediaScreen()),
    transition: transition,
  ),
  ChildRoute(
    AppRoutes.notificationScreen,
    child: (_, ModularArguments args) => BlocProvider(
      create: (_) => NotificationCubit(NotificationRepositoryImp(NotificationDataSourceImpl()))..fetchStudentPushNotification(),
      child: const         NotificationScreen(),

    ),
    transition: transition,
  ),
  ChildRoute(
    AppRoutes.pointsRewardsScreen,
    child: (_, ModularArguments args) => const PointsRewardsScreen(),
    transition: transition,
  ),
  ChildRoute(
    AppRoutes.recommendedCoursesScreen,
    child: (_, ModularArguments args) => BlocProvider(
      create: (_) => CourseCubit(CourseRepositoryImpl(CourseDatasourceImpl()))..fetchCourses(),
      child: const RecommendedCoursesScreen(),
    ),
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
    child: (_, ModularArguments args) =>MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ProfileCubit()),
        BlocProvider(create: (_) => NotificationCubit(NotificationRepositoryImp(NotificationDataSourceImpl()))),
        BlocProvider(create: (_) => CourseCubit(CourseRepositoryImpl(CourseDatasourceImpl()))),

      ],
      child: const PersonalDetailsScreen(),
    ),
    transition: transition,
  ), ChildRoute(
    AppRoutes.profilePage,
    child: (_, ModularArguments args) => MultiBlocProvider(
providers: [
BlocProvider(create: (_) => ProfileCubit()),
BlocProvider(create: (_) => ProgramCubit(ProgramRepositoryImpl(ProgramDatasourceImpl()))),
BlocProvider(create: (_) => CourseCubit(CourseRepositoryImpl(CourseDatasourceImpl()))),
BlocProvider(create: (_) => StudentCourseCubit(StudentCourseRepositoryImpl())),
BlocProvider(create: (_) => EventCubit(EventRepositoryImp(EventDataSourceImpl()))),
BlocProvider(create: (_) => NotificationCubit(NotificationRepositoryImp(NotificationDataSourceImpl()))),

], child:const ProfileScreen(),),
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
    child: (_, ModularArguments args) => BlocProvider(
      create: (context) => EventCubit(
          EventRepositoryImp(EventDataSourceImpl())
      )..getEvents(),
      child: const EventScreen(),
    ),
    transition: transition,
  ),  ChildRoute(
    AppRoutes.subscribeEventDetailsScreen,
    child: (_, ModularArguments args) => BlocProvider(
      create: (context) => EventCubit(
          EventRepositoryImp(EventDataSourceImpl())
      )..getEvents(),
      child:  EventDetailsScreen(eventItem: args.data as Meeting ),
    ),
    transition: transition,
  ),
  ChildRoute(
    AppRoutes.eventCalendarScreen,
    child: (_, ModularArguments args) => const EventCalendarScreen(),
    transition: transition,
  ),
  ChildRoute(
    AppRoutes.coursesScreen,
    child: (_, ModularArguments args) => MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => CourseCubit(CourseRepositoryImpl(CourseDatasourceImpl())),
        ),
        BlocProvider(
          create: (_) => StudentCourseCubit(StudentCourseRepositoryImpl()),
        ),
      ],
      child:  CoursesScreen(),
    ),
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
    child: (_, ModularArguments args) {
      final courseId = args.data is int ? args.data as int : 0;

      return BlocProvider(
        create: (context) => CourseCubit(CourseRepositoryImpl(CourseDatasourceImpl()))..getCourseLessons(courseId),
        child: CourseDetailsScreen(courseId: courseId),
      );
    },
    transition: transition,
  ),


  ChildRoute(
    AppRoutes.liveEventScreen,
    child: (_, ModularArguments args) {
      final data = args.data as Map<String, dynamic>;
      return LiveEventScreen(
        questions: [
          QuestionModel(
            id: 1,
            question: 'What are the best techniques to overcome procrastination?',
          ),
          QuestionModel(
            id: 2,
            question: 'How can I create a daily routine that maximizes productivity?',
          ),
          QuestionModel(
            id: 3,
            question: 'What tools do you recommend for effective time management?',
          ),
        ],
        meetingUrl: data['meetingUrl'] as String,
        liveId: data['liveId'] as int,
      );
    },
    transition: transition,
  ),
  ChildRoute(
    AppRoutes.myCourseScreen,
    child: (_, ModularArguments args) =>BlocProvider(

        create: (context) => StudentCourseCubit((StudentCourseRepositoryImpl()))..fetchEnrolledCourses(limit: 10, offset: 1),
        child:   const MyCourseScreen()),

    transition: transition,
  ),
  ChildRoute(
    AppRoutes.lessonScreen,
    child: (_, args) {
      final lesson = args.data as LessonModel;

      return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => CourseTasksCubit(CourseTaskRepositoriesImp(TaskDataSourceImp()))..getCourseTasks(lesson.id??0),
          ),   BlocProvider(
              create: (_) => StudentCourseCubit(StudentCourseRepositoryImpl()),
          ),

        ],
        child: LessonScreen(lesson: lesson),
      );
    },
  ),

  ChildRoute(
    AppRoutes.tasksScreen,
    child: (_, ModularArguments args) {
      final int courseId = args.data is int ? args.data as int : 0;

      return    BlocProvider(

          create: (context) => CourseTasksCubit(CourseTaskRepositoriesImp(TaskDataSourceImp()))..getCourseTasks(courseId),
          child:   const TasksScreen());
    },
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
    child: (_, args) {
      final reel = args.data is ReelHistoryModel
          ? Datum.fromHistory(args.data as ReelHistoryModel)
          : args.data as Datum;

      return Builder(
        builder: (context) {
          final reelsCubit = ReelsCubit(ReelRepositoryImpl());

          return MultiBlocProvider(
            providers: [
              BlocProvider(create: (_) => CreateReelCubit(ReelRepositoryImpl())),
              BlocProvider(create: (_) => GetCommentCubit(ReelRepositoryImpl())),
              BlocProvider.value(value: reelsCubit),
              BlocProvider(
                create: (_) =>
                    AddCommentCubit(ReelRepositoryImpl(), reelsCubit),
              ),
              BlocProvider(
                create: (_) =>
                    ReelToggleOnLikeCubit(ReelRepositoryImpl(), reelsCubit),
              ),
            ],
            child: Builder(
              builder: (context) {
                final authCubit = Modular.get<AuthCubit>();
                int userId = 0;

                if (authCubit.state is AuthLoggedIn) {
                  userId = (authCubit.state as AuthLoggedIn).user.id;
                } else if (authCubit.state is AuthRegistered) {
                }

                return WillPopScope(
                  onWillPop: () async {
                    Navigator.of(context).pop(reel);
                    return false;
                  },
                  child: ReelViewScreen(
                    reel: reel,
                    videoUrl: reel.videoUrl ?? '',
                    user_id: userId,
                  ),
                );
              },
            ),
          );
        },
      );
    },
  ),

  ChildRoute(
    AppRoutes.createReelPage,
    child: (_, ModularArguments args) => BlocProvider(
      create: (context) => CreateReelCubit(ReelRepositoryImpl()),
      child: const CreateReelPage(),
    ),),

  ChildRoute(
    AppRoutes.reelsHistoryPage,
    child: (_, ModularArguments args) => const ReelsHistoryPage(),
    transition: transition,
  ),
  ChildRoute(
    AppRoutes.inboxScreen,
    child: (_, ModularArguments args) {
      return
           BlocProvider(
             create: (context) => ChatCubit(ChatRepositoriesImp(ChatDataSourceImp()))
               ..fetchConversationList(  ),
             child:const InboxScreen(),
        );
    },
    transition: transition,
  ),
  ChildRoute(
    AppRoutes.chatScreen,
    child: (_, ModularArguments args) {
    final chatId =args.data as int;
  return    BlocProvider(
        create: (context) => ChatCubit(ChatRepositoriesImp(ChatDataSourceImp()))
          ..fetchConversationMessages(chatId),
      child: ChatScreen(chatId:chatId ),
      );
},
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
    child: (_, ModularArguments args) => 
        GroupChatScreen(liveId: args.data as int,),
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
    child: (_, ModularArguments args) {
      return BlocProvider(
        create: (_) => ProgramCubit(ProgramRepositoryImpl(ProgramDatasourceImpl()))..fetchPrograms(),

        // create: (_) => CourseCubit(CourseRepositoryImpl(CourseDatasourceImpl()))..fetchCourses(),
        child:  ProgrammesView(),
      );
    },
    transition: transition,
  ),


// programmeDetails
  ChildRoute(
    AppRoutes.programmeDetails,
    child: (_, ModularArguments args) {
      final int programId = args.data  as int;

      return BlocProvider(
        create: (context) => ProgramCubit(ProgramRepositoryImpl(ProgramDatasourceImpl()))
          ..fetchProgramDetails(programId),
        child: ProgrameDetailsView(
          programId: programId,
        ),
      );
    },
    transition: transition,
  ),



];

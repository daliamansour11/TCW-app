import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tcw/core/constansts/asset_manger.dart';
import 'package:tcw/core/constansts/context_extensions.dart';
import 'package:tcw/core/theme/app_colors.dart';
import 'package:tcw/features/courses/data/models/course_model.dart';
import 'package:tcw/features/courses/presentation/widgets/course_list.dart';
import 'package:tcw/features/courses/presentation/widgets/courses_vertical_list.dart';
import 'package:tcw/features/event/presentation/widgets/event_slider_widget.dart';
import 'package:tcw/features/home/presentation/widgets/search_widget.dart';
import 'package:tcw/features/home/presentation/widgets/side_menu_widget.dart';
import 'package:tcw/features/home/presentation/widgets/state_item_widget.dart';
import 'package:tcw/features/home/presentation/widgets/user_header_widget.dart';
import 'package:tcw/routes/routes_names.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final List<Map<String, String>> events = [
    {
      'title':
          'Join our live event to master time management and achieve peak productivity!',
      'date': 'Monday, 4 Mar 2025',
      'time': '02.00 - 03.30 PM',
      'image': AssetManger.container,
    },
    {
      'title': 'Boost your leadership skills with expert guidance.',
      'date': 'Tuesday, 5 Mar 2025',
      'time': '03.00 - 04.00 PM',
      'image': AssetManger.ex_1,
    },
    {
      'title': 'Unlock your potential with our exclusive workshop!',
      'date': 'Wednesday, 6 Mar 2025',
      'time': '01.00 - 02.30 PM',
      'image': AssetManger.ex_2,
    },
    {
      'title': 'Enhance your skills with our expert-led training session.',
      'date': 'Thursday, 7 Mar 2025',
      'time': '11.00 - 12.30 PM',
      'image': AssetManger.container,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
      drawer: SideMenu(),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: context.propHeight(32)),
              UserHeader(context: context,
                onTap: () {
                  _scaffoldKey.currentState?.openDrawer();
                },
              ),
              SizedBox(height: context.propHeight(24)),
              _buildStats(),
              SizedBox(height: context.propHeight(24)),
              SearchWidget(context: context),
              SizedBox(height: context.propHeight(24)),
             EventSlider(
                events: events,
              ),
              SizedBox(height: context.propHeight(24)),
              Text('My Courses',
                  style: GoogleFonts.poppins(
                      fontSize: 16, fontWeight: FontWeight.bold)),
              SizedBox(height: context.propHeight(10)),
              CourseListHorizontal(
                courses: [
                  CourseModel(
                    title: 'Lesson 1',
                    imageUrl: AssetManger.ex_1,
                    coachName: 'Amir Ali',
                    coachImageUrl: AssetManger.ex_2,
                    price: 0,
                    lessons: 8,
                    duration: '2h 30m',
                    available: 1,
                    coachRole: 'Instructor',
                  ),
                  CourseModel(
                    title: 'Lesson 2',
                    imageUrl: AssetManger.ex_2,
                    coachName: 'Sara Ali',
                    coachImageUrl: AssetManger.ex_1,
                    price: 0,
                    lessons: 10,
                    duration: '3h 15m',
                    available: 5,
                    coachRole: 'Software Engineer',
                  ),
                ],
             ),
              SizedBox(height: context.propHeight(16)),
              _buildContinueWatching(),
              SizedBox(height: context.propHeight(24)),
              SizedBox(height: context.propHeight(10)),
              CourseListHorizontal(
                courses: [
                  CourseModel(
                    title: 'Lesson 6',
                    imageUrl: AssetManger.ex_1,
                    coachName: 'Ahmed Mohamed',
                    coachImageUrl: AssetManger.ex_2,
                    price: 0,
                    lessons: 12,
                    duration: '2h 20m',
                    available: 10,
                    coachRole: 'Senior Developer',
                  ),
                  CourseModel(
                    title: 'Lesson 7',
                    imageUrl: AssetManger.container,
                    coachName: 'Sara Ali',
                    coachImageUrl: AssetManger.ex_1,
                    price: 0,
                    lessons: 15,
                    duration: '1h 50m',
                    available: 5,
                    coachRole: 'Software Engineer',
                  ),
                  // Add more if needed
                ],
              ),
              SizedBox(height: context.propHeight(24)),
              _buildMyCourses(),
              SizedBox(height: context.propHeight(10)),
              CourseListScreen()
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStats() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        StateItem(
            context: context,
            icon: AssetManger.notification,
            count: '1',
            label: 'Notification',
            onTab: () {
              Modular.to.pushNamed(AppRoutes.notificationScreen);
            }),
        StateItem(
            context: context,
            icon: AssetManger.point,
            count: '100',
            label: 'Points',
            onTab: () {
              Modular.to.pushNamed(
                AppRoutes.pointsRewardsScreen,
              );
            }),
        StateItem(
            context: context,
            icon: AssetManger.rewards,
            count: '2',
            label: 'Rewards',
            onTab: () {
              Modular.to.pushNamed(
                AppRoutes.pointsRewardsScreen,
                arguments: false,
              );
            }),
      ],
    );
  }
  Widget _buildContinueWatching() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('Continue Watching',
            style:
                GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold)),
        CircleAvatar(
          radius: 10,
          backgroundColor: AppColors.primaryColor,
          child: Icon(Icons.arrow_forward_ios, size: 12, color: Colors.white),
        ),
      ],
    );
  }

  Widget _buildMyCourses() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('Your Courses',
            style:
                GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold)),
        GestureDetector(
          onTap: () {
            Modular.to.pushNamed(AppRoutes.myCourseScreen);
          },
          child: Text('See All',
              style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: AppColors.primaryColor)),
        ),
      ],
    );
  }
}

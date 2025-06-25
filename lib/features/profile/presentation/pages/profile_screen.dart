import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tcw/core/shared/shared_widget/custom_button.dart';
import 'package:tcw/core/shared/shared_widget/custom_container.dart';
import 'package:tcw/core/shared/shared_widget/custom_text.dart';
import 'package:tcw/core/shared/shared_widget/search_filter_widget.dart';
import 'package:tcw/core/utils/asset_utils.dart';
import 'package:tcw/core/shared/shared_widget/show_more_tile_widget.dart';
import 'package:tcw/core/theme/app_colors.dart';
import 'package:tcw/features/courses/presentation/widgets/courses_vertical_list.dart';
import 'package:tcw/features/event/presentation/widgets/event_slider_widget.dart';
import 'package:tcw/features/profile/presentation/widgets/hour_chart.dart';
import 'package:tcw/features/profile/presentation/widgets/state_item_widget.dart';
import 'package:tcw/features/profile/presentation/widgets/user_header_widget.dart';
import 'package:tcw/features/reels/presentation/pages/reels_history_page.dart';
import 'package:tcw/core/routes/app_routes.dart';
import 'package:zap_sizer/zap_sizer.dart';
import 'package:zapx/zapx.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

final List<Map> _statsItems = [
  {
    'lable': 'Notification',
    'icon': AssetUtils.notification,
    'count': '1',
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

class _ProfileScreenState extends State<ProfileScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final List<Map<String, String>> events = [
    {
      'title':
          'Join our live event to master time management and achieve peak productivity!',
      'date': 'Monday, 4 Mar 2025',
      'time': '02.00 - 03.30 PM',
      'image': AssetUtils.container,
    },
    {
      'title': 'Unlock your potential with our exclusive workshop!',
      'date': 'Wednesday, 6 Mar 2025',
      'time': '01.00 - 02.30 PM',
      'image': AssetUtils.ex_2,
    },
    {
      'title': 'Enhance your skills with our expert-led training session.',
      'date': 'Thursday, 7 Mar 2025',
      'time': '11.00 - 12.30 PM',
      'image': AssetUtils.container,
    },
  ];

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
              const UserHeader(),
              _buildStats(),
              const SearchFilterWidget(),
              EventSlider(events: events),
              _buildSectionHeader(
                'Reels History',
                trailing: ShowMoreTileWidget(
                  onTab: () => Zap.toNamed(AppRoutes.reelsHistoryPage),
                ),
              ),
              const ReelsHistoryPage(
                showFirstIfAvailable: true,
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
              // TODO
              _buildSectionHeader('Your Programmes',
                  trailing: ShowMoreTileWidget(
                    onTab: () => Zap.toNamed(AppRoutes.programmesView),
                  )),
              const CourseListScreen(),
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: _statsItems
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

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../../core/utils/asset_utils.dart';
import '../../../../core/constansts/context_extensions.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/theme/app_colors.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../event/presentation/pages/event_screen.dart';
import 'home_screen.dart';
import '../../../profile/presentation/pages/profile_screen.dart';
import '../../../reels/presentation/pages/media_screen.dart';
import '../../../reels/presentation/reel_viewmodel.dart';
import 'package:zapx/zapx.dart';

class HomeLayout extends StatefulWidget {
  const HomeLayout({super.key, this.index = 0});
  final int index;

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  late final ReelsViewmodel reelsViewmodel;

  @override
  void initState() {
    super.initState();
    reelsViewmodel = ReelsViewmodel(context);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      reelsViewmodel.fetchReels();


    });
    super.initState();

    selectedIdx = widget.index;
    _pageController = PageController(initialPage: selectedIdx);

    _screens = [
      const HomeScreen(),
      const EventScreen(),
      const  SizedBox(),
      const MediaScreen(
      ),
      const  ProfileScreen(),

];
    _tabs = const [
      _TabItem(
        label: 'Home',
        activeIcon: AssetUtils.home,
        inactiveIcon: AssetUtils.inActiveHome,
      ),
      _TabItem(
        label: 'Events',
        activeIcon: AssetUtils.eventOrange,
        inactiveIcon: AssetUtils.eventGray,
      ),
      _TabItem(
        label: 'AI',
        activeIcon: AssetUtils.chatBot,
        inactiveIcon: AssetUtils.chatBot,
      ),
      _TabItem(
        label: 'TCW media',
        activeIcon: AssetUtils.coursesIcon,
        inactiveIcon: AssetUtils.coursesIcon,
      ),
      _TabItem(
        label: 'Profile',
        iconData: Icons.person_outline,
      ),
    ];

  }


  late PageController _pageController;
  int selectedIdx = 0;

  late final List<Widget> _screens;
  late final List<_TabItem> _tabs;



  @override
  void dispose() {
    _pageController.dispose();
    reelsViewmodel.dispose();

    super.dispose();
  }

  void _onTabTapped(int index) {
    if (index == 2 ) {
      Zap.toNamed( AppRoutes.aiScreen);
      return;
    }
    setState(() => selectedIdx = index);
    _pageController.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: _screens,
      ),
      bottomNavigationBar: AnimatedBottomNavigationBar.builder(
        itemCount: _tabs.length,
        height: context.propHeight(80),
        gapLocation: GapLocation.none,
        notchSmoothness: NotchSmoothness.smoothEdge,
        activeIndex: selectedIdx,
        onTap: _onTabTapped,
        tabBuilder: (index, isActive) {
          final tab = _tabs[index];
          return Padding(
            padding: EdgeInsets.only(top: context.propHeight(20)),
            child: Column(
              children: [
                tab.iconData != null
                    ? Icon(
                        tab.iconData,
                        color: isActive
                            ? AppColors.primaryColor
                            : AppColors.hintTextColor,
                        size: context.propHeight(24),
                      )
                    : Image.asset(
                        isActive ? tab.activeIcon! : tab.inactiveIcon!,
                        color: isActive
                            ? AppColors.primaryColor
                            : AppColors.hintTextColor,
                        width: context.propWidth(24),
                        height: context.propHeight(24),
                      ),
                SizedBox(height: context.propHeight(7)),
                Text(
                  tab.label,
                  style: GoogleFonts.almarai(
                    fontSize: ResponsiveText.responsiveFontSize(context, 12),
                    fontWeight: FontWeight.w400,
                    color: isActive
                        ? AppColors.primaryColor
                        : AppColors.hintTextColor,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _TabItem {
  const _TabItem({
    required this.label,
    this.activeIcon,
    this.inactiveIcon,
    this.iconData,
  });
  final String label;
  final String? activeIcon;
  final String? inactiveIcon;
  final IconData? iconData;
}

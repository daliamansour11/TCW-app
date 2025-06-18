import 'package:flutter/material.dart';
import 'package:tcw/core/constansts/asset_manger.dart';
import 'package:tcw/core/constansts/context_extensions.dart';
import 'package:tcw/core/theme/app_theme.dart';
import 'package:tcw/core/theme/app_colors.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tcw/features/courses/data/models/reel_model.dart';
import 'package:tcw/features/courses/presentation/pages/courses_screen.dart';
import 'package:tcw/features/courses/presentation/pages/media_screen.dart';
import 'package:tcw/features/event/presentation/pages/event_screen.dart';
import 'package:tcw/features/home/presentation/pages/home_screen.dart';

class HomeLayout extends StatefulWidget {
  final int index;

  const HomeLayout({
    super.key,
    this.index = 0,
  });

  @override
  _HomeLayoutState createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  int selectedIdx = 0;
  late PageController _pageController;

  final List<Widget> screens = [];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: widget.index);
    screens.addAll([
      HomeScreen(), 
      EventScreen(),
      CoursesScreen(),
      TCWMediaScreen(
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
    
    ]);
    selectedIdx = widget.index;
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onTabTapped(
    int index,
  ) {
    setState(() {
      selectedIdx = index;
    });
    _pageController.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      backgroundColor: null,
      body: PageView(
        controller: _pageController,
        physics: NeverScrollableScrollPhysics(),
        children: screens,
      ),
      bottomNavigationBar: AnimatedBottomNavigationBar.builder(
        itemCount: 4,
        height: context.propHeight(80),
        gapLocation: GapLocation.none,
        notchSmoothness: NotchSmoothness.smoothEdge,
        tabBuilder: (index, isActive) {
          return Padding(
            padding: EdgeInsets.only(top: context.propHeight(20)),
            child: Column(
              children: [
                Image.asset(
                  index == 0
                      ? isActive
                          ? AssetManger.exploreOrange
                          : AssetManger.exploreGray
                      : index == 1
                          ? isActive
                              ? AssetManger.eventOrange
                              : AssetManger.eventGray
                          : index == 2
                              ? isActive
                                  ? AssetManger.catOrange
                                  : AssetManger.catGray
                              : index == 3
                                  ? isActive
                                      ? AssetManger.mediOrange
                                      : AssetManger.mediGray
                                  : isActive
                                      ? AssetManger.moreOrange
                                      : AssetManger.moreGray,
                  width: context.propWidth(24),
                  height: context.propHeight(24),
                ),
                SizedBox(height: context.propHeight(7)),
                Text(
                  index == 0
                      ? 'Explore'
                      : index == 1
                          ? 'Events'
                          : index == 2
                              ? 'Courses'
                              : index == 3
                                  ? 'TCW media'
                                  : 'More',
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
        activeIndex: selectedIdx,
        onTap: _onTabTapped,
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:tcw/features/home/presentation/home_viewmodel.dart';
import 'package:tcw/features/home/presentation/widgets/home_appbar_widget.dart';
import 'package:tcw/features/home/presentation/widgets/side_menu_widget.dart';
import 'package:tcw/features/reels/presentation/pages/media_screen.dart';
import 'package:tcw/features/reels/presentation/pages/reels_history_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: HomeViewmodel.scaffoldKey,
      appBar:const HomeAppbarWidget(),
      drawer: const SideMenu(),

      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        children: [
          MediaScreen(
            showFirstIfAvailable: true,
            reels: reels,
          )
        ],
      ),
    );
  }
}

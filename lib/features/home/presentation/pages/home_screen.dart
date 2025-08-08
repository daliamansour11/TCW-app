import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:tcw/features/home/presentation/home_viewmodel.dart';
import 'package:tcw/features/home/presentation/widgets/build_section_header.dart';
import 'package:tcw/features/home/presentation/widgets/home_appbar_widget.dart';
import 'package:tcw/features/home/presentation/widgets/side_menu_widget.dart';
import 'package:tcw/features/programmes/presentation/cubit/program_cubit.dart';
import 'package:tcw/features/programmes/presentation/widgets/programme_item_widget.dart';

import 'package:tcw/features/reels/presentation/pages/media_screen.dart';
import 'package:tcw/features/reels/presentation/reel_viewmodel.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
class _HomeScreenState extends State<HomeScreen> {
  late final ReelsViewmodel reelsViewmodel;
  bool _isLoading = true;
  @override
  void initState() {
    super.initState();
    reelsViewmodel = ReelsViewmodel(context);
    reelsViewmodel.fetchReels();
    Timer(Duration(seconds: 12), () {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    });
  }

  @override
  void dispose() {
    reelsViewmodel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: HomeViewmodel.scaffoldKey,
      appBar: const HomeAppbarWidget(),
      drawer: const SideMenu(),
      body:ListView(
            controller: reelsViewmodel.scrollController,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            children: [
              const MediaScreen(
                showFirstIfAvailable: true,
                compactHeight: 53,
              ),
              buildHeader(context),
                  // trailing: ShowMoreTileWidget(
                  //   onTab: () => Zap.toNamed(AppRoutes.programmesView),
                  // )

              BlocBuilder<ProgramCubit, ProgramState>(
                builder: (context, state) {
                  if (state is ProgramLoading) {
                    if (_isLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else {
                      return Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text('Something went wrong or took too long.'),
                            const SizedBox(height: 10),
                            ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  _isLoading = true;
                                });
                                context.read<ProgramCubit>().fetchPrograms();
                                Timer(const Duration(seconds: 12), () {
                                  if (mounted) {
                                    setState(() {
                                      _isLoading = false;
                                    });
                                  }
                                });
                              },
                              child: const Text('Retry'),
                            ),
                          ],
                        ),
                      );
                    }


                } else if (state is ProgramLoaded ||
                      state is ProgramLoadingMore) {
                    final courses = (state is ProgramLoaded)
                        ? (state).programs
                        : context.read<ProgramCubit>().allProgram;
                    if (courses.isEmpty) {
                      return const Center(child: Text('No courses found.'));
                    }
                    return ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: courses.length,
                      itemBuilder: (context, index) {
                        final program = courses[index];
                        return ProgrammeItemWidget(program: program); // Fixed props
                      },
                    );
                  } else if (state is ProgramError) {
                    return Center(child: Text(state.message));
                  }
                  return const SizedBox.shrink();
                },
              ),
            ],
          ));
  }

}

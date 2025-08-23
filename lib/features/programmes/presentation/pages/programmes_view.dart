import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tcw/core/shared/shared_widget/app_bar.dart';
import 'package:tcw/core/shared/shared_widget/search_filter_widget.dart';

import 'package:tcw/features/programmes/presentation/cubit/program_cubit.dart';

import 'package:tcw/features/programmes/presentation/widgets/programme_item_widget.dart';
class ProgrammesView extends StatefulWidget {
  ProgrammesView({super.key});

  @override
  State<ProgrammesView> createState() => _ProgrammesViewState();
}

class _ProgrammesViewState extends State<ProgrammesView> {

  bool  _isLoading = true;

  @override
  void initState() {
    super.initState();
    // Fetch notifications when screen loads
    context.read<ProgramCubit>()..fetchPrograms();
    Timer(const Duration(seconds: 12), () {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    });}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  CustomAppBar(title: 'program'.tr()),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            SearchFilterWidget(
              onChanged: (value) {
                context.read<ProgramCubit>().fetchPrograms(search: value);
              },
            ),
            const SizedBox(height: 16),
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
                              context.read<ProgramCubit>()..fetchPrograms();
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
        ),
      ),
    );
  }
}

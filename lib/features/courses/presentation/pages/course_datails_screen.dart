import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tcw/core/shared/shared_widget/app_bar.dart';
import 'package:tcw/core/shared/shared_widget/custom_button.dart';
import 'package:tcw/core/shared/shared_widget/custom_container.dart';
import 'package:tcw/core/shared/shared_widget/custom_text.dart';
import 'package:tcw/core/shared/shared_widget/riyal_logo.dart';
import 'package:tcw/features/programmes/data/models/program_detail_model.dart';
import 'package:tcw/features/programmes/presentation/cubit/program_cubit.dart';
import 'package:tcw/features/programmes/presentation/widgets/program_expansion_tile_widget.dart';
import 'package:tcw/features/programmes/presentation/widgets/program_subscribe_rounds_widget.dart';
import 'package:tcw/features/programmes/presentation/widgets/program_topbar_details.dart';
import 'package:tcw/core/routes/app_routes.dart';
import 'package:zap_sizer/zap_sizer.dart';
import 'package:zapx/zapx.dart';

class ProgrameDetailsView extends StatefulWidget {
  const ProgrameDetailsView(this.programId, {super.key});

  final int programId;

  @override
  State<ProgrameDetailsView> createState() => _ProgrameDetailsViewState();
}

class _ProgrameDetailsViewState extends State<ProgrameDetailsView> {
  bool  _isLoading = true;

  @override
  void initState() {
    super.initState();
    context.read<ProgramCubit>()..fetchProgramDetails(widget.programId);
    Timer(Duration(seconds: 12), () {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    });}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'TCWTIR'),
      body: BlocBuilder<ProgramCubit, ProgramState>(
        builder: (context, state) {
          print('Current state: $state');
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
                        context.read<ProgramCubit>()..fetchProgramDetails(widget.programId);
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
            }          } else if (state is ProgramDetailLoaded) {
            final details = state.program;
            print('Program loaded: ${details.data}');
            if (details.data == null) {
              return const Center(child: Text('No data available'));
            }
            final isSubscribed = details.data!.isSubscribed;

            return ListView(
              padding: const EdgeInsets.all(10),
              children: [
                if (isSubscribed == true) const CustomText('Round 1'),
                ProgramTopBarDetails(details),
                if (isSubscribed == true)
                  ProgramSubscribeRoundsWidget(details)
                else
                  ProgramUnSubscribeExpansionTileWidget(details),
              ],
            );
          } else if (state is ProgramError) {
            print('Error state: ${state.message}');
            return Center(child: Text(state.message));
          }
          return const SizedBox.shrink();
        },
      ),

      bottomNavigationBar: BlocBuilder<ProgramCubit, ProgramState>(
        builder: (context, state) {
          if (state is ProgramDetailLoaded && state.program.data != null && state.program.data!.isSubscribed == false) {
            final details = state.program;
            return CustomContainer(
              height: 15.h,
              padding: 8,
              child: Row(
                spacing: 5,
                children: [
                  Flexible(
              child: CustomButton(
              title: tr('enroll_now'),
              onPressed: () => Zap.toNamed(AppRoutes.proccessPayScreen),
              backgroundColor: Colors.black,
            ),
          ),
          const SizedBox.shrink(),
                  const RiyalLogo(),
          CustomText(tr('price_format', args: [(details.data?.price ?? 200).toString()]))]),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
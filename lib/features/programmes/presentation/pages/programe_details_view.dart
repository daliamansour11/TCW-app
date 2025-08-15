import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../../core/shared/shared_widget/app_bar.dart';
import '../../../../core/shared/shared_widget/custom_button.dart';
import '../../../../core/shared/shared_widget/custom_container.dart';
import '../../../../core/shared/shared_widget/custom_text.dart';
import '../../../../core/shared/shared_widget/riyal_logo.dart';
import '../cubit/program_cubit.dart';
import '../widgets/program_expansion_tile_widget.dart';
import '../widgets/program_subscribe_rounds_widget.dart';
import '../widgets/program_topbar_details.dart';
import '../../../../core/routes/app_routes.dart';
import 'package:zap_sizer/zap_sizer.dart';
import 'package:zapx/zapx.dart';

class ProgrameDetailsView extends StatefulWidget {
  const ProgrameDetailsView(this.programId, {super.key});
  final int programId;

  @override
  State<ProgrameDetailsView> createState() => _ProgrameDetailsViewState();
}

class _ProgrameDetailsViewState extends State<ProgrameDetailsView> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchProgram();
  }

  void _fetchProgram() {
    context.read<ProgramCubit>().fetchProgramDetails(widget.programId);
    Timer(const Duration(seconds: 12), () {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'program_details'.tr()),
      body: BlocBuilder<ProgramCubit, ProgramState>(
        builder: (context, state) {
          if (state is ProgramLoading) {
            return _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _buildTimeoutRetry();
          } else if (state is ProgramDetailLoaded) {
            final details = state.program;
            if (details.data == null) {
              return Center(child: Text(tr('no_data_available')));
            }

            final isSubscribed = details.data!.isSubscribed;

            return ListView(
              padding: const EdgeInsets.all(10),
              children: [
                if (isSubscribed == true)
                  CustomText(tr('round_1')),
                ProgramTopBarDetails(details),
                if (isSubscribed == true)
                  ProgramSubscribeRoundsWidget(details)
                else
                  ProgramUnSubscribeExpansionTileWidget(details),
              ],
            );
          } else if (state is ProgramError) {
            return Center(child: Text(state.message));
          }
          return const SizedBox.shrink();
        },
      ),
      bottomNavigationBar: BlocBuilder<ProgramCubit, ProgramState>(
        builder: (context, state) {
          if (state is ProgramDetailLoaded &&
              state.program.data != null &&
              state.program.data!.isSubscribed == false) {
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
                      onPressed: () =>
                          Zap.toNamed(AppRoutes.proccessPayScreen),
                      backgroundColor: Colors.black,
                    ),
                  ),
                  const RiyalLogo(),
                  CustomText(
                    'price_format'.tr(namedArgs: {'0': '${details.data?.price ?? 200}'}),
                  ),

                ],
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildTimeoutRetry() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(tr('something_went_wrong')),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              setState(() => _isLoading = true);
              _fetchProgram();
            },
            child: Text(tr('retry')),
          ),
        ],
      ),
    );
  }
}

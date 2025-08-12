
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  const ProgrameDetailsView({required this.programId, super.key});

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
    return BlocBuilder<ProgramCubit, ProgramState>(
      builder: (context, state) {
        String appBarTitle = 'TCWTIR';

        if (state is ProgramDetailLoaded && state.program.data != null) {
          final isSubscribed = state.program.data!.isSubscribed ?? false;
          appBarTitle = isSubscribed? 'TCWTIR' : (state.program.data!.title ?? 'Program Details');
        }

        return Scaffold(
          appBar: CustomAppBar(title: appBarTitle),
          body: Builder(
            builder: (_) {
              if (state is ProgramLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is ProgramDetailLoaded) {
                final details = state.program;
                if (details.data == null) {
                  return const Center(child: Text('No data available'));
                }
                final  isSubscribed = state.program.data?.isSubscribed ?? false;
                return ListView(
                  padding: const EdgeInsets.all(10),
                  children: [
                    if (isSubscribed==true)
                      const CustomText('Round 1'),
                    ProgramTopBarDetails(details),
                    if (isSubscribed==true)
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
          bottomNavigationBar: (state is ProgramDetailLoaded && state.program.data != null&& state.program.data?.isSubscribed==false)

              ?
              CustomContainer(
            height: 15.h,
            padding: 8,
            child: Row(
              spacing: 5,
              children: [
                Flexible(
                  child: CustomButton(
                    title: 'Enroll Now',
                    onPressed: () => Zap.toNamed(AppRoutes.proccessPayScreen),
                    backgroundColor: Colors.black,
                  ),
                ),
                const SizedBox.shrink(),
                const RiyalLogo(),
                CustomText('${state.program.data?.price ?? 200} SAR'),
              ],
            ),
          ):const SizedBox.shrink()
        );
      },
    );
  }


}
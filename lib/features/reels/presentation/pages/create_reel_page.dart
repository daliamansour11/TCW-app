import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tcw/core/routes/app_routes.dart';
import 'package:tcw/core/shared/shared_widget/app_bar.dart';
import 'package:tcw/core/shared/shared_widget/custom_button.dart';
import 'package:tcw/core/shared/shared_widget/custom_icon_dialog.dart';
import 'package:tcw/core/shared/shared_widget/custom_text_form_field.dart';
import 'package:tcw/core/shared/shared_widget/custom_text.dart';
import 'package:tcw/features/reels/presentation/pages/widgets/reel_add_video_widget.dart';
import 'package:tcw/features/reels/presentation/pages/widgets/reel_earn_points_widget.dart';
import 'package:tcw/features/reels/presentation/pages/widgets/reel_select_options_widget.dart';
import 'package:tcw/features/reels/presentation/reel_viewmodel.dart';
import 'package:tcw/features/reels/presentation/cubit/create_reel_cubit.dart';
import 'package:zapx/zapx.dart';

class CreateReelPage extends StatefulWidget {
  const CreateReelPage({
    super.key,
    this.isEditing = false,
    this.reelId,
    this.initialCaption,
  });

  final bool isEditing;
  final int? reelId;
  final String? initialCaption;

  @override
  State<CreateReelPage> createState() => _CreateReelPageState();
}

class _CreateReelPageState extends State<CreateReelPage> {
  late final ReelsViewmodel viewModel;
  late TextEditingController _captionController;
  File? _selectedVideo;

  @override
  void initState() {
    super.initState();
    viewModel = ReelsViewmodel(context);
    _captionController =
        TextEditingController(text: widget.initialCaption ?? '');
  }

  @override
  void dispose() {
    _captionController.dispose();
    super.dispose();
  }

  void _handleVideoSelected(File video) {
    setState(() {
      _selectedVideo = video;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CreateReelCubit, CreateReelState>(
      listener: (context, state) {
        if (state is CreateReelLoading) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (_) => const Center(child: CircularProgressIndicator()),
          );
        } else if (state is CreateReelSuccess) {
          Navigator.pop(context); // close loading dialog

          if (widget.isEditing) {
            // Navigate directly to Reel View after editing
            Zap.toNamed(
              AppRoutes.reelViewScreen,
              arguments: {'reelId': widget.reelId},
            );
          } else {
            // Show success dialog for new reel
            customIconDialog(
              context,
              title: 'reel.post_success'.tr(),
              subTitle: 'reel.earned_points'.tr(),
              buttons: CustomIconDialogButtons(
                secondTitle: 'reel.watch_my_reel'.tr(),
                firstOnPressed: () => Zap.toNamed(AppRoutes.pointsRewardsScreen),
                secondOnPressed: () => Zap.toNamed(AppRoutes.tCWMediaScreen),
                firstTitle: 'reel.check_points'.tr(),
              ),
            );
          }
        } else if (state is CreateReelError) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      child: Scaffold(
        appBar: CustomAppBar(
          title: widget.isEditing
              ? 'reel.edit_caption'.tr()
              : 'reel.create_reel'.tr(),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const ReelEarnPointsWidget(),
              const SizedBox.shrink(),
              if (!widget.isEditing)
                ReelAddVideoWidget(
                  onVideoSelected: _handleVideoSelected,
                  selectedVideo: _selectedVideo,
                ),
              const SizedBox.shrink(),
              CustomText('reel.post_details'.tr()),
              const SizedBox(height: 10),
              CustomTextField(
                controller: _captionController,
                hintText: 'reel.describe_hint'.tr(),
                maxLines: 5,
                borderColor: Colors.grey.withValues(alpha: 0.5),
              ),
              const SizedBox.shrink(),
              CustomText('reel.visibility'.tr()),
              const ReelSelectOptionsWidget(),
            ],
          ),
        ),
        bottomNavigationBar: Container(
          padding: const EdgeInsets.all(10),
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 20,
            children: [
              Flexible(
                child: OutlinedButton(
                  onPressed: Zap.back,
                  child: CustomText('common.cancel'.tr()),
                ),
              ),
              Flexible(
                child: BlocBuilder<CreateReelCubit, CreateReelState>(
                  builder: (context, state) {
                    final isLoading = state is CreateReelLoading;
                    return CustomButton(
                      onPressed: () {
                      if (isLoading) return; // prevent action while loading

                      if (!widget.isEditing && _selectedVideo == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('reel.select_video_error'.tr())),
                        );
                        return;
                      }
                      if (widget.isEditing) {
                        viewModel.updateReelCaption(
                          reelId: widget.reelId!,
                          caption: _captionController.text,
                        );
                      } else {
                        viewModel.createReel(
                          caption: _captionController.text.isNotEmpty
                              ? _captionController.text
                              : null,
                          video: _selectedVideo!,
                        );
                      }
                    },

                    removeWidth: true,
                      backgroundColor: Colors.black,
                      title: isLoading
                          ? 'common.saving'.tr()
                          : widget.isEditing
                          ? 'common.save_changes'.tr()
                          : 'reel.post_button'.tr(),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

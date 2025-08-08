import 'dart:io';
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
            builder: (context) =>
                const Center(child: CircularProgressIndicator()),
          );
        } else if (state is CreateReelSuccess) {
          Navigator.pop(context); // Close loading dialog

          if (widget.isEditing) {
            customIconDialog(
              context,
              title: 'Caption Updated Successfully',
              subTitle: '!',
              buttons: CustomIconDialogButtons(
                secondTitle: 'Watch My Reel',
                firstOnPressed: () {
                  Zap.back(); // just close dialog
                },
                secondOnPressed: () {
                  Zap.toNamed(
                    AppRoutes.reelViewScreen,
                    arguments: {
                      'reelId': widget.reelId,
                    },
                  );
                },
                firstTitle: 'Close',
              ),
            );
          } else {
            customIconDialog(
              context,
              title: 'Reel Posted Successfully',
              subTitle:
                  'You’ve earned 500 points — keep going, more rewards await!',
              buttons: CustomIconDialogButtons(
                secondTitle: 'Watch My Reel',
                firstOnPressed: () {
                  Zap.toNamed(AppRoutes.pointsRewardsScreen);
                },
                secondOnPressed: () {
                  Zap.toNamed(AppRoutes.tCWMediaScreen);
                },
                firstTitle: 'Check My Points',
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
          title: widget.isEditing ? 'Edit Caption' : 'Create A Reel',
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
              const CustomText(
                'Post Details',
              ),
              const SizedBox(height: 10),
              CustomTextField(
                controller: _captionController,
                hintText: 'Describe your Reel..',
                maxLines: 5,
                borderColor: Colors.grey.withValues(alpha: 0.5),
              ),
              const SizedBox.shrink(),
              const CustomText('Who can see it'),
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
                    onPressed: Zap.back, child: const CustomText('Cancel')),
              ),
              Flexible(
                child: CustomButton(
                  onPressed: () {
                    if (!widget.isEditing && _selectedVideo == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Please select a video')),
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
                  title: widget.isEditing ? 'Save Changes' : 'Post Reel',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

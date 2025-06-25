import 'package:flutter/material.dart';
import 'package:tcw/core/shared/shared_widget/app_bar.dart';
import 'package:tcw/core/shared/shared_widget/custom_button.dart';
import 'package:tcw/core/shared/shared_widget/custom_text_form_field.dart';
import 'package:tcw/core/shared/shared_widget/custom_text.dart';
import 'package:tcw/features/reels/presentation/reel_viewmodel.dart';
import 'package:tcw/features/reels/presentation/widgets/reel_add_video_widget.dart';
import 'package:tcw/features/reels/presentation/widgets/reel_earn_points_widget.dart';
import 'package:tcw/features/reels/presentation/widgets/reel_select_options_widget.dart';
import 'package:zapx/zapx.dart';

class CreateReelPage extends StatefulWidget {
  const CreateReelPage({super.key});

  @override
  State<CreateReelPage> createState() => _CreateReelPageState();
}

class _CreateReelPageState extends State<CreateReelPage> {
  late final ReelViewmodel viewmodel;
  @override
  void initState() {
    super.initState();
    viewmodel = ReelViewmodel(context);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Create A Reel'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Column(
          spacing: 10,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ReelEarnPointsWidget(),
            const SizedBox.shrink(),
            const ReelAddVideoWidget(),
            const SizedBox.shrink(),
            const CustomText('Post Details'),
            CustomTextField(
              hintText: 'Describe your Reel..',
              maxLines: 5,
              borderColor: Colors.grey.withValues(alpha: 0.5),
            ),
            const SizedBox.shrink(),
            const CustomText('Who can see it'),
            const ReelSelectOptionsWidget()
          ],
        ),
      ),
      // two buttons
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(10),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 20,
            children: [
              Flexible(
                  child: OutlinedButton(
                onPressed: Zap.back,
                child: const CustomText('Cancel'),
              )),
              Flexible(
                child: CustomButton(
                  onPressed:viewmodel.onPostReel,
                  removeWidth: true,
                  backgroundColor: Colors.black,
                  title: 'Post Reel',
                ),
              ),
            ]),
      ),
    );
  }
}

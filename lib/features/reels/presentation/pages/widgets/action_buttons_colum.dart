import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tcw/core/utils/asset_utils.dart';
import 'package:tcw/features/reels/data/models/reel_model.dart';
import 'package:tcw/features/reels/data/repositories/reel_repository_imp.dart';
import 'package:tcw/features/reels/presentation/cubit/reel_interactions/add_comment_cubit.dart';
import 'package:tcw/features/reels/presentation/cubit/reel_interactions/get_comment_cubit.dart';
import 'package:tcw/features/reels/presentation/cubit/reels_cubit.dart';
import 'package:tcw/features/reels/presentation/pages/widgets/build_action_button.dart';
import 'package:tcw/features/reels/presentation/pages/widgets/comment_bottom_sheet_widget.dart';
import 'package:tcw/features/reels/presentation/pages/widgets/like_button.dart';
import 'package:tcw/features/reels/presentation/pages/widgets/pop_menu_button.dart';

class ActionButtonsColumn extends StatefulWidget {
  final Datum reel;
  final bool isLiked;
  final int likesCount;
  final int commentCount;
  final int currentUserId;
  final Function(bool, int) onLikeToggled;
  final Function(int) onCommentAdded;

  const ActionButtonsColumn({
    super.key,
    required this.reel,
    required this.isLiked,
    required this.likesCount,
    required this.commentCount,
    required this.onLikeToggled,
    required this.onCommentAdded,
    required this.currentUserId,
  });

  @override
  State<ActionButtonsColumn> createState() => _ActionButtonsColumnState();
}

class _ActionButtonsColumnState extends State<ActionButtonsColumn> {
  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          LikeButton(
            key: ValueKey(
                '${widget.reel.id}_${widget.isLiked}_${widget.likesCount}'),
            reelId: widget.reel.id!,
            isInitiallyLiked: widget.isLiked,
            initialLikesCount: widget.likesCount,
          ),
          const SizedBox(height: 25),
          buildActionButton(
            icon: AssetUtils.commentIcon,
            label: widget.commentCount.toString(),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (context) {
                  final repository = ReelRepositoryImpl();
                  return MultiBlocProvider(
                    providers: [
                      BlocProvider(create: (_) => AddCommentCubit(repository,ReelsCubit(ReelRepositoryImpl()))),
                      BlocProvider(
                        create: (_) => GetCommentCubit(repository)
                          ..getComments(widget.reel.id!),
                      ),
                    ],
                    child: CommentBottomSheet(
                      reelId: widget.reel.id!,
                      onCommentAdded: (newCount) {
                        widget.onCommentAdded(newCount);
                      },
                    ),
                  );
                },
              );
            },
          ),
          const SizedBox(height: 25),
          buildActionButton(
            icon: AssetUtils.shareIcon,
            label: 'reel.share'.tr()
          ),
          const SizedBox(height: 25),
          //
          // buildActionButton(
          //   icon: Icons.more_horiz,
          //   label: '',
          // ),
          PopMenuButton(
            reelModel: widget.reel,
            currentUserId: widget.reel.user!.id!,
          ),

        ]);
  }
}
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tcw/core/apis/api_response.dart';
import 'package:tcw/core/shared/shared_widget/custom_icon_dialog.dart';
import 'package:tcw/features/reels/data/models/reel_interactions_response_model.dart';
import 'package:tcw/features/reels/data/models/reel_model.dart';
import 'package:tcw/features/reels/presentation/cubit/create_reel_cubit.dart' hide CreateReelState;
import 'package:tcw/features/reels/presentation/cubit/reel_interactions/add_comment_cubit.dart';
import 'package:tcw/features/reels/presentation/cubit/reel_interactions/get_comment_cubit.dart';
import 'package:tcw/features/reels/presentation/cubit/reel_interactions/reel_toggle_on_like_cubit.dart';

import 'cubit/reels_cubit.dart';

class ReelViewmodel {
  ReelViewmodel(this.context);
  BuildContext context;
  static final GlobalKey<ScaffoldState> scaffoldKey =
  GlobalKey<ScaffoldState>();

  /// create reel
  void onPostReel() {
    customIconDialog(
      context,
      title: 'Reel Posted Successfully',
      subTitle: 'You’ve earned 500 points — keep going, more rewards await!',
      buttons: CustomIconDialogButtons(
        secondTitle: 'Watch My Reel',
        firstOnPressed: () {},
        secondOnPressed: () {},         firstTitle: 'Check My Points',

      ),
    );
  }
}


class ReelsViewmodel {
  ReelsViewmodel(this.ctx);

  final BuildContext ctx;
  final int limit = 20;
  int page = 1;
  bool hasMore = true;

  final ScrollController scrollController = ScrollController();
  final ValueNotifier<List<Datum>> reelsNotifier = ValueNotifier([]);

  ReelsCubit get reelCubit => ctx.read<ReelsCubit>();

  void init() {
    scrollController.addListener(_scrollListener);
    fetchReels(reset: true);
  }

  void dispose() {
    scrollController.removeListener(_scrollListener);
    scrollController.dispose();


    reelsNotifier.dispose();
  }

  void _scrollListener() {
    if (scrollController.position.pixels >=
        scrollController.position.maxScrollExtent - 200) {
      if (hasMore && ctx
          .read<ReelsCubit>()
          .state is! ReelsLoadingMore) {
        page++;
        fetchReels(loadMore: true);
      }
    }
  }

  Future<void> fetchReels({bool reset = false, bool loadMore = false}) async {
    if (reset) {
      page = 1;
      hasMore = true;
      await reelCubit.fetchReels(limit: limit, offset: page, loadMore: false);
    } else {
      await reelCubit.fetchReels(
          limit: limit, offset: page, loadMore: loadMore);
    }

    if (!ctx.mounted) return;
    final state = ctx
        .read<ReelsCubit>()
        .state;

    if (state is ReelsLoaded) {
      hasMore = state.hasMore;

      if (state is ReelsLoaded) {
        hasMore = state.hasMore;

        final newReels = state.reels.expand((r) => r.data).toList(); // ← هنا المهم

        if (reset) {
          reelsNotifier.value = newReels;
        } else {
          reelsNotifier.value = [
            ...reelsNotifier.value,
            ...newReels,
          ];
        }
      }
}
    }

  // Future<void> incrementReelView({required int reelId}) async {
  //   try {
  //     await _reelRepository.incrementReelView(reelId: reelId);
  //   } catch (e) {
  //     debugPrint("Error incrementing view count: $e");
  //   }
  // }
  Future<ApiResponse<ReelsInteractionsResonseModel>> toggleOnReelLike(
      int reelId, bool currentLikeStatus) async {
    try {
      final result = await ctx.read<ReelToggleOnLikeCubit>().toggleOnReelLike(
        reelId: reelId,
        oldIsLiked: currentLikeStatus,
      );

      if (result.data != null) {
        final index = reelsNotifier.value.indexWhere((r) => r.id == reelId);
        if (index != -1) {
          final updated = reelsNotifier.value[index].copyWith(
            isLiked: result.data?.isLiked,
            likesCount: result.data?.likesCount,
          );
          reelsNotifier.value[index] = updated;
          reelsNotifier.notifyListeners();
        }
      }

      return result;
    } catch (e) {
      debugPrint('Error toggling like: $e');
      rethrow;
    }
  }


//create reel
  void createReel({String? caption, required File video})async {
    try {
      if (!video.existsSync()) {
        ScaffoldMessenger.of(ctx).showSnackBar(
          const SnackBar(content: Text('Please select a valid video file')),
        );
        return;
      }
      await ctx.read<CreateReelCubit>().createReel(
          caption: caption, video: video);
    } catch (e) {
      debugPrint('Error toggling like: $e');
    }
  }
  //updatreel caption
  Future<void> updateReelCaption({required String caption, required reelId, }) async {
    try {

      await ctx.read<CreateReelCubit>().updateReelCaption(
          caption: caption, reelId:reelId,  );
    } catch (e) {
      debugPrint('Error updating caption: $e');
    }
  }
// delete reel
  Future<void> deleteReel(int reelId) async {
    try{
    await ctx.read<CreateReelCubit>().deleteReel(
        reelId );
    } catch (e) {
      debugPrint('Error updating caption: $e');
    }
  }

    //add comment
    void addComment({required int reelId, required String content}) {

      try {
         ctx.read<AddCommentCubit>().addComment(reelId,content);
      } catch (e) {
        debugPrint('Error toggling like: $e');
      }
}
//get comment

  Future getReelComment({required int reelId})async {

    try {
    await  ctx.read<GetCommentCubit>().getComments(reelId);
    } catch (e) {
      debugPrint('Error getting comment: $e');
    }
  }
}
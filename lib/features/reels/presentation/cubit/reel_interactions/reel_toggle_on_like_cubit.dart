import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tcw/core/apis/api_response.dart';
import 'package:tcw/features/reels/data/models/reel_interactions_response_model.dart';
import 'package:tcw/features/reels/data/repositories/reel_repository.dart';
import 'package:tcw/features/reels/presentation/cubit/reels_cubit.dart';

part 'reel_toggle_on_like_state.dart';
class ReelToggleOnLikeCubit extends Cubit<ToggleLikeState> {
  final ReelsRepository repository;

  final ReelsCubit reelsCubit;

  ReelToggleOnLikeCubit(this.repository, this.reelsCubit)
      : super(ToggleLikeInitial());

  Future<ApiResponse<ReelsInteractionsResonseModel>> toggleOnReelLike({
    required int reelId,
    required bool oldIsLiked,
  }) async {
    try {
      emit(ToggleLikeLoading(reelId));

      final response = await repository.toggleLikeOnReel(reelId);

      if (response.data != null) {
        final newIsLiked = response.data!.isLiked ?? !oldIsLiked;

        final oldCount = reelsCubit.getReelById(reelId)?.likesCount ?? 0;
        final newLikesCount =
            response.data?.likesCount ?? (newIsLiked ? oldCount + 1 : oldCount - 1);

        reelsCubit.updateReelStats(
          reelId: reelId,
          isLiked: newIsLiked,
          likesCount: newLikesCount,
        );

        emit(ToggleLikeSuccess(
          reelId: reelId,
          isLiked: !oldIsLiked,
          likesCount: oldIsLiked ? oldCount - 1 : oldCount + 1,
        ));

      }


      return response;
    } catch (e) {
      final errorResponse = ApiResponse<ReelsInteractionsResonseModel>(
        message: 'Something went wrong: ${e.toString()}',
        mapData: {},
        statusCode: 200,
      );

      emit(ToggleLikeError(
        reelId: reelId,
        message: errorResponse.message!,
      ));

      return errorResponse;
    }
  }


}

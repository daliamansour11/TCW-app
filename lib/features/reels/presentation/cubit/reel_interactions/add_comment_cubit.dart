import 'package:bloc/bloc.dart';
import 'package:tcw/features/reels/data/models/add_comment_response_model.dart';
import 'package:tcw/features/reels/data/repositories/reel_repository.dart';
import 'package:tcw/features/reels/presentation/cubit/reels_cubit.dart';

part 'add_comment_state.dart';
class AddCommentCubit extends Cubit<AddCommentState> {
  final ReelsRepository repository;
  final ReelsCubit reelsCubit;

  AddCommentCubit(this.repository, this.reelsCubit)
      : super(AddCommentInitial());

  Future<void> addComment(int reelId, String content) async {
    emit(AddCommentLoading());
    try {
      final response = await repository.addCommentOnReel(reelId, content);

      if (response.isSuccess && response.data != null) {
        final newCount = response.data!.commentsCount ?? 0;

        reelsCubit.updateReelStats(
          reelId: reelId,
          commentsCount: newCount,
        );

        emit(AddCommentSuccess(
          newComment: response.data!,
          newCommentsCount: newCount,
        ));
      } else {
        emit(AddCommentError(response.message ?? 'Failed to add comment'));
      }
    } catch (e) {
      emit(AddCommentError('Failed to add comment: ${e.toString()}'));
    }
  }
}

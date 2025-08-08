import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tcw/features/reels/data/models/comment_model.dart';
import 'package:tcw/features/reels/data/repositories/reel_repository.dart';

part 'get_comment_state.dart';

class GetCommentCubit extends Cubit<GetCommentsState> {
  GetCommentCubit(this._repository) : super(GetCommentsInitial());
  final ReelsRepository _repository;

  Future<void> getComments(int reelId) async {
    emit(GetCommentsLoading());

    try {
      final response = await _repository.getCommentsForReel(reelId: reelId);
      if (response.data == null) {
        emit(GetCommentsLoaded(CommentModel(
          currentPage: 1,
          data: [],
          firstPageUrl: '',
          from: 0,
          lastPage: 1,
          lastPageUrl: '',
          links: [],
          nextPageUrl: null,
          path: '',
          perPage: 10,
          prevPageUrl: null,
          to: 0,
          total: 0,
        )));
      } else {
        emit(GetCommentsLoaded(response.data!));
      }
    } catch (e) {
      emit(GetCommentsError(e.toString()));
    }
  }
}

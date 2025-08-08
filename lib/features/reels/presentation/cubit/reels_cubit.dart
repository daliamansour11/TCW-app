import 'package:bloc/bloc.dart';
import 'package:tcw/features/reels/data/models/reel_response.dart';
import 'package:tcw/features/reels/data/repositories/reel_repository.dart';

import '../../data/models/reel_model.dart';
import '../../data/repositories/reel_repository_imp.dart';

part 'reels_state.dart';

class ReelsCubit extends Cubit<ReelsState> {
  ReelsCubit(this.reelRepository) : super(ReelsInitial());

  final ReelsRepository reelRepository;

  List<ReelModel> allReels = [];

  Future<void> fetchReels({int limit = 10, int offset = 1, String? search,
    bool loadMore = false,}) async {
    if (loadMore) {
      emit(ReelsLoadingMore());
    } else {
      emit(ReelsLoading());
      allReels.clear();
    }
    final result = await reelRepository.getReels(
      limit: limit,
      offset: offset,
    );
    print('📡 number of reels Fetched ${result.data!.length} reels');

    print('number of reels Fetched ${result.data?.length ?? 0} reels');
    if (result.isSuccess) {
      if (loadMore) {
        allReels.addAll(result.data ?? []);
      } else {
        allReels = result.data ?? [];
      }
      emit(ReelsLoaded(
        allReels,
        hasMore: (result.data?.length ?? 0) == limit,
      ));
    } else {
      emit(ReelsError(result.message ?? 'Failed to load reels'));
    }
  }

  void updateReelStats({
    required int reelId,
    bool? isLiked,
    int? likesCount,
    int? commentsCount,
    int? viewsCount,
  }) {
    final newReels = allReels.map((reelModel) {
      final newData = reelModel.data.map((reel) {
        if (reel.id == reelId) {
          return reel.copyWith(
            isLiked: isLiked,
            likesCount: likesCount,
            commentsCount: commentsCount,
            viewsCount: viewsCount ?? reel.viewsCount,
          );
        }
        return reel;
      }).toList();
      return reelModel.copyWith(data: newData);
    }).toList();

    allReels = newReels;
    if (state is ReelsLoaded) {
      emit(ReelsLoaded(allReels, hasMore: (state as ReelsLoaded).hasMore));
    }
  }

  void updateReelCaption({
    required int reelId,
    required String newCaption,
  }) {
    final newReels = allReels.map((reelModel) {
      final newData = reelModel.data.map((reel) {
        if (reel.id == reelId) {
          return reel.copyWith(caption: newCaption);
        }
        return reel;
      }).toList();
      return reelModel.copyWith(data: newData);
    }).toList();

    allReels = newReels;
    if (state is ReelsLoaded) {
      emit(ReelsLoaded(allReels, hasMore: (state as ReelsLoaded).hasMore));
    }
  }

  Datum? getReelById(int reelId) {
    for (final page in allReels) {
      for (final reel in page.data) {
        if (reel.id == reelId) {
          return reel;
        }
      }
    }
    return null;
  }}
  //
  // Future<void> fetchSpecificReel(int reelId) async {
//     emit(state.copyWith(isLoading: true, error: null));
//
//     final response = await reelRepository.getSpecificReel(reelId);
//     if (response.isSuccess && response.data != null) {
//       final updatedReel = response.data!;
//       emit(state.copyWith(reel: updatedReel, isLoading: false));
//     } else {
//       emit(state.copyWith(
//         error: response.message ?? 'حدث خطأ أثناء تحميل الريل',
//         isLoading: false,
//       ));
//   //   }
//   // }
//
// }
// void updateReelLikeStatus({
//   required int reelId,
//   required bool isLiked,
//   required int newLikesCount,
// }) {
//   final currentList = state.reels;
//   final index = currentList.indexWhere((reel) => reel.id == reelId);
//   if (index != -1) {
//     final updatedReel = currentList[index].copyWith(
//       isLiked: isLiked,
//       likesCount: newLikesCount,
//     );
//     final updatedList = List<Datum>.from(currentList)
//       ..[index] = updatedReel;
//     emit(state.copyWith(reels: updatedList));
//   }




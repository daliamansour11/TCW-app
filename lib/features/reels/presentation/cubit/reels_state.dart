part of 'reels_cubit.dart';

abstract class ReelsState  {
  const ReelsState();

 
}
class ReelsInitial extends ReelsState {}

class ReelsLoading extends ReelsState {}

class ReelsLoadingMore extends ReelsState {}


class ReelsLoaded extends ReelsState {
  ReelsLoaded(this.reels, {this.hasMore = true});
  final List<ReelModel> reels;
  final bool hasMore;
}


class ReelsError extends ReelsState {
  ReelsError(this.message);
  final String message;
}

class ReelDetailsLoaded extends ReelsState {
  final Datum reel;
  final bool isLoading;
  final String? error;

  const ReelDetailsLoaded({
    required this.reel,
    this.isLoading = false,
    this.error,
  });

  ReelDetailsLoaded copyWith({
    Datum? reel,
    bool? isLoading,
    String? error,
  }) {
    return ReelDetailsLoaded(
      reel: reel ?? this.reel,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}




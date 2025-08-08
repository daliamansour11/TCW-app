part of 'reel_toggle_on_like_cubit.dart';

@immutable
// toggle_like_state.dart

@immutable
sealed class ToggleLikeState {
  const ToggleLikeState({this.reelId});
  final int? reelId;
}

final class ToggleLikeInitial extends ToggleLikeState {}

final class ToggleLikeLoading extends ToggleLikeState {
  const ToggleLikeLoading(int reelId) : super(reelId: reelId);
}

final class ToggleLikeSuccess extends ToggleLikeState {

  const ToggleLikeSuccess({
    required int reelId,
    required this.likesCount,
    required this.isLiked,

  }) : super(reelId: reelId);
  final int likesCount;
  final bool isLiked;
}

final class ToggleLikeError extends ToggleLikeState {

  const ToggleLikeError({
    required int reelId,
    required this.message,
  }) : super(reelId: reelId);
  final String message;
}
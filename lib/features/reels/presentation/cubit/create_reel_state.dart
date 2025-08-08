part of 'create_reel_cubit.dart';

sealed class CreateReelState {}

final class CreateReelInitial extends CreateReelState {}




final class CreateReelLoading extends CreateReelState {}

final class CreateReelSuccess extends CreateReelState {
  CreateReelSuccess(this.response);
  final ReelsResponse response;
}

final class CreateReelError extends CreateReelState {
  CreateReelError(this.message);

  final String message;
}
class ReelActionsInitial extends CreateReelState {}

class ReelActionsLoading extends CreateReelState {}

class ReelUpdateSuccess extends CreateReelState {}

class ReelDeleteSuccess extends CreateReelState {}

class ReelActionsError extends CreateReelState {
  final String message;

  ReelActionsError(this.message);
}
part of 'get_comment_cubit.dart';

@immutable
sealed class GetCommentState {}

final class GetCommentInitial extends GetCommentState {}


abstract class GetCommentsState {
  @override
  List<Object?> get props => [];
}

class GetCommentsInitial extends GetCommentsState {}

class GetCommentsLoading extends GetCommentsState {}

class GetCommentsLoaded extends GetCommentsState {

  GetCommentsLoaded(this.comments);
  final CommentModel comments;

  @override
  List<Object?> get props => [comments];
}

class GetCommentsError extends GetCommentsState {

  GetCommentsError(this.message);
  final String message;

  @override
  List<Object?> get props => [message];
}



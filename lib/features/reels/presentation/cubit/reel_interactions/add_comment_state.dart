part of 'add_comment_cubit.dart';

abstract class AddCommentState {}

class AddCommentInitial extends AddCommentState {}

class AddCommentLoading extends AddCommentState {}

class AddCommentSuccess extends AddCommentState {

  AddCommentSuccess({required this.newComment, required this.newCommentsCount});
  final AddCommentResponseModel newComment;
  final int newCommentsCount;
}

class AddCommentError extends AddCommentState {
  AddCommentError(this.message);
  final String message;
}
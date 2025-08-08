import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tcw/features/reels/presentation/cubit/reel_interactions/add_comment_cubit.dart';
import 'package:tcw/features/reels/presentation/cubit/reel_interactions/get_comment_cubit.dart';
import 'package:tcw/features/reels/presentation/pages/widgets/comment_item.dart';

class CommentBottomSheet extends StatefulWidget {
  const CommentBottomSheet({
    super.key,
    required this.reelId,
    required this.onCommentAdded,
  });

  final int reelId;
  final void Function(int newCount) onCommentAdded;

  @override
  State<CommentBottomSheet> createState() => CommentBottomSheetState();
}

class CommentBottomSheetState extends State<CommentBottomSheet> {
  final commentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<GetCommentCubit>().getComments(widget.reelId);

    commentController.addListener(() {
      final isNowSend = commentController.text.trim().isNotEmpty;
      if (isNowSend != isSend) {
        setState(() => isSend = isNowSend);
      }
    });
  }

  bool isSend = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
          bottomLeft: Radius.circular(16),
          bottomRight: Radius.circular(16),
        ),
      ),
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.65,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: BlocBuilder<GetCommentCubit, GetCommentsState>(
              builder: (context, state) {
                if (state is GetCommentsLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is GetCommentsLoaded) {
                  final comments = state.comments.data;

                  // Update comment count
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    widget.onCommentAdded(comments.length);
                  });

                  if (comments.isEmpty) {
                    return Center(
                      child: Text(
                        'No comments yet',
                        style:
                            Theme.of(context).textTheme.bodyLarge?.copyWith(
                                  color: Colors.grey,
                                ),
                      ),
                    );
                  }
                  return ListView.separated(
                    padding: const EdgeInsets.all(16),
                    itemCount: comments.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 16),
                    itemBuilder: (_, index) {
                      final comment = comments[index];
                      return CommentItem(comment: comment);
                    },
                  );
                } else if (state is GetCommentsError) {
                  return Center(
                    child: Text(
                      state.message,
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.error),
                    ),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ),

          // Add comment section
          BlocConsumer<AddCommentCubit, AddCommentState>(
            listener: (context, state) {
              if (state is AddCommentSuccess) {
                context.read<GetCommentCubit>().getComments(widget.reelId);
                commentController.clear();
              } else if (state is AddCommentError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.message)),
                );
              }
            },
            builder: (context, state) {
              return Container(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: Colors.grey.shade300,
                      width: 1,
                    ),
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const CircleAvatar(
                      radius: 20,
                      child: Icon(Icons.person),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: TextField(
                        controller: commentController,
                        decoration: InputDecoration(
                          hintText: 'Add a comment...',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(24),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          fillColor: Colors.white70,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    if (state is AddCommentLoading)
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                      )
                    else
                      isSend
                          ? IconButton(
                              icon: Icon(
                                Icons.send,
                                color: Theme.of(context).primaryColor,
                                size: 28,
                              ),
                              onPressed: () {
                                final text = commentController.text.trim();
                                if (text.isNotEmpty) {
                                  context
                                      .read<AddCommentCubit>()
                                      .addComment(widget.reelId, text);
                                }
                              },
                            )
                          : IconButton(
                              icon: Icon(
                                Icons.emoji_emotions_outlined,
                                color: Theme.of(context).primaryColor,
                                size: 28,
                              ),
                              onPressed: () {
                                // final text = commentController.text.trim();
                                // if (text.isNotEmpty) {
                                // context
                                //     .read<AddCommentCubit>()
                                //     .addComment(widget.reelId, text);
                                // }
                              },
                            ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

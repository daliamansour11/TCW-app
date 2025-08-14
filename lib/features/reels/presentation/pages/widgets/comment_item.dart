import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CommentItem extends StatefulWidget {
  const CommentItem({super.key, required this.comment});
  final dynamic comment;

  @override
  State<CommentItem> createState() => _CommentItemState();
}

class _CommentItemState extends State<CommentItem> {
  bool isLiked = false;
  int likeCount = 0;

  @override
  void initState() {
    super.initState();
    // likeCount = widget.comment.likesCount ?? 0;
  }

  void toggleLike() {
    setState(() {
      isLiked = !isLiked;
      likeCount += isLiked ? 1 : -1;
    });
    // context.read<toggleLikeCommentCubit>().toggleLike(widget.comment.id);
  }
  @override
  // void didUpdateWidget(CommentItem oldWidget) {
  //   super.didUpdateWidget(oldWidget);
  //   if (oldWidget.comment != widget.comment) {
  //     setState(() {
  //       likeCount = widget.comment.likesCount ?? 0;
  //       // Reset like state when comment updates
  //       isLiked = false;
  //     });
  //   }
  // }
  @override
  Widget build(BuildContext context) {
    final comment = widget.comment;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            comment.user?.imageUrl != null
                ? CircleAvatar(
              radius: 20,
              backgroundImage: NetworkImage(comment.user!.imageUrl!),
            )
                : CircleAvatar(
              radius: 20,
              backgroundColor: const Color(0xFFE0E0E0),
              child: Icon(Icons.person, color: Colors.grey.shade700),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    comment.user?.name ?? 'Unknown'.tr(),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    comment.content ?? '',
                    style: const TextStyle(fontSize: 15),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      TextButton(
                        onPressed: toggleLike,
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          minimumSize: Size.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        child: Row(
                          children: [

                            Text(
                              '$likeCount',
                              style: TextStyle(
                                color: Colors.grey.shade600,
                                fontSize: 13,
                              ),
                            ),
                            const SizedBox(width: 4),

                            Text(
                              'reel.like'.tr(),
                              style: TextStyle(
                                color: Colors.grey.shade600,
                                fontSize: 13,
                              ),
                            ),

                          ],
                        ),
                      ),
                      const SizedBox(width: 16),
                      TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          minimumSize: Size.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        child: Text(
                          'reel.reply'.tr(),
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 13,
                          ),
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                        onPressed: toggleLike,
                        icon: Icon(
                          isLiked ? Icons.favorite : Icons.favorite_border,
                          color: isLiked ? Colors.red : Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

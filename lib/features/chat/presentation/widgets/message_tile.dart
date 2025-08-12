import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:tcw/core/shared/shared_widget/custom_text.dart';
import 'package:tcw/core/routes/app_routes.dart';
import 'package:timeago/timeago.dart' as timeago;
class MessageTile extends StatelessWidget {
  const MessageTile({
    super.key,
    required this.name,
    required this.email,
    required this.time,
    required this.message,
    required this.imageUrl,
    required this.isMe,
    required this.conversationId,
    this.backgroundColor,
    this.avatarUrl,
  });

  final String name;
  final String email;
  final String time;
  final String message;
  final String imageUrl;
  final bool isMe;
  final int conversationId;
  final Color? backgroundColor;
  final String? avatarUrl;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Modular.to.pushNamed(
          AppRoutes.chatScreen,
          arguments: {'conversationId': conversationId},
        );
      },
      child: Container(
        color: backgroundColor ?? Colors.transparent,
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          spacing: 10,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 20,
              backgroundColor: Colors.grey.shade200,
              child: ClipOval(
                child: (avatarUrl?.isNotEmpty ?? false)
                    ? Image.network(
                  avatarUrl!,
                  fit: BoxFit.cover,
                  width: 40,
                  height: 40,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(Icons.person, color: Colors.grey);
                  },
                )
                    : (imageUrl.isNotEmpty
                    ? Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                  width: 40,
                  height: 40,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(Icons.person, color: Colors.grey);
                  },
                )
                    : const Icon(Icons.person, color: Colors.grey)),
              ),
            ),

            Expanded(
              child: Column(
                spacing: 4,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    spacing: 10,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                        name,
                        fontWeight: FontWeight.bold,
                      ),
                      CustomText(
                        timeago.format(DateTime.parse(time), locale: 'en_short'),
                        color: Colors.grey,
                        fontSize: 12,
                      )
                    ],
                  ),
                  if (email.isNotEmpty)
                    CustomText(
                      email,
                      color: Colors.grey,
                    ),
                  if (message.isNotEmpty)
                    CustomText(
                      message,
                      color: Colors.black,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

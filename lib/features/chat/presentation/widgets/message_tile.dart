
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:tcw/core/constansts/context_extensions.dart';
import 'package:tcw/routes/routes_names.dart';

class MessageTile extends StatelessWidget {
  final String name;
  final String email;
  final String time;
  final String message;
  final String imageUrl;
  final Color? backgroundColor;

  const MessageTile({
    super.key,
    required this.name,
    required this.email,
    required this.time,
    required this.message,
    required this.imageUrl,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
      Modular.to.pushNamed(AppRoutes.chatScreen);
      },
      child: Container(
        color: backgroundColor ?? Colors.transparent,
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 24,
              backgroundImage: NetworkImage(imageUrl),
            ),
             SizedBox(width: context.propWidth(12)),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(name,
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                      Text(time,
                          style:
                              const TextStyle(color: Colors.grey, fontSize: 12)),
                    ],
                  ),
                  Text(email, style: const TextStyle(color: Colors.grey)),
                  const SizedBox(height: 4),
                  Text(message, style: const TextStyle(color: Colors.black)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:tcw/core/shared/shared_widget/custom_text.dart';
import 'package:tcw/core/routes/app_routes.dart';

class MessageTile extends StatelessWidget {
  const MessageTile({
    super.key,
    required this.name,
    required this.email,
    required this.time,
    required this.message,
    required this.imageUrl,
    this.backgroundColor,
  });
  final String name;
  final String email;
  final String time;
  final String message;
  final String imageUrl;
  final Color? backgroundColor;

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
          spacing: 10,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CircleAvatar(
              radius: 20,
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
                        time,
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ],
                  ),
                  CustomText(
                    email,
                    color: Colors.grey,
                  ),
                  CustomText(
                    message,
                    color: Colors.black,
                    maxLines: 2,
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

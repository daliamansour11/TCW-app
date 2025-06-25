import 'package:flutter/material.dart';
import 'package:tcw/core/constansts/context_extensions.dart';
import 'package:tcw/core/shared/extensions/string_extensions.dart';
import 'package:tcw/core/shared/shared_widget/custom_image.dart';
import 'package:tcw/core/theme/app_colors.dart';
import 'package:tcw/features/auth/data/models/user_model.dart';

class UserHeader extends StatelessWidget {
  const UserHeader({
    super.key,
    this.onTap,
    this.isAside = false,
  });
  final bool isAside;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          SizedBox(height: context.propHeight(isAside ? 9 : 12)),
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: context.propWidth(isAside ? 50 : 70),
                height: context.propHeight(isAside ? 50 : 70),
                child: CircularProgressIndicator(
                  value: 0.6,
                  strokeWidth: 4,
                  backgroundColor: Colors.grey.shade300,
                  valueColor:
                      const AlwaysStoppedAnimation<Color>(AppColors.primaryColor),
                ),
              ),
              CircleAvatar(
                radius: isAside ? 18 : 30,
                child: userData!.image == null
                    ? const Icon(Icons.person_2_rounded)
                    : CustomImage(userData!.image!),
              ),
            ],
          ),
          SizedBox(height: context.propHeight(isAside ? 9 : 12)),
          Text('${''.greeting}, ${userData!.getFirstName}',
              textAlign: TextAlign.center,
              style: context.textTheme.headlineLarge?.copyWith(
                fontSize: isAside ? 12 : 16,
                fontWeight: FontWeight.bold,
              )),
          SizedBox(height: context.propHeight(12)),
          Text('Continue Your Journey And Achieve',
              textAlign: TextAlign.center,
              style: context.textTheme.headlineLarge?.copyWith(
                fontSize: isAside ? 12 : 16,
                fontWeight: FontWeight.w200,
                color: Colors.grey.shade600,
              )),
          Text(
            'Your Goals',
            textAlign: TextAlign.center,
            style: context.textTheme.headlineLarge?.copyWith(
              fontSize: isAside ? 12 : 16,
              fontWeight: FontWeight.w200,
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }
}

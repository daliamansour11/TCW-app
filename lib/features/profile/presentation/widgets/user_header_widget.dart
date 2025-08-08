import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tcw/core/constansts/context_extensions.dart';
import 'package:tcw/core/shared/extensions/string_extensions.dart';
import 'package:tcw/core/shared/shared_widget/custom_image.dart';
import 'package:tcw/core/shared/shared_widget/custom_text.dart';
import 'package:tcw/core/theme/app_colors.dart';
import 'package:tcw/features/auth/data/models/user_model.dart';
import 'package:tcw/features/profile/presentation/cubit/profile_cubit.dart';

class UserHeader extends StatefulWidget {
  const UserHeader({
    super.key,
    this.onTap,
    this.isAside = false,
  });
  final bool isAside;
  final VoidCallback? onTap;

  @override
  State<UserHeader> createState() => _UserHeaderState();
}

class _UserHeaderState extends State<UserHeader> {
  @override
  void initState() {
    super.initState();
    context.read<ProfileCubit>().getMyProfile();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(builder: (context, state) {
      final user = state is GetProfileLoaded ? state.user : userData;
      return Center(
        child: Column(
          children: [
            SizedBox(height: context.propHeight(widget.isAside ? 9 : 12)),
            Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: context.propWidth(widget.isAside ? 50 : 70),
                  height: context.propHeight(widget.isAside ? 50 : 70),
                  child: CircularProgressIndicator(
                    value: 0.6,
                    strokeWidth: 4,
                    backgroundColor: Colors.grey.shade300,
                    valueColor: const AlwaysStoppedAnimation<Color>(
                        AppColors.primaryColor),
                  ),
                ),
                user!.imageWidget,
              ],
            ),
            SizedBox(height: context.propHeight(widget.isAside ? 9 : 12)),
            CustomText(
              '${''.greeting}, ${user.getFirstName}',
              textAlign: TextAlign.center,
              fontSize: widget.isAside ? 12 : 16,
              fontWeight: FontWeight.bold,
            ),
            SizedBox(height: context.propHeight(12)),
            CustomText(
           user.status ?? '',
              textAlign: TextAlign.center,
              fontSize: widget.isAside ? 12 : 16,
              fontWeight: FontWeight.w200,
              color: Colors.grey.shade600,
            ),
            CustomText(
              'Your Goals',
              textAlign: TextAlign.center,
              fontSize: widget.isAside ? 12 : 16,
              fontWeight: FontWeight.w200,
              color: Colors.grey.shade600,
            ),
          ],
        ),
      );
    });
  }
}

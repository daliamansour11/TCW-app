import 'package:flutter/material.dart';
import 'package:tcw/core/shared/shared_widget/custom_image.dart';
import 'package:tcw/core/utils/asset_utils.dart';

class RiyalLogo extends StatelessWidget {
  const RiyalLogo({
    super.key,
    this.size = 18,
    this.color,
  });
  final double? size;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return CustomImage(
      AssetUtils.riyalIcon,
      size: size,
      color: color,
      fit: size != null ? BoxFit.contain : null,
    );
  }
}

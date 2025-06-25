import 'package:flutter/material.dart';
import 'package:tcw/core/utils/asset_utils.dart';
import 'package:zap_sizer/zap_sizer.dart';
import 'package:zapx/zapx.dart';

class BotButtonWidget extends StatelessWidget {
  const BotButtonWidget({super.key, this.withPositioned = true});
  final bool withPositioned;
  @override
  Widget build(BuildContext context) {
    if (!withPositioned) {
      return botButton();
    }
    return Positioned(
      right: -20,
      bottom: 80,
      child: botButton(),
    );
  }

  Widget botButton() {
    return Container(
      width: 20.w,
      decoration: BoxDecoration(
        color: const Color(0xFF2B195C),
        border: Border.all(color: Colors.white, width: 3),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          bottomLeft: Radius.circular(24),
        ),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      alignment: Alignment.centerLeft,
      child: IconButton(
        icon: const ImageIcon(
          AssetImage(AssetUtils.chatBot),
          color: Colors.white,
          size: 30,
        ),
        onPressed: () {},
      ).paddingAll(3),
    );
  }
}

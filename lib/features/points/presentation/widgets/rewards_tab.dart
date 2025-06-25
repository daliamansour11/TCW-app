import 'package:flutter/material.dart';
import 'package:tcw/core/shared/shared_widget/custom_button.dart';
import 'package:tcw/core/shared/shared_widget/custom_container.dart';
import 'package:tcw/core/theme/app_colors.dart';
import 'package:tcw/features/points/presentation/points_viewmodel.dart';
import 'package:tcw/features/points/presentation/widgets/history_item.dart';
import 'package:zap_sizer/zap_sizer.dart';

class RewardsTab extends StatelessWidget {
  const RewardsTab(this.viewmodel, {super.key});
  final PointsViewmodel viewmodel;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      children: [
        const SizedBox(height: 10),
        _rewardCard('10% Discount on Course Subscription', 100),
        _rewardCard('Unlock a Free Course', 500, locked: true),
        const SizedBox(height: 24),
        const Text('History',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        const SizedBox(height: 10),
        const HistoryItem(
          description: 'Redeemed reward: Discount Coupon',
          points: '-50 Points',
          isNegative: true,
        ),
      ],
    );
  }

  Widget _rewardCard(String title, int points, {bool locked = false}) {
    return CustomContainer(
      margin: const EdgeInsets.only(bottom: 12),
      padding: 16,
      color: Colors.white,
      borderRadius: 16,
      child: Column(
        spacing: 10,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                  radius: 20,
                  backgroundColor: const Color(0x33B7924F),
                  child: Icon(locked ? Icons.lock : Icons.card_giftcard,
                      color: AppColors.primaryColor)),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title,
                          style: const TextStyle(fontWeight: FontWeight.w600)),
                      const SizedBox(height: 4),
                      Text('$points POINTS',
                          style:
                              const TextStyle(color: AppColors.primaryColor)),
                    ]),
              ),
            ],
          ),
          Align(
            alignment: Alignment.centerRight,
            child: CustomButton(
              onPressed:  viewmodel.onRedeemReward,
              title: 'Redeem Reward',
              width: 30.w,
              backgroundColor: Colors.transparent,
              borderColor: Colors.black,
              textColor: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}

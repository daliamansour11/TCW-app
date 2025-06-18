import 'package:flutter/material.dart';
import 'package:tcw/core/theme/app_colors.dart';
import 'history_item.dart';

class RewardsTab extends StatelessWidget {
  const RewardsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      children: [
        const SizedBox(height: 10),
        _rewardCard("10% Discount on Course Subscription", 100),
        _rewardCard("Unlock a Free Course", 500, locked: true),
        const SizedBox(height: 24),
        const Text("History", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        const SizedBox(height: 10),
        const HistoryItem(
          description: 'Redeemed reward: Discount Coupon',
          points: "-50 Points",
          isNegative: true,
        ),
      ],
    );
  }

  Widget _rewardCard(String title, int points, {bool locked = false}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE5E5E5)),
      ),
      child: Row(
        children: [
          CircleAvatar(
             radius: 20,
            backgroundColor:const Color(0x33B7924F),
            child: Icon(locked ? Icons.lock : Icons.card_giftcard, color:AppColors.primaryColor)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
              const SizedBox(height: 4),
              Text("$points POINTS", style:  TextStyle(color:AppColors.primaryColor )),
            ]),
          ),
          TextButton(
            onPressed: () {},
            style: TextButton.styleFrom(
              foregroundColor: AppColors.primaryColor,
              side:  BorderSide(color:AppColors.primaryColor),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            child: const Text("Redeem"),
          ),
        ],
      ),
    );
  }
}

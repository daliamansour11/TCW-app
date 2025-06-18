import 'package:flutter/material.dart';
import 'package:tcw/core/theme/app_colors.dart';
import 'history_item.dart';

class PointsTab extends StatelessWidget {
  const PointsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      children: [
        const SizedBox(height: 10),
        _infoCard(Icons.videocam, "Live session attendance", "+10 Points Per Session"),
        _infoCard(Icons.people, "Social interaction", "+2 Points Per Interaction"),
        _infoCard(Icons.check_circle, "Lesson completion", "+5 Points Per Lesson"),
        _infoCard(Icons.group_add, "Inviting friends", "+20 Points Per New Registration"),
        const SizedBox(height: 24),
        const Text("History", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        const SizedBox(height: 10),
        const HistoryItem(
          description: 'Completed the "UI Basics" course',
          points: "+10 Points",
        ),
        const HistoryItem(
          description: 'Attended the live "React" lesson',
          points: "+10 Points",
        ),
        const HistoryItem(
          description: 'Redeemed for a reward',
          points: "-50 Points",
          isNegative: true,
        ),
        const HistoryItem(
          description: 'Created a reel',
          points: "+10 Points",
        ),
        const HistoryItem(
          description: 'Completed the lesson',
          points: "+5 Points",
        ),
      ],
    );
  }

  Widget _infoCard(IconData icon, String title, String subtitle) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
         boxShadow: const [
      BoxShadow(
        color: Color(0x0F080F34),
        blurRadius: 42,
        offset: Offset(0, 14),
        spreadRadius: 0,
      )
    ],
        
      ),
      
      child: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor:const Color(0x33B7924F),
            child: Icon(icon,color:  AppColors.primaryColor),
          ),
           SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
                const SizedBox(height: 4),
                Text(subtitle, style:  TextStyle(color: AppColors.primaryColor)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

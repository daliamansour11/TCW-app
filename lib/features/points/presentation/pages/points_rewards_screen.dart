// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:tcw/core/constansts/context_extensions.dart';
import 'package:tcw/core/shared/shared_widget/app_bar.dart';
import '../widgets/points_tab.dart';
import '../widgets/rewards_tab.dart';

class PointsRewardsScreen extends StatefulWidget {
  bool showPointsTabFirst;
   PointsRewardsScreen({super.key, this.showPointsTabFirst = true});

  @override
  State<PointsRewardsScreen> createState() => _PointsRewardsScreenState();
}

class _PointsRewardsScreenState extends State<PointsRewardsScreen> {
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    selectedIndex = widget.showPointsTabFirst ? 0 : 1;
  }

  @override
  Widget build(BuildContext context) {
    final isPointsSelected = selectedIndex == 0;
    final isRewardsSelected = selectedIndex == 1;

    return Scaffold(

      body: SafeArea(
        child: Column(
          children: [
             SizedBox(height:context.propHeight(32)),
             CustomAppBar(
              title: 
              // if (widget.showPointsTabFirst) "Points" else "Rewards",
              widget.showPointsTabFirst ? "Points" : "Rewards",
              ),
              SizedBox(height:context.propHeight(20)),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  _tabButton("100 Points", isPointsSelected, () {
                    setState(() {
                      selectedIndex = 0;
                      widget.showPointsTabFirst = true;

                    });
                    
                  }),
                  const SizedBox(width: 10),
                  _tabButton("4 Rewards", isRewardsSelected, () {
                    setState(() {
                      selectedIndex = 1;
                      widget.showPointsTabFirst = false;
                    });
                  }),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: selectedIndex == 0 ? const PointsTab() : const RewardsTab(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _tabButton(String label, bool isSelected, VoidCallback onTap) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          height: 90,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            gradient: isSelected
                ? const LinearGradient(
                    begin: Alignment(-0.01, -2.12),
                    end: Alignment(1.01, -2.12),
                    colors: [const Color(0xFF051742), const Color(0xFF452775)],
                  )
                : null,
            color: isSelected ? null : Colors.white,
            borderRadius: BorderRadius.circular(16),
            border:
                isSelected ? null : Border.all(color: const Color(0xFF8241FF)),
          ),
          child: Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.black,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}

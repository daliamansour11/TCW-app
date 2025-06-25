// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:tcw/core/shared/shared_widget/app_bar.dart';
import 'package:tcw/core/shared/shared_widget/custom_text.dart';
import 'package:tcw/core/theme/app_colors.dart';
import 'package:tcw/core/utils/asset_utils.dart';
import 'package:tcw/features/points/presentation/points_viewmodel.dart';
import 'package:tcw/features/points/presentation/widgets/points_tab.dart';
import 'package:tcw/features/points/presentation/widgets/rewards_tab.dart';

class PointsRewardsScreen extends StatefulWidget {
  const PointsRewardsScreen({super.key});

  @override
  State<PointsRewardsScreen> createState() => _PointsRewardsScreenState();
}

List<Map> _tabItems = [
  {
    'type': 'points',
    'label': 'Points',
    'icon': AssetUtils.point,
    'count': '100',
  },
  {
    'type': 'rewards',
    'label': 'Rewards',
    'icon': AssetUtils.rewards,
    'count': '4',
  }
];

class _PointsRewardsScreenState extends State<PointsRewardsScreen> {
  int selectedIndex = 0;
  bool get isPointsSelected => selectedIndex == 0;
  bool get isRewardsSelected => selectedIndex == 1;
  late final PointsViewmodel viewmodel;
  @override
  void initState() {
    super.initState();
    viewmodel = PointsViewmodel(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Points'),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: _tabButton(selectedIndex, (i) {
                setState(() {
                  selectedIndex = i;
                });
              }),
            ),
            const SizedBox(height: 20),
            Expanded(
              child:
                  selectedIndex == 0 ? const PointsTab() :  RewardsTab(viewmodel),
            ),
          ],
        ),
      ),
    );
  }

  Widget _tabButton(int selectedIndex, void Function(int i) onTap) {
    return Row(
        spacing: 10,
        children: List.generate(
          _tabItems.length,
          (index) {
            final isSelected = selectedIndex == index;
            return Expanded(
              child: InkWell(
                onTap: () => onTap(index),
                child: AnimatedContainer(
                  padding:const EdgeInsets.all(20),
                  duration: const Duration(milliseconds: 300),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    gradient: isSelected ? AppColors.cardGradient : null,
                    borderRadius: BorderRadius.circular(16),
                    border: isSelected ? null : Border.all(),
                  ),
                  child: Column(
                    spacing: 10,
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ImageIcon(
                        const AssetImage(AssetUtils.point),
                        color: isSelected ? Colors.white : Colors.black,
                      ),
                      CustomText(
                        '${_tabItems[index]['count']} ${_tabItems[index]['label']}',
                        color: isSelected ? Colors.white : Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ));
  }
}

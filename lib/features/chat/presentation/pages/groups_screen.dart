import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:tcw/core/shared/shared_widget/app_bar.dart';
import 'package:tcw/core/shared/shared_widget/custom_button.dart';
import 'package:tcw/core/shared/shared_widget/custom_container.dart';
import 'package:tcw/core/shared/shared_widget/custom_text.dart';
import 'package:tcw/core/theme/app_colors.dart';
import 'package:tcw/core/routes/app_routes.dart';
import 'package:zap_sizer/zap_sizer.dart';
import 'package:zapx/zapx.dart';

class GroupsScreen extends StatelessWidget {
  const GroupsScreen({super.key});

  static final List<GroupModel> groups = [
    GroupModel(
      title: 'UI Group',
      coachName: 'Ahmed Mohamed',
      role: 'Coach',
      description:
          'Lorem ipsum dolor sit amet consectetur non arcu non mauris quis diam lectus commodo...',
      lastMessageTime: '5 min ago',
      memberImages: [
        'https://i.pravatar.cc/150?img=1',
        'https://i.pravatar.cc/150?img=2',
        'https://i.pravatar.cc/150?img=3',
      ],
      moreCount: 4,
    ),
    GroupModel(
      title: 'React Group',
      coachName: 'Ahmed Mohamed',
      role: 'Coach',
      description:
          'Lorem ipsum dolor sit amet consectetur non arcu non mauris quis diam lectus commodo...',
      lastMessageTime: '30 min ago',
      memberImages: [
        'https://i.pravatar.cc/150?img=4',
        'https://i.pravatar.cc/150?img=5',
        'https://i.pravatar.cc/150?img=6',
      ],
      moreCount: 4,
    ),
    GroupModel(
      title: 'Graphic Group',
      coachName: 'Ahmed Mohamed',
      role: 'Coach',
      description:
          'Lorem ipsum dolor sit amet consectetur non arcu non mauris quis diam lectus commodo...',
      lastMessageTime: '2 days',
      memberImages: [
        'https://i.pravatar.cc/150?img=7',
        'https://i.pravatar.cc/150?img=8',
        'https://i.pravatar.cc/150?img=9',
      ],
      moreCount: 4,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Master Mind',
      ),
      body: ListView(
        children: [
          Column(
            spacing: 5,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                spacing: 5,
                children: [
                  const CustomText(
                    'All Groups (3)',
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  CustomButton(
                    title: '+ New Group',
                    width: 30.w,
                    onPressed: () => Zap.toNamed(AppRoutes.newGroupScreen),
                    backgroundColor: Colors.transparent,
                    borderColor: AppColors.primaryColor,
                    style: CustomText.style(
                      color: AppColors.primaryColor,
                    ),
                  )
                ],
              ),
              const CustomText(
                'My Groups (3)',
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.grey,
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: groups.length,
                padding: const EdgeInsets.only(bottom: 20),
                itemBuilder: (context, index) {
                  return GroupCard(group: groups[index]);
                },
              ),
              const CustomText(
                'Explore Groups (3)',
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.grey,
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: groups.length,
                padding: const EdgeInsets.only(bottom: 20),
                itemBuilder: (context, index) {
                  return GroupCard(group: groups[index]);
                },
              ),
            ],
          ).paddingAll(10),
        ],
      ),
    );
  }
}

class GroupModel {
  GroupModel({
    required this.title,
    required this.coachName,
    required this.role,
    required this.description,
    required this.lastMessageTime,
    required this.memberImages,
    required this.moreCount,
  });
  final String title;
  final String coachName;
  final String role;
  final String description;
  final String lastMessageTime;
  final List<String> memberImages;
  final int moreCount;
  String get createdAt => '2025-06-25';
  String get coverImage =>
      'https://img.freepik.com/free-vector/matrix-style-binary-code-digital-falling-numbers-blue-background_1017-37387.jpg';
}

class GroupCard extends StatelessWidget {
  const GroupCard({super.key, required this.group});
  final GroupModel group;

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      padding: 15,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      borderRadius: 12,
      image: DecorationImage(
        image: NetworkImage(group.coverImage),
        fit: BoxFit.cover,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                spacing: 5,
                children: [
                  const Icon(
                    Icons.calendar_month_outlined,
                    size: 14,
                    color: Colors.grey,
                  ),
                  CustomText(
                    'Created on ${group.createdAt}',
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ],
              ),
              Row(
                children: [
                  ...group.memberImages.take(2).map((url) => CircleAvatar(
                        radius: 12,
                        backgroundImage: NetworkImage(url),
                      )),
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 12,
                    child: CustomText(
                      '+${group.moreCount}',
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
            ],
          ),
          const SizedBox.shrink(),
          CustomText(
            group.title,
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          CustomText(
            '${group.coachName}  •  ${group.role}',
            color: Colors.grey,
            fontWeight: FontWeight.w600,
          ),
          const SizedBox.shrink(),
          CustomButton(
            title: 'View Group',
            width: 20.w,
            onPressed: () {
              Modular.to.pushNamed(AppRoutes.groupChatScreen);
            },
          )
        ],
      ),
    );
  }
}

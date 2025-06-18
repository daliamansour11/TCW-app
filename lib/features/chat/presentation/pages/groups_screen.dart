import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:tcw/routes/routes_names.dart';

class GroupsScreen extends StatelessWidget {
  final List<GroupModel> groups = [
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
      backgroundColor: Colors.white,
      appBar: _buildAppBar(context),
      body: ListView.builder(
        itemCount: groups.length,
        padding: const EdgeInsets.only(bottom: 20),
        itemBuilder: (context, index) {
          return GroupCard(group: groups[index]);
        },
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: const BackButton(color: Colors.black),
      title: const Text(
        'Master Mind',
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 16),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: const Color(0xFFF2E5CF),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              '3',
              style: TextStyle(color: Colors.black),
            ),
          ),
        )
      ],
    );
  }
}

class GroupModel {
  final String title;
  final String coachName;
  final String role;
  final String description;
  final String lastMessageTime;
  final List<String> memberImages;
  final int moreCount;

  GroupModel({
    required this.title,
    required this.coachName,
    required this.role,
    required this.description,
    required this.lastMessageTime,
    required this.memberImages,
    required this.moreCount,
  });
}

class GroupCard extends StatelessWidget {
  final GroupModel group;

  const GroupCard({required this.group});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Modular.to.pushNamed(AppRoutes.groupChatScreen);
      },
      child: Card(
        elevation: 0,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        color: const Color(0xFFF9F9F9),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(group.title,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16)),
                  Text(group.lastMessageTime,
                      style: const TextStyle(color: Colors.grey)),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                '${group.coachName}  •  ${group.role}',
                style: const TextStyle(
                    color: Colors.grey, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 6),
              Text(group.description,
                  style: const TextStyle(color: Colors.grey)),
              const SizedBox(height: 10),
              Row(
                children: [
                  ...group.memberImages
                      .map((url) => Padding(
                            padding: const EdgeInsets.only(right: 4),
                            child: CircleAvatar(
                              radius: 14,
                              backgroundImage: NetworkImage(url),
                            ),
                          ))
                      .toList(),
                  Text(
                    '+${group.moreCount}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

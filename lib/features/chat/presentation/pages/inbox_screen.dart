import 'package:flutter/material.dart';
import 'package:tcw/core/shared/shared_widget/app_bar.dart';
import 'package:tcw/core/shared/shared_widget/custom_container.dart';
import 'package:tcw/core/shared/shared_widget/custom_text.dart';
import 'package:tcw/features/chat/presentation/widgets/message_tile.dart';

class InboxScreen extends StatelessWidget {
  const InboxScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Inbox'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 10,
          children: [
            const CustomText(
              'Members',
              fontWeight: FontWeight.bold,
            ),
            Row(
              children: List.generate(
                  5,
                  (index) => Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Stack(
                          children: [
                            const CircleAvatar(
                              radius: 20,
                              // backgroundImage: NetworkImage(
                              //     'https://i.pravatar.cc/150?img=${index + 1}'),
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: CustomContainer(
                                color: Colors.green,
                                padding: 4,
                                isCircle: true,
                                border: Border.all(
                                  color: Colors.white,
                                  width: 1.5,
                                ),
                              ),
                            )
                          ],
                        ),
                      )),
            ),
            Row(
              spacing: 10,
              children: [
                const CustomText('Messages', fontWeight: FontWeight.bold),
                CustomContainer(
                  color: const Color(0xFFF3E7D3),
                  padding: 4,
                  isCircle: true,
                  border: Border.all(
                    color: Colors.white,
                    width: 1.5,
                  ),
                  child: const CustomText('10', fontWeight: FontWeight.bold),
                )
              ],
            ),
            Expanded(
              child: ListView(
                children: const [
                  MessageTile(
                    name: 'Ramy ahmed',
                    email: 'Ramy@gmail.com',
                    time: '5 min ago',
                    message:
                        'Lorem ipsum dolor sit amet consectetur non arcu non mauris quis diam lectus commodo.',
                    imageUrl: 'https://i.pravatar.cc/150?img=11',
                  ),
                  MessageTile(
                    name: 'Mohamed Amir',
                    email: 'Mohamed@gmail.com',
                    time: '10 min ago',
                    message:
                        'Lorem ipsum dolor sit amet consectetur non arcu non mauris quis diam lectus commodo.',
                    imageUrl: 'https://i.pravatar.cc/150?img=12',
                    backgroundColor: Color(0xFFF6F6F6),
                  ),
                  MessageTile(
                    name: 'Ahmed Ali',
                    email: 'Ahmed@gmail.com',
                    time: '20 min ago',
                    message:
                        'Lorem ipsum dolor sit amet consectetur non arcu non mauris quis diam lectus commodo.',
                    imageUrl: 'https://i.pravatar.cc/150?img=13',
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

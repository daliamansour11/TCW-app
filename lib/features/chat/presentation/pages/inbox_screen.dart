import 'package:flutter/material.dart';
import 'package:tcw/core/constansts/context_extensions.dart';
import 'package:tcw/core/shared/shared_widget/app_bar.dart';
import 'package:tcw/features/chat/presentation/widgets/message_tile.dart';

class InboxScreen extends StatelessWidget {
  const InboxScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomAppBar(
                title: 'Inbox',
                width: context.propWidth(50),
              ),
              Text('Members',
                  style: context.textTheme.headlineSmall
                      ?.copyWith(color: Colors.black)),
               SizedBox(height: context.propHeight(24)),
              Row(
                children: List.generate(
                    5,
                    (index) => Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Stack(
                            children: [
                              CircleAvatar(
                                radius: 24,
                                backgroundImage: NetworkImage(
                                    'https://i.pravatar.cc/150?img=${index + 1}'),
                              ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: Container(
                                  width: context.propWidth(10),
                                  height: context.propWidth(10),
                                  decoration: BoxDecoration(
                                    color: Colors.green,
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                        color: Colors.white, width: 1.5),
                                  ),
                                ),
                              )
                            ],
                          ),
                        )),
              ),
               SizedBox(height: context.propHeight(24)),
              Row(
                children: [
                   Text('Messages',
                      style: context.textTheme.headlineSmall
                      ?.copyWith(color: Colors.black)),
                   SizedBox(width: context.propWidth(8)),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF3E7D3),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: const Text('10',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  )
                ],
              ),
               SizedBox(height: context.propHeight(16)),
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
      ),
    );
  }
}

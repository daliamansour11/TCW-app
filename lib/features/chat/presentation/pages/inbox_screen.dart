// import 'package:flutter/material.dart';
// import 'package:tcw/core/shared/shared_widget/app_bar.dart';
// import 'package:tcw/core/shared/shared_widget/custom_container.dart';
// import 'package:tcw/core/shared/shared_widget/custom_text.dart';
// import 'package:tcw/features/chat/presentation/widgets/message_tile.dart';
// class InboxScreen extends StatelessWidget {
//   const InboxScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: const CustomAppBar(title: 'Inbox'),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           spacing: 10,
//           children: [
//             const CustomText(
//               'Members',
//               fontWeight: FontWeight.bold,
//             ),
//             Row(
//               children: List.generate(
//                   5,
//                       (index) => Padding(
//                     padding: const EdgeInsets.only(right: 8.0),
//                     child: Stack(
//                       children: [
//                         const CircleAvatar(
//                           radius: 20,
//                           // backgroundImage: NetworkImage(
//                           //     'https://i.pravatar.cc/150?img=${index + 1}'),
//                         ),
//                         Positioned(
//                           bottom: 0,
//                           right: 0,
//                           child: CustomContainer(
//                             color: Colors.green,
//                             padding: 4,
//                             isCircle: true,
//                             border: Border.all(
//                               color: Colors.white,
//                               width: 1.5,
//                             ),
//                           ),
//                         )
//                       ],
//                     ),
//                   )),
//             ),
//             Row(
//               spacing: 10,
//               children: [
//                 const CustomText('Messages', fontWeight: FontWeight.bold),
//                 CustomContainer(
//                   color: const Color(0xFFF3E7D3),
//                   padding: 4,
//                   isCircle: true,
//                   border: Border.all(
//                     color: Colors.white,
//                     width: 1.5,
//                   ),
//                   child: const CustomText('10', fontWeight: FontWeight.bold),
//                 )
//               ],
//             ),
//             Expanded(
//               child: ListView(
//                 children: const [
//                   MessageTile(
//                     name: 'Ramy ahmed',
//                     email: 'Ramy@gmail.com',
//                     time: '5 min ago',
//                     message:
//                     'Lorem ipsum dolor sit amet consectetur non arcu non mauris quis diam lectus commodo.',
//                     imageUrl: 'https://i.pravatar.cc/150?img=11', isMe: true,
//                   ),
//                   MessageTile(
//                     name: 'Mohamed Amir',
//                     email: 'Mohamed@gmail.com',
//                     time: '10 min ago',
//                     message:
//                     'Lorem ipsum dolor sit amet consectetur non arcu non mauris quis diam lectus commodo.',
//                     imageUrl: 'https://i.pravatar.cc/150?img=12',
//                     backgroundColor: Color(0xFFF6F6F6), isMe: true,
//                   ),
//                   MessageTile(
//                     name: 'Ahmed Ali',
//                     email: 'Ahmed@gmail.com',
//                     time: '20 min ago',
//                     message:
//                     'Lorem ipsum dolor sit amet consectetur non arcu non mauris quis diam lectus commodo.',
//                     imageUrl: 'https://i.pravatar.cc/150?img=13', isMe: true,
//                   ),
//                 ],
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/shared/shared_widget/app_bar.dart';
import '../../../../core/shared/shared_widget/custom_container.dart';
import '../../../../core/shared/shared_widget/custom_text.dart';
import '../widgets/message_tile.dart';
import '../cubit/_chat_cubit.dart';

class InboxScreen extends StatefulWidget {
  const InboxScreen({super.key});

  @override
  State<InboxScreen> createState() => _InboxScreenState();
}

class _InboxScreenState extends State<InboxScreen> {
  late ChatCubit _cubit;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _cubit = context.read<ChatCubit>()..fetchConversationList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Inbox'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
            const Row(
              children: [
                CustomText('Messages', fontWeight: FontWeight.bold),
              ],
            ),
            const SizedBox(height: 10),
            Expanded(
              child:  BlocConsumer<ChatCubit, ChatState>(
                listener: (context, state) {
                  if (state is ConversationError) {
                    // Show error message as a SnackBar or Dialog
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(state.error)),
                    );
                  }
                },
                builder: (context, state) {
                  if (state is ConversationLoading) {
                    if (_isLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else {
                      return Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text(
                                'Something went wrong or took too long.'),
                            const SizedBox(height: 10),
                            ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  _isLoading = true;
                                });
                                context.read<ChatCubit>()
                                  ..fetchConversationList();
                                Timer(const Duration(seconds: 12), () {
                                  if (mounted) {
                                    setState(() {
                                      _isLoading = false;
                                    });
                                  }
                                });
                              },
                              child: const Text('Retry'),
                            ),
                          ],
                        ),
                      );
                    }
                  } else if (state is ConversationsListLoaded) {
                    final messagesList = state.conversations.data.data;

                    if (messagesList.isEmpty) {
                      return const Center(child: Text('No conversations yet'));
                    }

                    return ListView.builder(
                      itemCount: messagesList.length,
                      itemBuilder: (context, index) {
                        final msg = messagesList[index];
                        return MessageTile(
                          name: msg.userName ?? '',
                          email: '',
                          time: msg.lastMessagedAt ?? '',
                          message: msg.lastMessage ?? '',
                          imageUrl: msg.userImage ?? '',
                          isMe: false,
                          conversationId: msg.id,
                        );
                      },
                    );
                  } else if (state is ConversationError) {
                    return const Center(child: Text('Error: cannot fetch conversation'));
                  }

                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

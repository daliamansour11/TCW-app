
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
      appBar: CustomAppBar(title: 'inbox'.tr()),      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              'members'.tr(),
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
              children: [
                CustomText(
                  'messages'.tr(),
                  fontWeight: FontWeight.bold,
                ),                // ... your badge container
              ],
            ),
            const SizedBox(height: 10),
            Expanded(
              child: BlocBuilder<ChatCubit, ChatState>(
                builder: (context, state) {
                  if (state is ConversationLoading) {
                    if (_isLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else {
                      return Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text('Something went wrong or took too long.'.tr()),
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
                              child: Text('retry'.tr()),
                            ),
                          ],
                        ),
                      );
                    }
                  } else if (state is ConversationsListLoaded) {
                    final messagesList = state.conversations.data.data;

                    if (messagesList.isEmpty) {
                      return  Center(child:
                      Text('no_conversations_yet'.tr()));
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
                    return  Center(child:

                    Text('error_fetch_conversations'.tr()));                  }

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

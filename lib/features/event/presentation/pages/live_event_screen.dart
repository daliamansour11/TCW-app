import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../../../core/shared/shared_widget/custom_container.dart';
import '../../../../core/shared/shared_widget/custom_text.dart';
import '../../../../core/shared/shared_widget/custom_text_form_field.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../chat/presentation/pages/group_chat_screen.dart';
import '../../data/models/poll_model.dart';
import '../../data/models/question_model.dart';
import 'package:zap_sizer/zap_sizer.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
class LiveEventScreen extends StatefulWidget {
  const LiveEventScreen({super.key, required this.questions, required this.meetingUrl, required this.liveId});
  final List<QuestionModel> questions;
  final String meetingUrl;
   final int liveId;
  @override
  State<LiveEventScreen> createState() => _LiveEventScreenState();
}

class _LiveEventScreenState extends State<LiveEventScreen> {
  List<PollOption> pollOptions = [
    PollOption(text: 'Pomodoro Technique', votes: 1),
    PollOption(text: 'Eisenhower Matrix'),
  ];

  final Map<int, TextEditingController> answerControllers = {};
  late WebViewController webViewController; // Add WebViewController
  MediaStream? localStream;
  bool isMicOn = true;
  bool isCameraOn = true;
  RTCVideoRenderer _localRenderer = RTCVideoRenderer();
  Future<void> startLocalStream() async {
    final Map<String, dynamic> mediaConstraints = {
      'audio': true,
      'video': {
        'facingMode': 'user',
      }
    };

    try {
      MediaStream stream = await navigator.mediaDevices.getUserMedia(mediaConstraints);
      setState(() {
        localStream = stream;
        _localRenderer.srcObject = localStream;
        isMicOn = true;
        isCameraOn = true;
      });
    } catch (e) {
      print('Error accessing media devices: $e');
    }
  }

  void toggleCamera() {
    if (localStream == null) return;
    final videoTrack = localStream!.getVideoTracks().first;
    setState(() {
      if (videoTrack.enabled) {
        videoTrack.enabled = false;
        isCameraOn = false;
      } else {
        videoTrack.enabled = true;
        isCameraOn = true;
      }
    });
  }

  void toggleMic() {
    if (localStream == null) return;
    final audioTrack = localStream!.getAudioTracks().first;
    setState(() {
      if (audioTrack.enabled) {
        audioTrack.enabled = false;
        isMicOn = false;
      } else {
        audioTrack.enabled = true;
        isMicOn = true;
      }
    });
  }

  Future<void> initRenderer() async {
    await _localRenderer.initialize();
  }
  @override
  void initState() {
    super.initState();
    initRenderer().then((_) {
      startLocalStream();
    });
    webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..loadRequest(Uri.parse(widget.meetingUrl));



    for (var question in widget.questions) {
      answerControllers[question.id] = TextEditingController();
    }
  }

  @override
  void dispose() {
    localStream?.getTracks().forEach((track) {
      track.stop();
    });    _localRenderer.dispose();
    for (var ctrl in answerControllers.values) {
      ctrl.dispose();
    }
    super.dispose();
  }

  void togglePollOption(int index) {
    setState(() {
      pollOptions[index].isSelected = !(pollOptions[index].isSelected ?? false);
      if (pollOptions[index].isSelected == true) {
        pollOptions[index].votes += 1;
      } else {
        if (pollOptions[index].votes > 0) pollOptions[index].votes -= 1;
      }
    });
  }

  int get totalVotes => pollOptions.fold(0, (sum, o) => sum + o.votes);

  Map<int, String> get allAnswers => answerControllers.map(
        (key, controller) => MapEntry(key, controller.text.trim()),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        padding: const EdgeInsets.all(10),
        children: [

          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () => Navigator.pop(context),
              ),
               CustomText(
                '',
                fontWeight: FontWeight.bold,
              ),
            ],
          ),
          const SizedBox(height: 12),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {
                  Clipboard.setData(
                       ClipboardData(text: '${widget.meetingUrl}'));
                },
                icon: const Icon(Icons.copy,
                    color: AppColors.primaryColor, size: 20),
              ),
               CustomText(
                '${widget.meetingUrl}',
                color: AppColors.primaryColor,
                fontSize: 14,
                fontWeight: FontWeight.w400,
                decoration: TextDecoration.underline,
              ),
            ],
          ),
          const SizedBox(height: 12),

          // WebView Container
          CustomContainer(
            height: 50.h,
            borderRadius: 16,
            color: Colors.grey.shade300,
            child: Stack(
              children: [
                // Use WebViewWidget instead of WebView
                WebViewWidget(controller: webViewController),
                Positioned(
                  bottom: 12,
                  left: 0,
                  right: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () {
                          print('Present button clicked');
                          // TODO: إضافة مشاركة الشاشة أو وظيفة فعلية
                        },
                        child: CircleAvatar(
                          backgroundColor: Colors.black.withOpacity(0.6),
                          child: const Icon(Icons.present_to_all, color: Colors.white),
                        ),
                      ),
                        GestureDetector(
                          onTap: toggleCamera,
                          child: CircleAvatar(
                            backgroundColor: Colors.black.withOpacity(0.6),
                            child: Icon(
                              isCameraOn ? Icons.videocam : Icons.videocam_off,
                              color: Colors.white,
                            ),
                          ),
                        ),

                        GestureDetector(
                        onTap: () {
                          print('Call end clicked');
                          Navigator.pop(context);
                        },
                        child: CustomContainer(
                          padding: 8,
                          color: const Color(0xFFF7000E),
                          radius: BorderRadius.circular(12.37),
                          child: const Icon(Icons.call_end, color: Colors.white),
                        ),
                      ),
                      GestureDetector(
                        onTap: toggleMic,
                        child: CircleAvatar(
                          backgroundColor: Colors.black.withOpacity(0.6),
                          child: Icon(
                            isMicOn ? Icons.mic : Icons.mic_off,
                            color: Colors.white,
                          ),
                        ),
                      ),

                      GestureDetector(
                        onTap: () {
                          print('More options clicked');
                          showModalBottomSheet(
                            context: context,
                            builder: (_) => Container(
                              height: 200,
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                children: [
                                  const Text('More Options', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                                  ListTile(
                                    leading: const Icon(Icons.settings),
                                    title: const Text('Settings'),
                                    onTap: () {
                                      Navigator.pop(context);
                                      // TODO: تنفيذ إجراء الإعدادات
                                    },
                                  ),
                                  ListTile(
                                    leading: const Icon(Icons.help),
                                    title: const Text('Help'),
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        child: CircleAvatar(
                          backgroundColor: Colors.black.withOpacity(0.6),
                          child: const Icon(Icons.more_horiz, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),

              ],
            ),
          ),

          const SizedBox(height: 12),
          const Row(
            children: [
              CustomText('Messages'),
              SizedBox(width: 5),
              CustomText(
                '(4)',
                color: AppColors.primaryColor,
              ),
            ],
          ),
          const SizedBox(height: 12),
           GroupChatScreen(isWidgetOnly: true, liveId: widget.liveId,),
          const SizedBox(height: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomText(
                'Live Questions (Q&A)',
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
              const SizedBox(height: 12),
              ...widget.questions.map(
                    (q) => Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        '${q.id}- ${q.question}',
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                      const SizedBox(height: 6),
                      CustomTextField(
                        controller: answerControllers[q.id],
                        hintText: 'Type your answer...',
                        hintStyle:
                        const TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ),
              buildPollSection(),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildPollSection() {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Poll Questions',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
          const SizedBox(height: 12),
          const Text(
            'Which time management technique do you find most effective?',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 4),
          const Row(
            children: [
              Icon(Icons.group, size: 14, color: Colors.grey),
              SizedBox(width: 4),
              Text(
                'Select one or more',
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ...pollOptions.asMap().entries.map((entry) {
            final index = entry.key;
            final option = entry.value;
            final percent =
            totalVotes == 0 ? 0.0 : option.votes / totalVotes.toDouble();

            return GestureDetector(
              onTap: () => togglePollOption(index),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        option.isSelected == true
                            ? Icons.check_box
                            : Icons.check_box_outline_blank,
                        color: option.isSelected == true
                            ? AppColors.primaryColor
                            : Colors.grey,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          option.text,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      if (option.votes > 0)
                        const CircleAvatar(
                          radius: 10,
                          backgroundImage:
                          NetworkImage('https://i.pravatar.cc/100'),
                        ),
                      const SizedBox(width: 4),
                      Text(
                        '${option.votes}',
                        style: const TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Container(
                    height: 6,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(4),
                    ),
                    clipBehavior: Clip.hardEdge,
                    child: FractionallySizedBox(
                      alignment: Alignment.centerLeft,
                      widthFactor: percent,
                      child: Container(color: AppColors.primaryColor),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:tcw/core/shared/shared_widget/custom_text.dart';
import 'package:tcw/core/utils/asset_utils.dart';
import 'package:tcw/features/event/data/models/event_model.dart';
import 'package:tcw/features/event/presentation/widgets/non_subscribe_event_item_widget.dart';
import 'package:tcw/features/event/presentation/widgets/subscribe_event_item_widget.dart';
import 'package:tcw/core/routes/app_routes.dart';
import 'package:zapx/zapx.dart';

class EventScreen extends StatefulWidget {
  const EventScreen({super.key});

  @override
  State<EventScreen> createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
  List<Event> upComingEvents = [
    Event(
      date: '17 Mar',
      time: '02.00 - 03.30 PM',
      title: 'Mastering Productivity',
      description:
          'Learn practical strategies to boost efficiency, manage time effectively, and achieve your goals with expert insights.',
      coachName: 'Ahmed Mohamed',
      coachRole: 'Coach',
      isAlertSet: true,
      cover: AssetUtils.reel,
    ),
    Event(
      date: '17 Mar',
      time: '02.00 - 03.30 PM',
      title: 'Mastering Productivity',
      description:
          'Learn practical strategies to boost efficiency, manage time effectively, and achieve your goals with expert insights.',
      coachName: 'Ahmed Mohamed',
      coachRole: 'Coach',
      isAlertSet: false,
      cover: AssetUtils.reel,
    ),
    Event(
      date: '17 Mar',
      time: '02.00 - 03.30 PM',
      title: 'Mastering Productivity',
      description:
          'Learn practical strategies to boost efficiency, manage time effectively, and achieve your goals with expert insights.',
      coachName: 'Ahmed Mohamed',
      coachRole: 'Coach',
      isAlertSet: false,
      cover: AssetUtils.reel,
    ),
  ];
  final bool isSubscribe = true; //TODO for non subscribe will use this

  void toggleAlert(int index) {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const CustomText('Events'),
        actions: [
          IconButton(
            icon: const Icon(Icons.calendar_today_outlined),
            onPressed: ()=>Zap.toNamed(AppRoutes.eventCalendarScreen),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: 3,
        itemBuilder: (context, index) {
          final event = upComingEvents[index];
          if (!isSubscribe) {
            return NonSubscribeEventItemWidget(
              event: event,
            );
          } else {
            return SubscribeEventItemWidget(
              event: event,
            );
          }
        },
      ),
    );
  }
}

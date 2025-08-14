import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:tcw/core/shared/shared_widget/custom_text.dart';
import 'package:tcw/features/event/presentation/cubit/event_cubit.dart';
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
  final bool isSubscribe = true;

  @override
  void initState() {
    super.initState();
    context.read<EventCubit>().getEvents();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(tr('events')), // localized
        actions: [
          IconButton(
            icon: const Icon(Icons.calendar_today_outlined),
            onPressed: () => Zap.toNamed(AppRoutes.eventCalendarScreen),
          ),
        ],
      ),
      body: BlocBuilder<EventCubit, EventState>(
        builder: (context, state) {
          if (state is EventLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is EventLoaded) {
            final events = state.event.data;
            if (events.isEmpty) {
              return Center(child: Text(tr('no_events_found')));
            }
            return ListView.builder(
              itemCount: events.length,
              itemBuilder: (context, index) {
                final eventItem = events[index];
                return isSubscribe
                    ? SubscribeEventItemWidget(event: eventItem)
                    : NonSubscribeEventItemWidget(event: eventItem);
              },
            );
          } else if (state is EventError) {
            return Center(child: Text('${tr('error')}: ${state.message}'));
          } else {
            return Center(child: Text(tr('something_went_wrong')));
          }
        },
      ),
    );
  }
}

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  bool _isLoading = true;

  void toggleAlert(int index) {
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 12), () {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const CustomText('Events'),
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
            if (_isLoading) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text('Something went wrong or took too long.'),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _isLoading = true;
                        });
                        context.read<EventCubit>()..getEvents();
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
          } else if (state is EventLoaded) {
            if (state.event.data.isEmpty) {
              return const Center(child: Text('No Events found.'));
            }

            final allEvents = state.event.data;

            return ListView.builder(
              itemCount: allEvents.length,
              itemBuilder: (context, index) {
                final eventItem = allEvents[index];
                return isSubscribe
                    ? SubscribeEventItemWidget(event: eventItem)
                    : NonSubscribeEventItemWidget(event: eventItem);
              },
            );
          } else if (state is EventError) {
            return Center(child: Text('Error: ${state.message}'));
          } else {
            return const Center(child: Text('Something went wrong.'));
          }
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:tcw/core/shared/shared_widget/custom_button.dart';
import 'package:tcw/features/event/presentation/widgets/calendar_daily_schedule_widget.dart';
import 'package:tcw/features/event/presentation/widgets/calendart_date_selector_widget.dart';
import 'package:zap_sizer/zap_sizer.dart';

class EventCalendarScreen extends StatefulWidget {
  const EventCalendarScreen({super.key});

  @override
  State<EventCalendarScreen> createState() => _EventCalendarScreenState();
}

class _EventCalendarScreenState extends State<EventCalendarScreen> {
  final List<String> filterOption = ['Week', 'Month'];
  String selectedFilterName = 'Week';
  int selectedDay = DateTime.now().day;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisSize: MainAxisSize.min,
            children: filterOption
                .map((e) => Flexible(
                      child: CustomButton(
                        title: e,
                        radius: 8,
                        style: TextStyle(
                          color: selectedFilterName == e
                              ? Colors.white
                              : Colors.black,
                        ),
                        backgroundColor: selectedFilterName == e
                            ? Colors.black
                            : Colors.transparent,
                        width: 10.w,
                        onPressed: () {
                          setState(() {
                            selectedFilterName = e;
                          });
                        },
                      ),
                    ))
                .toList(),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {},
            ),
          ],
        ),
        body: ListView(
          children: [
            WeekDaysSelector(
              byMonth: selectedFilterName == 'Month',
              selectedDay: DateTime.now(),
              onDaySelected: (selectedDate) {
                selectedDay = selectedDate.day;
                setState(() {});
              },
            ),
           const DailyScheduleWidget()
          ],
        ));
  }
}

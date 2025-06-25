import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tcw/core/shared/shared_widget/custom_container.dart';
import 'package:tcw/core/shared/shared_widget/custom_text.dart';
import 'package:tcw/core/theme/app_colors.dart';
import 'package:zap_sizer/zap_sizer.dart';
import 'package:zapx/zapx.dart';

final weekDayNames = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];

class WeekDaysSelector extends StatelessWidget {
  const WeekDaysSelector(
      {super.key,
      required this.selectedDay,
      required this.onDaySelected,
      required this.byMonth});
  final bool byMonth;
  final DateTime selectedDay;
  final Function(DateTime) onDaySelected;

  List<DateTime> _getCurrentWeekDates() {
    final now = DateTime.now();
    final startOfWeek = now.subtract(Duration(days: now.weekday % 7));
    return List.generate(7, (i) => startOfWeek.add(Duration(days: i)));
  }

  int _dummyEventsForDay(DateTime date) {
    return (date.day % 4);
  }

  Color _colorForIndex(int index) {
    switch (index % 3) {
      case 0:
        return Colors.green;
      case 1:
        return Colors.orange;
      case 2:
        return Colors.purple;
      default:
        return Colors.blue;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (byMonth) {
      final firstDayOfMonth = DateTime(selectedDay.year, selectedDay.month, 1);
      final firstWeekday = firstDayOfMonth.weekday % 7;
      final daysBefore = firstWeekday;
      final totalDays =
          DateUtils.getDaysInMonth(selectedDay.year, selectedDay.month);
      final totalItems = ((daysBefore + totalDays) / 7).ceil() * 7;
      final today = DateTime.now();

      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(7, (index) {
                return Expanded(
                  child: Center(
                    child: CustomText(
                      weekDayNames[index],
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                );
              }),
            ),
          ),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.all(16),
            itemCount: totalItems,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemBuilder: (context, index) {
              final date = DateTime(selectedDay.year, selectedDay.month, 1)
                  .add(Duration(days: index - daysBefore));
              final isFromCurrentMonth = date.month == selectedDay.month;
              final isToday = date.day == today.day &&
                  date.month == today.month &&
                  date.year == today.year;

              return GestureDetector(
                onTap: () {
                  if (isFromCurrentMonth) {
                    onDaySelected(date);
                  }
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 2,
                  children: [
                    CustomContainer(
                      width: 8.w,
                      height: 3.h,
                      padding: 0,
                      isCircle: isToday,
                      gradient: isToday
                          ? const LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Color(0xFF175941),
                                Color(0xFFB7924F),
                              ],
                            )
                          : null,
                      child: CustomText(
                        '${date.day}',
                        textAlign: TextAlign.center,
                        color: isFromCurrentMonth
                            ? isToday
                                ? Colors.white
                                : Colors.black87
                            : Colors.grey.shade400,
                        fontWeight:
                            isToday ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                    if (isFromCurrentMonth)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: List.generate(
                          _dummyEventsForDay(date),
                          (i) => CustomContainer(
                            width: 3,
                            height: 3,
                            margin: const EdgeInsets.symmetric(horizontal: 1),
                            color: _colorForIndex(i),
                            isCircle: true,
                          ),
                        ),
                      ),
                  ],
                ),
              );
            },
          ),
        ],
      );
    }
    final weekDays = _getCurrentWeekDates();

    return SizedBox(
      height: 12.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: weekDays.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final date = weekDays[index];
          final isSelected = date.day == selectedDay.day &&
              date.month == selectedDay.month &&
              date.year == selectedDay.year;
          return GestureDetector(
            onTap: () => onDaySelected(date),
            child: CustomContainer(
              width: 13.w,
              padding: isSelected ? 0 : 3,
              color: isSelected ? null : AppColors.greyWhiteColor,
              gradient: isSelected ? AppColors.cardGradient : null,
              borderRadius: 24,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomText(
                    DateFormat.E().format(date),
                    color: isSelected ? Colors.white : Colors.black,
                    fontWeight: isSelected ? FontWeight.w700 : FontWeight.w400,
                  ).paddingOnly(top: 10),
                  const Spacer(),
                  CustomContainer(
                    borderRadius: 24,
                    padding: 10,
                    width: 13.w,
                    height: 7.h,
                    color: isSelected ? AppColors.greyWhiteColor : Colors.white,
                    child: CustomText(
                      date.day.toString(),
                      textAlign: TextAlign.center,
                      fontWeight:
                          isSelected ? FontWeight.w700 : FontWeight.w400,
                      color: isSelected
                          ? const Color.fromRGBO(5, 23, 66, 1)
                          : null,
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

import 'package:easy_localization/easy_localization.dart';
import 'package:zapx/zapx.dart';

extension DateExtensions on DateTime{
  ///[formatDateByYears] format date time by year (if in current year will show day name and number , other)
   String get formatDateByYears {
  final now = DateTime.now();

  if (year == now.year) {
    final datePart = DateFormat('d MMMM', Zap.context.locale.toString()).format(this);
    final timePart = DateFormat('h:mm a', Zap.context.locale.toString()).format(this);
    return '$datePart, $timePart';
  } else {
    return DateFormat('dd/MM/yyyy', Zap.context.locale.toString()).format(this);
  }
}
}
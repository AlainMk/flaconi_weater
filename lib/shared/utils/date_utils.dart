import 'package:intl/intl.dart';

extension DateFormatter on DateTime {
  String get dayOfWeekOrRelative {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final tomorrow = today.add(const Duration(days: 1));

    if (year == today.year && month == today.month && day == today.day) {
      return "Today";
    } else if (year == tomorrow.year && month == tomorrow.month && day == tomorrow.day) {
      return "Tomorrow";
    } else {
      return DateFormat('EEEE').format(this); // Returns day of the week
    }
  }

  String get shortDayOfWeek {
    return DateFormat('EEE').format(this);
  }
}

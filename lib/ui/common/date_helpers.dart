import 'package:intl/intl.dart';

class DateHelpers {
  static String formatEventDate(DateTime date) {
    return DateFormat('EEE dd MMM, HH:mm')
        .format(date); // e.g. "THU 26 May, 09:00"
  }

  static String formatShortDate(DateTime date) {
    return DateFormat('MMM d').format(date); // e.g. "May 26"
  }

  static String formatFullDate(DateTime date) {
    return DateFormat('EEEE, MMMM d, y')
        .format(date); // e.g. "Thursday, May 26, 2023"
  }

  static String formatTime(DateTime date) {
    return DateFormat('HH:mm').format(date); // e.g. "09:00"
  }

  static String formatRelativeDate(DateTime date) {
    final now = DateTime.now();
    final difference = date.difference(now);
    final days = difference.inDays;

    if (days == 0) {
      if (difference.inHours > 0) {
        return 'In ${difference.inHours}h';
      } else if (difference.inMinutes > 0) {
        return 'In ${difference.inMinutes}m';
      } else {
        return 'Now';
      }
    } else if (days == 1) {
      return 'Tomorrow ${formatTime(date)}';
    } else if (days == -1) {
      return 'Yesterday ${formatTime(date)}';
    } else if (days > 0 && days < 7) {
      return '${DateFormat('EEEE').format(date)} ${formatTime(date)}';
    } else if (days < 0 && days > -7) {
      return 'Last ${DateFormat('EEEE').format(date)}';
    } else {
      return formatEventDate(date);
    }
  }

  static String formatDateRange(DateTime start, DateTime end) {
    if (start.year == end.year) {
      if (start.month == end.month) {
        if (start.day == end.day) {
          return '${formatFullDate(start)} ${formatTime(start)} - ${formatTime(end)}';
        }
        return '${DateFormat('MMMM d').format(start)} - ${DateFormat('d, y').format(end)}';
      }
      return '${DateFormat('MMMM d').format(start)} - ${DateFormat('MMMM d, y').format(end)}';
    }
    return '${formatFullDate(start)} - ${formatFullDate(end)}';
  }

  static String formatDuration(Duration duration) {
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);

    if (hours > 0) {
      return '${hours}h${minutes > 0 ? ' ${minutes}m' : ''}';
    } else {
      return '${minutes}m';
    }
  }

  static String getRemainingTime(DateTime endTime) {
    final now = DateTime.now();
    final difference = endTime.difference(now);

    if (difference.isNegative) {
      return 'Ended';
    }

    final days = difference.inDays;
    final hours = difference.inHours.remainder(24);
    final minutes = difference.inMinutes.remainder(60);

    if (days > 0) {
      return '$days day${days > 1 ? 's' : ''} left';
    } else if (hours > 0) {
      return '$hours hour${hours > 1 ? 's' : ''} left';
    } else {
      return '$minutes minute${minutes > 1 ? 's' : ''} left';
    }
  }

  static bool isEventLive(DateTime startTime, DateTime endTime) {
    final now = DateTime.now();
    return now.isAfter(startTime) && now.isBefore(endTime);
  }

  static bool isUpcoming(DateTime startTime) {
    return startTime.isAfter(DateTime.now());
  }

  static bool isPast(DateTime endTime) {
    return endTime.isBefore(DateTime.now());
  }
}

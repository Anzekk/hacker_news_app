import 'package:intl/intl.dart';

class DateTimeHelper {
  static const String formatDefault = 'd. M. yyyy HH:mm';

  static DateTime convertIntToDate(int number) {
    return DateTime.fromMillisecondsSinceEpoch(number * 1000, isUtc: true);
  }

  static String formattedDateString(DateTime dateTime, String format) {
    return DateFormat(format).format(dateTime);
  }

  static String getArticleDate(DateTime dateTime) {
    DateTime now = DateTime.now();
    Duration duration = now.difference(dateTime);
    if (duration.inDays > 7) {
      return formattedDateString(dateTime, formatDefault);
    } else if (duration.inDays > 1) {
      return '${duration.inDays} days ago';
    } else if (duration.inHours > 24) {
      return '${duration.inDays} day ago';
    } else if (duration.inHours > 1) {
      return '${duration.inHours} hours ago';
    } else if (duration.inMinutes > 60) {
      return '${duration.inHours} hour ago';
    } else if (duration.inMinutes > 1) {
      return '${duration.inMinutes} minutes ago';
    } else {
      return 'just now';
    }
  }
}

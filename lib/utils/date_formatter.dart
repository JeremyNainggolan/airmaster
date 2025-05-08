import 'package:intl/intl.dart';

class DateFormatter {
  static String convertDateTimeDisplay(
    String date, [
    String format = "dd-MMMM-yyyy",
  ]) {
    final DateFormat displayFormater = DateFormat('yyyy-MM-dd HH:mm:ss.SSS');
    final DateFormat serverFormater = DateFormat(format);
    final DateTime displayDate = displayFormater.parse(date);
    final String formatted = serverFormater.format(displayDate);
    return formatted;
  }
}

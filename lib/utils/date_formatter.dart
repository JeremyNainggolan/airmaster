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

  static DateTime getCurrentDateWithoutTime() {
    DateTime now = DateTime.now();
    return DateTime(now.year, now.month, now.day);
  }

  static DateTime convertToDate(String input, String format) {
    try {
      final formatter = DateFormat(format);
      return formatter.parseStrict(input);
    } catch (e) {
      throw FormatException(
        "Gagal mengonversi '$input' ke DateTime dengan format '$format': $e",
      );
    }
  }
}

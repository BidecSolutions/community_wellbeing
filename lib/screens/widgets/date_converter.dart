
import 'package:intl/intl.dart';

class DateUtils {
  static String formatDateString(String isoDateString) {
    try {
      final dateTime = DateTime.parse(isoDateString);
      return DateFormat('dd-MMM yyyy').format(dateTime);
    } catch (e) {
      return '';
    }
  }
}
import '../../core.dart';

final class DateTimeUtils {
  const DateTimeUtils._();

  static String formatDate(DateTime date) {
    return DateFormat.yMMMMd().format(date);
  }
}

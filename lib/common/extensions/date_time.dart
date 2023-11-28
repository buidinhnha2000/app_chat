import 'package:intl/intl.dart';

class ChatDateTime {
  static const DATE_FORMAT_MM_YYYY = 'MM-yyyy';
  static const TIME_FORMAT_HH_MM = 'HH:mm';
  static const DATE_FORMAT_YYYY_MM_DD = 'yyyy-MM-dd';
  static const DATE_TIME_FORMAT_YYYY_MM_DD_HH_MM_SS = 'yyyy-MM-dd HH:mm:ss';
  static const DATE_TIME_FORMAT_YYYY_MM_DD_HH_MM = 'yyyy-MM-dd HH:mm';
  static DateTime dayNow = DateTime.now();
}

extension DateTimeX on DateTime {
  String get formattedHour => DateFormat(ChatDateTime.TIME_FORMAT_HH_MM).format(this);

  String get formattedDate => DateFormat(ChatDateTime.DATE_FORMAT_YYYY_MM_DD).format(this);

  String get formattedMonth => DateFormat(ChatDateTime.DATE_FORMAT_MM_YYYY).format(this);

  String get formattedFull => DateFormat(ChatDateTime.DATE_TIME_FORMAT_YYYY_MM_DD_HH_MM_SS).format(this);

  String get formattedMinute => DateFormat(ChatDateTime.DATE_TIME_FORMAT_YYYY_MM_DD_HH_MM).format(this);

  String getFormattedDate() => DateFormat(ChatDateTime.DATE_FORMAT_YYYY_MM_DD).format(this);

  String getFormattedTime() => DateFormat(ChatDateTime.TIME_FORMAT_HH_MM).format(this);

  DateTime getDefaultDueDate({int hour = 23, int minute = 59}) => DateTime(year, month, day, hour, minute);
}

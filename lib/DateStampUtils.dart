import 'dart:io';

class DateStampUtils {

  static String getNowDate() {
    DateTime now = DateTime.now();
    return '${now.year}-${now.month}-${now.day} ${now.hour}:${now.minute}:${now.second}';
  }

  static DateTime stringToDate(String dateString) {
    DateTime date;
    try {
      date = DateTime.parse(dateString);
    } catch (e) {
      print('Invalid date string: $dateString');
      exit(1);
    }
    return date;
  }

  static int getTimeStamp() {
    return DateTime.now().millisecondsSinceEpoch;
  }
}

void main() {
  // 現在の日付を取得します。
  print(DateStampUtils.getNowDate());
  print(DateStampUtils.getTimeStamp());
  print(DateStampUtils.stringToDate('2021-10-10 10:10:10'));
}
import 'dart:io';

/// 日付関連のユーティリティクラスです。
class DateStampUtils {

  /// 現在の日付を取得します。
  ///
  /// @return 現在の日付の文字列（"yyyy-MM-dd HH:mm:ss"形式）
  static String getNowDate() {
    DateTime now = DateTime.now();
    return '${now.year}-${now.month}-${now.day} ${now.hour}:${now.minute}:${now.second}';
  }

  /// 文字列を日付に変換します。
  ///
  /// @param dateString 変換する日付の文字列（"yyyy-MM-dd HH:mm:ss"形式）
  /// @return 変換された日付
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

  /// 現在のタイムスタンプを取得します。
  ///
  /// @return 現在のタイムスタンプ（ミリ秒単位）
  static int getTimeStamp() {
    return DateTime.now().millisecondsSinceEpoch;
  }
}

void main() {
  // 現在の日付を取得します。
  print(DateStampUtils.getNowDate());
  // 現在のタイムスタンプを取得します。
  print(DateStampUtils.getTimeStamp());
  // 文字列を日付に変換します。
  print(DateStampUtils.stringToDate('2021-10-10 10:10:10'));
}

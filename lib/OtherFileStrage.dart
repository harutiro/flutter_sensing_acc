// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'dart:core';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

/// 配列にデータを格納し、CSVファイルとして保存する機能を提供するクラスです。
class OtherFileStorage {

  /// ファイルにデータを追記するかどうかを指定します（trueの場合は追記、falseの場合は上書き）。
  bool fileAppend = true; // true=追記, false=上書き
  /// CSVファイルの名前を指定します。
  late String fileName = 'SensorLog';
  /// CSVファイルの拡張子を指定します。
  late String extension = '.csv';
  /// CSVファイルのパスを指定します。
  late String filePath;
  /// データ配列の次元数を指定します。
  int dimension = 3;

  /// [OtherFileStorage]クラスのインスタンスを作成します。
  ///
  /// [fileAppend]パラメータは既存のファイルにデータを追記するかどうかを指定します（trueの場合は追記、falseの場合は上書き）。
  /// [fileName]パラメータはCSVファイルの名前を指定します。
  /// [dimension]パラメータはデータ配列の次元数を指定します。
  OtherFileStorage(
      this.fileAppend,
      this.fileName,
      this.dimension,
  ) {
    init();
  }

  /// [OtherFileStorage]インスタンスを初期化します。
  ///
  /// このメソッドは必要なファイルパスを設定し、CSVファイルにヘッダーラインを書き込みます。
  Future<void> init() async {
    final appDocumentsDirectory = await getApplicationDocumentsDirectory();
    filePath = '${appDocumentsDirectory.path}/$fileName$extension';
    print('filePath: $filePath');
    writeText(firstLog(dimension), filePath);
  }

  /// ログエントリをCSVファイルに書き込みます。
  ///
  /// [text]パラメータは記録するデータを表します。
  void doLog(String text) {
    writeText(text, filePath);
  }

  /// 次元に基づいてCSVファイルのヘッダーラインを生成します。
  ///
  /// [dimension]パラメータはデータ配列の次元数を指定します。
  /// ヘッダーラインの文字列を返します。
  String firstLog(int dimension) {
    switch (dimension) {
      case 1:
        return 'time,x';
      case 2:
        return 'time,x,y';
      case 3:
        return 'time,x,y,z';
      default:
        var result = 'time';
        for (var i = 0; i < dimension; i++) {
          result += ',$i';
        }
        return result;
    }
  }

  /// 指定されたテキストを指定されたファイルパスに書き込みます。
  ///
  /// [text]パラメータは書き込むデータを表します。
  /// [path]パラメータはデータを書き込むファイルパスを指定します。
  Future<void> writeText(String text, String path) async {
    final file = File(path);
    final sink = file.openWrite(mode: fileAppend ? FileMode.append : FileMode.write);
    sink.writeln(text);
    await sink.flush();
    await sink.close();
  }
}

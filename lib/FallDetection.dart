import 'dart:math';

class FallDetection {
  List<double> normData = [];
  double threshold = 9.8; // 閾値

  bool addAccelerationData(double x, double y, double z) {
    // ノルムの計算
    double norm = calculateNorm(x, y, z);
    // print('norm: $norm');

    // ノイズ除去処理
    norm = noiseRemoval(norm);
    print('norm(noise removal): $norm');

    // ノルムデータの追加
    normData.add(norm);
    print('normData: ${normData.length}');

    // 最新のデータを含む5つのノルムデータを使用して降ったかどうかを判定
    if (normData.length >= 5) {
      bool isFalling = norm >= threshold;
      if (isFalling) {
        // 降った場合の処理
        return true;
      }else{
        return false;
      }
    }else{
      return false;
    }
  }

  double calculateNorm(double x, double y, double z) {
    // ノルムの計算
    return sqrt(x * x + y * y + z * z);
  }

  double noiseRemoval(double norm) {
    // ノイズ除去処理の実装（過去の5つのデータの平均値を使用）
    if (normData.length >= 5) {
      double sum = norm;
      for (int i = normData.length - 4; i < normData.length; i++) {
        sum += normData[i];
      }
      double average = sum / 5;
      return average;
    } else {
      return norm;
    }
  }
}
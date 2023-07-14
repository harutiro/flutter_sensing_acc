import 'package:flutter/material.dart';
import 'package:flutter_sensing_acc/DateStampUtils.dart';
import 'package:flutter_sensing_acc/FallDetection.dart';
import 'package:flutter_sensing_acc/OtherFileStrage.dart';
import 'package:sensors_plus/sensors_plus.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '加速度センサー',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: '加速度センサー'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

// mainメソッド,MyApp,MyHomePageはデフォルトから変更がないため省略
class _MyHomePageState extends State<MyHomePage> {

  /// ファイルを書き込むシステムを作成
  OtherFileStorage? ofs;
  FallDetection? fd;

  /// 加速度センサーの値を格納する変数
  String _userAccelerometerValues = "";

  /// ファイル名を格納する変数
  String fileName = "";

  /// ログを記録するかどうかを格納する変数
  bool _isLogging = false;

  /// 今振っているかどうかを格納する変数
  bool _isShaking = false;

  void createFileSaveObject(bool value){
    if(value){
      // ファイル名を作成
      setState((){
        fileName = "${DateStampUtils.getNowDate()}_SensorLog";;
      });
      ofs = OtherFileStorage(true, fileName, 3);
      fd = FallDetection();

    }else{
      ofs = null;
      fd = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Text(_userAccelerometerValues,
              style: Theme.of(context).textTheme.headline6
          ),
          Text(_isShaking ? '振っている' : '振っていない',
              style: Theme.of(context).textTheme.headline6
          ),
          Text(fileName,
              style: Theme.of(context).textTheme.headline6,
          ),
          SwitchListTile(
              value: _isLogging,
              onChanged: (value){
                setState(() {
                  createFileSaveObject(value);
                  _isLogging = value;
                });
              },
              title: const Text('ログを記録する')
          ),
        ],
      ));
  }

  @override
  void initState() {
    super.initState();

    // 加速度センサーの値を取得
    userAccelerometerEvents.listen( (UserAccelerometerEvent event) {
      setState(() {
        _userAccelerometerValues = "加速度センサー\n${event.x}\n${event.y}\n${event.z}";
      });

      _isShaking = fd?.addAccelerationData(event.x, event.y, event.z) ?? false;
      ofs?.doLog('${DateStampUtils.getTimeStamp()},${event.x},${event.y},${event.z}');
    });
  }
}
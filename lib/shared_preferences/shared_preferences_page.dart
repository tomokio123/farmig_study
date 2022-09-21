import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
//keybordVisiblyを使ってみた
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

class SharedPreferencesPage extends StatelessWidget {
  const SharedPreferencesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'shared_preferencesの使い方',
      theme: ThemeData.dark(),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // インスタンスの生成
  final prefs = SharedPreferences.getInstance();
  //TextField を作る時はcontrollerオブジェクトにTextEditingController()クラスをぶち込む
  final controller = TextEditingController();

  //保存したい値を入れる変数valueの初期値は空白にしておく
  String value = '';
  @override
  void initState() {
    super.initState();
    init();
  }

  // 画面起動時に読み込むメソッド
  void init() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      //　データの読み込み
      value = prefs.getString('str')!;
      // keyboardオブジェクト設置。インスタンス詰める
      var keyboard = KeyboardVisibilityController();

      //以下１行でインスタンス変数を呼び出す。ここで渡すコールバックとしては、
      //keyboardVisiblyからtrueが送られてきたら特に作動せず、
      //入力欄では無いところに遷移していたら(!visible=falseなら)if内の処理が起動してunfocus()になる
      keyboard.onChange.listen((visible) {
        if (!visible) {
          FocusScope.of(context).unfocus();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('shared_preferences')),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            // 保存されたデータが表示される
            Text('表示してみる'),
            Text(value, style: const TextStyle(fontSize: 40.0)),
            TextField(
              controller: controller,
              decoration: const InputDecoration(
                  hintText: 'このもじはヒントテキストです',
                hintStyle: TextStyle(color: Colors.white)
              ),
            ),
            const SizedBox(height: 30.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    final prefs = await SharedPreferences.getInstance();
                    //　データの保存
                    prefs.setString('string', controller.text);
                  },
                  child: const Text('Save'),
                ),
                ElevatedButton(
                  onPressed: () async {
                    final prefs = await SharedPreferences.getInstance();
                    setState(() {
                      // データの読み込み
                      value = prefs.getString('string')!;
                    });
                  },
                  child: const Text('Load'),
                ),
                ElevatedButton(
                  onPressed: () async {
                    final prefs = await SharedPreferences.getInstance();
                    setState(() {
                      value = '';
                      controller.text = '';
                      // データの削除
                      prefs.remove('');
                    });
                  },
                  child: const Text('Clear'),
                ),
              ],
            ),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
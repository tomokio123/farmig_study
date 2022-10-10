import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class APIPage extends StatefulWidget {
  const APIPage({Key? key}) : super(key: key);

  @override
  _APIPageState createState() => _APIPageState();
}

class _APIPageState extends State<APIPage> {
  List items = [];

  Future<void> getData() async {//APIデータを得るメソッド
    //APIから返ってきたレスポンスデータを格納する変数responceを作成
    var response = await http.get(Uri.https(//GETメソッド:リソース取得
        'www.googleapis.com',//arg1:host
        '/books/v1/volumes',//arg2:PAth
        {'q': '{Flutter}', 'maxResults': '40', 'langRestrict': 'ja'}));
      //arg3:Query(Jsonのオブジェクト)

    var jsonResponse = jsonDecode(response.body);//レスポンスのボディを

    setState(() {
      items = jsonResponse['items'];
    });
  }

  @override
  void initState() {
    super.initState();

    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Sample'),
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child: Column(
              children: <Widget>[
                ListTile(
                  leading: Image.network(
                    items[index]['volumeInfo']['imageLinks']['thumbnail'],
                  ),
                  title: Text(items[index]['volumeInfo']['title']),
                  subtitle: Text(items[index]['volumeInfo']['publishedDate']),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

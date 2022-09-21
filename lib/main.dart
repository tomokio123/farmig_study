import 'package:farmig_study/shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

import 'MethodChannel/methodchannel.dart';
//import 'user.dart';

void main() {
  runApp(const SharedPreferences());
}

/*void main() {
  //methodCannnelのサンプルコード
  runApp(const MyApp());
}*/

/*
void main() {
//Freezedのサンプルコード
  // ユーザを3つ作成する。user1とuser3は同じ内容
  User user1 = User('kazutxt', 30);
  User user2 = User('FakeName', 0);
  User user3 = User('kazutxt', 30);

  // 表示(toString)のテスト
  print("toStringのテスト");
  print(user1);

  // 比較(==)のテスト
  print("比較のテスト");
  if (user1 == user2) print("user1とuser2は同じ人"); // 表示されない
  if (user1 == user3) print("user1とuser3は同じ人"); // 表示される

  // コピーをして新しいインスタンスを作るテスト
  print("コピーのテスト");
  User user4 = user1.copyWith(name: "unknown"); //ageはuser1のまま
  print(user4);

  // 代入そのものはOK
  print("代入のテスト");
  user2 = user3;
  print(user2); // user3の情報が表示される

  // immutableを破壊するので、以下のような使い方はNG
  // user1.name = "unknown";}
}
*/


import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'user.freezed.dart';

@freezed
class User with _$User {
  const factory User(String name, int age) = _User;
}
//futter pub run build_runner build --delete-conflicting-outputs　をコマンドで叩くと、@freezedを自動的に探して、user.user.dart を生成してくれる。
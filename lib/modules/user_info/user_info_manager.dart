import 'package:flutter/material.dart';

final class UserInfoManager extends ChangeNotifier{
  UserInfoManager._();
  static final UserInfoManager _instance = UserInfoManager._();
  factory UserInfoManager() => _instance;

  int routeCount = 0;

  int _gold = 0;
  int get gold => _gold;

  go(){
    routeCount++;
  }
}

import 'dart:async';

import 'package:flutter/material.dart';

final class GlobalTimer with ChangeNotifier{
  static final GlobalTimer _instance = GlobalTimer._internal();
  factory GlobalTimer() => _instance;
  GlobalTimer._internal();

  Timer? _timer;
  int _seconds = 0;
  bool _isRunning = false;

  int get seconds => _seconds;
  bool get isRunning => _isRunning;

  void start() {
    if (_isRunning) return;
    _isRunning = true;
    _timer = Timer.periodic(Duration(seconds: 1), (_) {
      _seconds++;
      notifyListeners(); // 通知所有监听者
    });
  }

  void stop() {
    _timer?.cancel();
    _isRunning = false;
    notifyListeners();
  }

  void reset() {
    stop();
    _seconds = 0;
    notifyListeners();
  }
}

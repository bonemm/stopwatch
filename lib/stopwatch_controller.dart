import 'dart:async';

import 'package:flutter/material.dart';

class StopwatchController with ChangeNotifier {
  final Stopwatch _stopwatch = Stopwatch();
  Timer? _timer;
  String _elapsedTime = '00:00.00';
  final String _appBarTextStart = 'Tap to start';
  final String _appBarTextPause = 'Tap to pause';

  String get time => _elapsedTime;
  String get appBarText => _stopwatch.isRunning ? _appBarTextPause : _appBarTextStart;

  void startTimer() {
    _stopwatch.start();
    _timer = Timer.periodic(const Duration(milliseconds: 10), (Timer t) {
      _updateTimer();
    });
  }

  void resetTimer() {
    _stopwatch.stop();
    _stopwatch.reset();
    _timer?.cancel();
    _updateTimer();
  }

  void stopTimer() {
    _stopwatch.stop();
    _timer?.cancel();
    _updateTimer();
  }

  void _updateTimer() {
    _elapsedTime = _formatTime(_stopwatch.elapsedMilliseconds);
    notifyListeners();
  }

  String _formatTime(int milliseconds) {
    int hundreds = (milliseconds / 10).truncate();
    int seconds = (hundreds / 100).truncate();
    int minutes = (seconds / 60).truncate();
    int hours = (minutes / 60).truncate();

    minutes = minutes % 60;
    seconds = seconds % 60;

    String minutesStr = minutes.toString().padLeft(2, '0');
    String secondsStr = seconds.toString().padLeft(2, '0');
    String hundredsStr = (hundreds % 100).toString().padLeft(2, '0');

    if (hours != 0) {
      String hoursStr = hours.toString().padLeft(2, '0');
      return '$hoursStr:$minutesStr:$secondsStr.$hundredsStr';
    }
    return '$minutesStr:$secondsStr.$hundredsStr';
  }
}

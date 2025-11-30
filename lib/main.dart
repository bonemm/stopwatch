import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:stopwatch/stopwatch_screen.dart';
import 'package:stopwatch/stopwatch_controller.dart';
import 'package:stopwatch/theme_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final themeService = await ThemeService.instance;
  final controller = StopwatchController();
  var initTheme = themeService.initial;
  runApp(MainApp(initTheme: initTheme, controller: controller));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key, required this.initTheme, required this.controller});
  final ThemeData initTheme;
  final StopwatchController controller;
  @override
  Widget build(BuildContext context) {
    return ThemeProvider(
      initTheme: initTheme,
      builder: (context, theme) => MaterialApp(
        theme: theme,
        debugShowCheckedModeBanner: false,
        home: StopWatchScreen(controller: controller),
      ),
    );
  }
}

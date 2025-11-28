import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:stopwatch/stopwatch_screen.dart';
import 'package:stopwatch/stopwatch_controller.dart';
import 'package:stopwatch/theme_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final themeService = await ThemeService.instance;
  var initTheme = themeService.initial;
  runApp(
    MainApp(
      initTheme: initTheme,
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key, required this.initTheme});
  final ThemeData initTheme;
  @override
  Widget build(BuildContext context) {
    return ThemeProvider(
      initTheme: initTheme,
      builder: (context, theme) => MaterialApp(
        theme: theme,
        debugShowCheckedModeBanner: false,
        home: StopWatchScreen(controller: StopwatchController()),
      ),
    );
  }
}

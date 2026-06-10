import 'package:flutter/material.dart';
import 'package:stopwatch/stopwatch_screen.dart';
import 'package:stopwatch/stopwatch_controller.dart';
import 'package:stopwatch/theme_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final themeService = await ThemeService.instance;
  final controller = StopwatchController();
  runApp(MainApp(themeService: themeService, controller: controller));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key, required this.themeService, required this.controller});
  final ThemeService themeService;
  final StopwatchController controller;
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeService.themeMode,
      builder: (context, themeMode, _) => MaterialApp(
        theme: lightTheme,
        darkTheme: darkTheme,
        themeMode: themeMode,
        debugShowCheckedModeBanner: false,
        home: StopWatchScreen(controller: controller),
      ),
    );
  }
}

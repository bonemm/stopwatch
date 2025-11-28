import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:stopwatch/stopwatch_controller.dart';
import 'package:stopwatch/theme_service.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

class StopWatchScreen extends StatefulWidget {
  const StopWatchScreen({super.key, required this.controller});

  final StopwatchController controller;

  @override
  State<StopWatchScreen> createState() => _StopWatchScreenState();
}

class _StopWatchScreenState extends State<StopWatchScreen> {
  bool isTimerOn = false;

  @override
  void initState() {
    super.initState();
    WakelockPlus.enable();
  }

  void _onTap() {
    isTimerOn = !isTimerOn;

    if (isTimerOn) {
      widget.controller.startTimer();
    } else {
      widget.controller.stopTimer();
    }
  }

  @override
  void dispose() {
    WakelockPlus.disable();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: StopWatchAppBar(controller: widget.controller),
      body: GestureDetector(
        onTap: _onTap,
        behavior: HitTestBehavior.opaque,
        child: Center(
          child: ListenableBuilder(
            listenable: widget.controller,
            builder: (context, child) => SizedBox(
              width: 180,
              child: Text(
                widget.controller.time,
                style: TextStyle(fontSize: 40),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class StopWatchAppBar extends StatelessWidget implements PreferredSizeWidget {
  const StopWatchAppBar({super.key, required this.controller});

  final StopwatchController controller;

  @override
  Widget build(BuildContext context) {
    return ThemeSwitchingArea(
      child: AppBar(
        title: ListenableBuilder(
          listenable: controller,
          builder: (context, child) => Text(controller.appBarText),
        ),
        leading: ThemeSwitcher(
          builder: (context) {
            return IconButton(
              onPressed: () async {
                final themeSwitcher = ThemeSwitcher.of(context);
                final nextThemeName = ThemeModelInheritedNotifier.of(context).theme.brightness == Brightness.light
                    ? 'dark'
                    : 'light';
                var themeService = await ThemeService.instance;
                themeService.saveTheme(nextThemeName);
                themeSwitcher.changeTheme(theme: nextThemeName == 'light' ? lightTheme : darkTheme);
              },
              icon: Icon(
                Theme.of(context).brightness == Brightness.dark ? Icons.light_mode : Icons.dark_mode,
                size: 35,
              ),
            );
          },
        ),
        actions: [
          IconButton(
            onPressed: controller.resetTimer,
            icon: Icon(
              Icons.refresh,
              size: 35,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

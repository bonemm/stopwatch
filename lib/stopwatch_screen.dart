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
            builder: (context, child) => Column(
              mainAxisSize: .min,
              children: [
                SizedBox(
                  height: 270,
                  width: 270,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Theme.of(context).primaryColor,
                        width: 4, // Border thickness
                      ),
                    ),
                    child: Center(
                      child: SizedBox(
                        width: 200,
                        child: Text(
                          widget.controller.time,
                          style: TextStyle(fontSize: 40),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 100),
                Text(
                  widget.controller.appBarText,
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500, color: Theme.of(context).primaryColor),
                ),
              ],
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
        centerTitle: true,
        title: Text('Stopwatch'),
        titleSpacing: 0,
        actionsPadding: EdgeInsets.only(right: 6.0),
        leading: Padding(
          padding: const EdgeInsets.only(left: 6.0),
          child: ThemeSwitcher(
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
                icon: Image.asset(
                  'assets/clear-night.png',
                  height: 35,
                  width: 35,
                  color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black,
                ),
              );
            },
          ),
        ),
        actions: [
          IconButton(
            onPressed: controller.resetTimer,
            icon: Image.asset(
              'assets/undo.png',
              height: 35,
              width: 35,
              color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

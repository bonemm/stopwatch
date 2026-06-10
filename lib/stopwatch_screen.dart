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
  @override
  void initState() {
    super.initState();
    WakelockPlus.enable();
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
        onTap: widget.controller.onScreenTap,
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
                        color: Theme.of(context).colorScheme.primary,
                        width: 4, // Border thickness
                      ),
                    ),
                    child: Center(
                      child: SizedBox(
                        width: 200,
                        child: FittedBox(
                          child: Text(
                            widget.controller.time,
                            style: TextStyle(
                              fontSize: 40,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 100),
                Text(
                  widget.controller.appBarText,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).colorScheme.primary,
                  ),
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
    return AppBar(
        centerTitle: true,
        title: Text('Stopwatch'),
        titleSpacing: 0,
        leadingWidth: 56,
        leading: IconButton(
          onPressed: () async {
            final themeService = await ThemeService.instance;
            themeService.toggle();
          },
          icon: Image.asset(
            'assets/clear-night.png',
            height: 35,
            width: 35,
            color: Theme.of(context).brightness == Brightness.dark ? Colors.white : lightAppBarColor,
          ),
        ),
        actions: [
          IconButton(
            onPressed: controller.resetTimer,
            icon: Image.asset(
              'assets/undo.png',
              height: 35,
              width: 35,
              color: Theme.of(context).brightness == Brightness.dark ? Colors.white : lightAppBarColor,
            ),
          ),
        ],
      );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

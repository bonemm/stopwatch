import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeService {
  ThemeService._(this._prefs) {
    final stored = _prefs.getString(_key);
    themeMode = ValueNotifier(_modeFromName(stored));
  }

  static const _key = 'theme';
  final SharedPreferences _prefs;
  static ThemeService? _instance;

  late final ValueNotifier<ThemeMode> themeMode;

  static Future<ThemeService> get instance async {
    return _instance ??= ThemeService._(await SharedPreferences.getInstance());
  }

  /// Toggles between light and dark and persists the choice.
  Future<void> toggle() async {
    final next = themeMode.value == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    themeMode.value = next;
    await _prefs.setString(_key, next == ThemeMode.dark ? 'dark' : 'light');
  }

  static ThemeMode _modeFromName(String? name) {
    return name == 'dark' ? ThemeMode.dark : ThemeMode.light;
  }
}

final _lightColorScheme = ColorScheme.fromSeed(seedColor: Colors.blue);

/// Darker navy used for the app bar title and icons in light mode.
const lightAppBarColor = Color(0xFF1A3A6B);

final lightTheme = ThemeData(
  brightness: Brightness.light,
  colorScheme: _lightColorScheme,
  fontFamily: 'ChivoMono',
  appBarTheme: const AppBarTheme(
    foregroundColor: lightAppBarColor,
    centerTitle: true,
    titleTextStyle: TextStyle(
      fontSize: 26,
      fontWeight: FontWeight.w500,
      color: lightAppBarColor,
    ),
  ),
);

final darkTheme = ThemeData(
  primarySwatch: Colors.deepPurple,
  primaryColor: const Color(0xFFb73f74),
  scaffoldBackgroundColor: const Color(0xFF111314),
  fontFamily: 'ChivoMono',
  brightness: Brightness.dark,
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFF111314),
    foregroundColor: Colors.white,
    titleTextStyle: TextStyle(fontSize: 26, fontWeight: FontWeight.w500, color: Colors.white),
  ),
);

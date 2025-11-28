import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeService {
  ThemeService._();
  static late SharedPreferences prefs;
  static ThemeService? _instance;

  static Future<ThemeService> get instance async {
    if (_instance == null) {
      prefs = await SharedPreferences.getInstance();
      _instance = ThemeService._();
    }
    return _instance!;
  }

  final allThemes = <String, ThemeData>{
    'dark': darkTheme,
    'light': lightTheme,
  };

  ThemeData get initial {
    String? themeName = prefs.getString('theme');
    themeName ??= 'light';
    return allThemes[themeName]!;
  }

  Future<void> saveTheme(String newThemeName) async {
    await prefs.setString('theme', newThemeName);
  }

  ThemeData getByName(String name) {
    return allThemes[name]!;
  }
}

final lightTheme = ThemeData(
  primarySwatch: Colors.teal,
  brightness: Brightness.light,
  scaffoldBackgroundColor: Colors.teal,
  // Define AppBar theme specifically
  appBarTheme: AppBarTheme(backgroundColor: Colors.teal.shade100, foregroundColor: Colors.black),
);

final darkTheme = ThemeData(
  primarySwatch: Colors.deepPurple,
  scaffoldBackgroundColor: Colors.black,
  brightness: Brightness.dark,
  appBarTheme: AppBarTheme(backgroundColor: Colors.deepPurple.shade900, foregroundColor: Colors.white),
);

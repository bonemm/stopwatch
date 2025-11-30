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
  primaryColor: Color(0xFF34454c),
  fontFamily: 'ChivoMono',
  brightness: Brightness.light,
  scaffoldBackgroundColor: Color(0xFFb5decc),
  appBarTheme: AppBarTheme(
    backgroundColor: Color(0xFFb5decc),
    foregroundColor: Colors.black,
    centerTitle: true,
    titleTextStyle: TextStyle(fontSize: 28, fontWeight: FontWeight.w500, color: Color(0xFF34454c)),
  ),
);

final darkTheme = ThemeData(
  primarySwatch: Colors.deepPurple,
  primaryColor: Color(0xFFb73f74),
  scaffoldBackgroundColor: Color(0xFF111314),
  fontFamily: 'ChivoMono',
  brightness: Brightness.dark,
  appBarTheme: AppBarTheme(
    backgroundColor: Color(0xFF111314),
    foregroundColor: Colors.white,
    titleTextStyle: TextStyle(fontSize: 28, fontWeight: FontWeight.w500, color: Colors.white),
  ),
);

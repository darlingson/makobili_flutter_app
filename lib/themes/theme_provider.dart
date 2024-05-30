import 'package:flutter/material.dart';
import 'package:makobili/themes/dark_mode.dart';
import 'package:makobili/themes/light_mode.dart';

class ThemeProvider with ChangeNotifier {
  ThemeData _themeData = lightMode;

  ThemeData get themeData => _themeData;
  bool get isDarkMode => _themeData == darkMode;

  set themeData(ThemeData theme) {
    _themeData = theme;
    notifyListeners();
  }

  void toggleTheme() {
    _themeData = _themeData == darkMode ? lightMode : darkMode;
  }
}

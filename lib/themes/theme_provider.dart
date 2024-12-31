import 'package:flutter/material.dart';

import 'dart_mode.dart';
import 'light_mode.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeData _themeData = lightMode;

  ThemeData get themeData => _themeData; // Renamed getter to avoid conflict

  bool get isDarkMode => _themeData == dartMode;

  set themeData(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }

  void toggleTheme() {
    if (_themeData == lightMode) {
      themeData = dartMode;
    } else {
      themeData = lightMode;
    }
  }
}

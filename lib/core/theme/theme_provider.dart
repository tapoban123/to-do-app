import 'package:flutter/material.dart';
import 'package:simple_todo_app/hive_database/shared_preferences_local_storage.dart';

class ThemeProvider extends ChangeNotifier {
  late ThemeData _currentTheme;
  late String _themeText;
  late bool _isDark;

  String _lightModeText = "Switch to light mode";
  String _darkModeText = "Switch to dark mode";

  ThemeProvider({
    required bool isDark,
  }) {
    _isDark = isDark;
    this._currentTheme = _isDark ? ThemeData.dark() : ThemeData.light();
    this._themeText = _isDark ? _lightModeText : _darkModeText;
  }

  ThemeData get getCurrentTheme => _currentTheme;
  String get themeText => _themeText;

  bool isDarkTheme() {
    if (_currentTheme == ThemeData.dark()) {
      return true;
    } else {
      return false;
    }
  }

  void changeTheme({required bool toDarkTheme}) {
    if (toDarkTheme) {
      _currentTheme = ThemeData.dark();
      _themeText = _lightModeText;
      _isDark = true;
    } else {
      _currentTheme = ThemeData.light();
      _themeText = _darkModeText;
      _isDark = false;
    }

    SharedPreferencesLocalStorage().setTheme(_isDark);
    notifyListeners();
  }
}

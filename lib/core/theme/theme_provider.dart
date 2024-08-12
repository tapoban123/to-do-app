import 'package:flutter/material.dart';
import 'package:simple_todo_app/hive_database/shared_preferences_local_storage.dart';

class ThemeProvider extends ChangeNotifier {
  late ThemeData _currentTheme;
  late bool _isDark;

  ThemeProvider({
    required bool isDark,
  }) {
    _isDark = isDark;
    this._currentTheme = _isDark ? ThemeData.dark() : ThemeData.light();
  }

  ThemeData get getCurrentTheme => _currentTheme;

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
      _isDark = true;
    } else {
      _currentTheme = ThemeData.light();
      _isDark = false;
    }

    SharedPreferencesLocalStorage().setTheme(_isDark);
    notifyListeners();
  }
}

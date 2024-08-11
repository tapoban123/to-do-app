import 'package:flutter/cupertino.dart';
import 'package:simple_todo_app/hive_database/shared_preferences_local_storage.dart';

class ThemeProvider extends ChangeNotifier {
  String _currentTheme = "dark";

  // String get getCurrentTheme => _currentTheme;

  Future<String> getTheme() async {
    String? _theme = await SharedPreferencesLocalStorage().getCurrentTheme();
    print(_theme);

    if (_theme != null) {
      _currentTheme = _theme;
    } else {
      _currentTheme = "dark";
    }

    return _currentTheme;
  }

  void changeTheme() {
    if (_currentTheme == "dark") {
      _currentTheme = "light";
    } else if (_currentTheme == "light") {
      _currentTheme = "dark";
    }
    print(_currentTheme);
    SharedPreferencesLocalStorage().setTheme(_currentTheme);
    notifyListeners();
  }
}

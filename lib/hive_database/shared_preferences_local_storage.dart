import 'package:shared_preferences/shared_preferences.dart';

/// The [SharedPreferences] has been used in this application only to store the currentTheme of the application.
class SharedPreferencesLocalStorage {
  late SharedPreferences _sharedPreferences;

  Future<void> initDB() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  void setTheme(bool currentTheme) async {
    await initDB();
    _sharedPreferences.setBool("isDark", currentTheme);
  }

  Future<bool?> getCurrentTheme() async {
    await initDB();
    return _sharedPreferences.getBool("isDark");
  }
}

import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesLocalStorage {
  late SharedPreferences _sharedPreferences;

  Future<void> initDB() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  void setTheme(String currentTheme) async {
    await initDB();
    _sharedPreferences.setString("currentTheme", currentTheme);
  }

  Future<String?> getCurrentTheme() async {
    await initDB();
    return _sharedPreferences.getString("currentTheme");
  }
}

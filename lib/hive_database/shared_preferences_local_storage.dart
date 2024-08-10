import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesLocalStorage {
  late SharedPreferences _sharedPreferences;

  void initDB() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  void setTheme(String currentTheme) {
    _sharedPreferences.setString("currentTheme", currentTheme);
  }

  String? getCurrentTheme() {
    return _sharedPreferences.getString("currentTheme");
  }
}

import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  SharedPreferences _sharedPrefs;
  // SharedPrefs()

  keyInitString(String key, String value) async {
    _sharedPrefs = await SharedPreferences.getInstance();
    _sharedPrefs.setString(key, value);
  }

  keyFetch(String key) async {
    _sharedPrefs = await SharedPreferences.getInstance();
    _sharedPrefs.getString(key);
  }

  keyInitInteger(String key, int value) async {
    _sharedPrefs = await SharedPreferences.getInstance();
    _sharedPrefs.setInt(key, value);
  }
}

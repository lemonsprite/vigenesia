import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static SharedPreferences _sharedPrefs;
  
  static Future init() async => _sharedPrefs = await SharedPreferences.getInstance();

  static keyInitString(String key, String value) => _sharedPrefs.setString(key, value);

  static String keyFetch(String key) => _sharedPrefs.getString(key);

  static bool containKey(key) => _sharedPrefs.containsKey(key);
  static Future clearKey() async => await _sharedPrefs.clear();
}


import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  
  SharedPreferences _sharedPrefs;
  // SharedPrefs()


  void stringInit  (String key, String value) async {
    _sharedPrefs = await SharedPreferences.getInstance();
    _sharedPrefs.setString(key, value);
  }

  
  


}
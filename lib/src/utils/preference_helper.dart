import 'package:shared_preferences/shared_preferences.dart';

class PreferenceHelper {

  static const String IS_SIGN_IN = "IS_SIGN_IN";
  static const String id = "id";
  static const String email = 'email';

  static SharedPreferences _prefs;

  static Map<String, dynamic> _memoryPrefs = Map<String, dynamic>();

  static Future<SharedPreferences> load() async {
    if (_prefs == null) {
      _prefs = await SharedPreferences.getInstance();
    }
    return _prefs;
  }

  static String getId(){
    return getString(id);
  }
  static String getEmail(){
    return getString(email);
  }

  static void setId(String value) {
    return setString(id,value);
  }
  static void setEmail(String value) {
    return setString(email,value);
  }

  static bool getLoggedIn() {
    return getBool(IS_SIGN_IN);
  }

  static void setLoggedIn(bool value) {
    return setBool(IS_SIGN_IN,value);
  }

  static void setString(String key, String value) {
    _prefs.setString(key, value);
    _memoryPrefs[key] = value;
  }

  static void setBool(String key, bool value) {
    _prefs.setBool(key, value);
    _memoryPrefs[key] = value;
  }

  static bool getBool(String key, {bool def = false}) {
    bool val;
    if (_memoryPrefs.containsKey(key)) {
      val = _memoryPrefs[key];
    }
    if (val == null && _prefs != null) {
      val = _prefs.getBool(key);
    }
    if (val == null) {
      val = def;
    }
    _memoryPrefs[key] = val;
    return val;
  }

  static String getString(String key, {String def}) {
    String val;
    if (_memoryPrefs.containsKey(key)) {
      val = _memoryPrefs[key];
    }
    if (val == null && _prefs != null) {
      val = _prefs.getString(key);
    }
    if (val == null) {
      val = def;
    }
    _memoryPrefs[key] = val;
    if (val == null) {
      val = "";
    }
    return val;
  }


  static void clear() {
    _memoryPrefs.remove(IS_SIGN_IN);
    _prefs.remove(IS_SIGN_IN);
  }
}
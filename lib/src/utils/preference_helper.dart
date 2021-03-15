import 'package:shared_preferences/shared_preferences.dart';

class PreferenceHelper {

  static SharedPreferences _prefs;

  static const String userId = "userId";
  static const String email = "email";
  static const String isSignIn = "isSignIn";
  static const String username = "username";
  static const String token = "token";
  static const String userType = "userType"; // 0 - del boy , 1- merchant

  static Future<SharedPreferences> load() async {
    if (_prefs == null) {
      _prefs = await SharedPreferences.getInstance();
    }
    return _prefs;
  }

  static void setUser(LoginResponse loginResponse) {
    setObject(LOGIN_DATA, loginResponse.toJson());
    setInt(userId, loginResponse.id);
    setString(token, "JWT ${loginResponse.token}");
    setBool(isSignIn, true);
  }

  static LoginResponse getUser() {
    return LoginResponse.fromJson(getObject(LOGIN_DATA));
  }

  static int getUserId() {
    return getInt(userId, def: 0);
  }


  static Future<bool> setBool(String key, bool value) async =>
      await _prefs.setBool(key, value);

  static Future<bool> setDouble(String key, double value) async =>
      await _prefs.setDouble(key, value);

  static Future<bool> setInt(String key, int value) async =>
      await _prefs.setInt(key, value);

  static Future<bool> setString(String key, String value) async =>
      await _prefs.setString(key, value);

  static Future<bool> setStringList(String key, List<String> value) async =>
      await _prefs.setStringList(key, value);


  static bool getBool(String key) => _prefs.getBool(key);

  static double getDouble(String key) => _prefs.getDouble(key);

  static int getInt(String key) => _prefs.getInt(key);

  static String getString(String key) => _prefs.getString(key);

  static List<String> getStringList(String key) => _prefs.getStringList(key);

  //deletes..
  static void clear() {

    _memoryPrefs.remove(isSignIn);
    _memoryPrefs.remove(token);
    _memoryPrefs.remove(username);


    _prefs.remove(isSignIn);
    _prefs.remove(token);
    _prefs.remove(username);
  }
}
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefHelper {
  final SharedPreferences prefs;
  static SharedPrefHelper instance;

  ///key names for preference data storage
  static const String IS_LOGGED_IN = "logged_in";

  SharedPrefHelper(this.prefs);

  static Future<void> createInstance() async {
    instance = SharedPrefHelper(await SharedPreferences.getInstance());
  }

  Future<void> putBool(String key, bool value) async {
    await prefs.setBool(key, value);
  }

  bool getBool(String key, {bool defaultValue = false}) {
    if (prefs.containsKey(key)) {
      return prefs.getBool(key);
    }
    return defaultValue;
  }

  Future<void> putDouble(String key, double value) async {
    await prefs.setDouble(key, value);
  }

  double getDouble(String key, {double defaultValue = 0.0}) {
    if (prefs.containsKey(key)) {
      return prefs.getDouble(key);
    }
    return defaultValue;
  }

  Future<void> putString(String key, String value) async {
    await prefs.setString(key, value);
  }

  String getString(String key, {String defaultValue = ""}) {
    if (prefs.containsKey(key)) {
      return prefs.getString(key);
    }
    return defaultValue;
  }

  Future<void> putInt(String key, int value) async {
    await prefs.setInt(key, value);
  }

  int getInt(String key, {int defaultValue = 0}) {
    if (prefs.containsKey(key)) {
      return prefs.getInt(key);
    }
    return defaultValue;
  }

  bool isLogIn() {
    return getBool(IS_LOGGED_IN) ?? false;
  }
}

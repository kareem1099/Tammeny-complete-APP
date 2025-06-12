import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static late SharedPreferences _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // Set Data

  static Future<void> set({required String key, required dynamic value}) async {
    if (value is String) {
      await _prefs.setString(key, value);
    } else if (value is int) {
      await _prefs.setInt(key, value);
    } else if (value is double) {
      await _prefs.setDouble(key, value);
    } else if (value is bool) {
      await _prefs.setBool(key, value);
    } else if (value is List<String>) {
      await _prefs.setStringList(key, value);
    } else {
      throw UnsupportedError('Unsupported Type');
    }
  }

  // Read Data

  static double? getDouble({required String key}) {
    return _prefs.getDouble(key);
  }

  static String? getString({required String key}) {
    return _prefs.getString(key);
  }

  static int? getInt({required String key}) {
    return _prefs.getInt(key);
  }

  static bool? getBool({required String key}) {
    return _prefs.getBool(key);
  }

  static List<String>? getStringList({required String key}) {
    return _prefs.getStringList(key);
  }

  // Remove data
  static Future<bool> remove({required String key}) async {
    return await _prefs.remove(key);
  }

  // Clear all Data
  static Future<bool> removeAllData() async {
    return await _prefs.clear();
  }
}

import 'package:shared_preferences/shared_preferences.dart';
import 'dart:developer' as developer;

class LocalCounterService {
  Future<int> getCount(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(key) ?? 0;
  }

  Future<void> increment(String key) async {
    final prefs = await SharedPreferences.getInstance();
    final current = prefs.getInt(key) ?? 0;
    await prefs.setInt(key, current + 1);
    developer.log('Incremented $key to ${current + 1}');
  }

  Future<void> decrement(String key) async {
    final prefs = await SharedPreferences.getInstance();
    final current = prefs.getInt(key) ?? 0;
    final updated = (current - 1).clamp(0, double.infinity).toInt();
    await prefs.setInt(key, updated);
    developer.log('Decremented $key to $updated');
  }

  String getKey(String tag, String type) => '${type}_$tag';
}

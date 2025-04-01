import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesManager {
  static final SharedPreferencesManager instance = SharedPreferencesManager._init();

  SharedPreferencesManager._init();

  Future<Map<String, dynamic>?> getMap(List<String> keys) async {
    final SharedPreferencesAsync prefs = SharedPreferencesAsync();
    Map<String, dynamic> map = {};
    try {
      for (String key in keys) {
        final value = await prefs.getString(key);
        if (value == null) {
          throw Exception("Key $key not found in SharedPreferences");
        }
        map[key] = value;
      }
      return map;
    } catch (e) {
      return null;
    }
  }

  Future<void> setMap(Map<String, dynamic> map) async {
    final SharedPreferencesAsync prefs = SharedPreferencesAsync();
    for (String key in map.keys) {
      await prefs.setString(key, map[key]);
    }
  }

  Future<dynamic> get(String key) async {
    final SharedPreferencesAsync prefs = SharedPreferencesAsync();
    return await prefs.getString(key) ?? "";
  }

  Future<void> set(String key, dynamic value) async {
    final SharedPreferencesAsync prefs = SharedPreferencesAsync();
    await prefs.setString(key, value);
  }

  Future<void> delete(List<String> keys) async {
    final SharedPreferencesAsync prefs = SharedPreferencesAsync();
    for (var key in keys) {
      await prefs.remove(key);
    }
    prefs.clear(allowList: keys.toSet());
  }
}
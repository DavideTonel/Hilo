import 'package:shared_preferences/shared_preferences.dart';

/// A singleton class to manage SharedPreferences operations.
///
/// This class provides methods to get, set, and delete data from SharedPreferences in a Flutter application.
/// It supports operations for both individual keys and maps of key-value pairs. It ensures consistent access
/// to SharedPreferences through a single instance, following the Singleton design pattern.
class SharedPreferencesManager {
  // Singleton instance of the SharedPreferencesManager class.
  static final SharedPreferencesManager instance = SharedPreferencesManager._init();

  // Private constructor for Singleton initialization.
  SharedPreferencesManager._init();

  /// Retrieves a map of key-value pairs from SharedPreferences.
  ///
  /// This method takes a list of keys and attempts to fetch their corresponding values from SharedPreferences.
  /// If any key is not found, it throws an exception. If successful, it returns a map of keys and their
  /// respective values. If an error occurs during retrieval, `null` is returned.
  ///
  /// [keys] - A list of keys to retrieve from SharedPreferences.
  ///
  /// Returns a [Map<String, dynamic>] containing the key-value pairs for the provided keys, or `null` if an error occurs.
  ///
  /// Throws [Exception] if a key is not found in SharedPreferences.
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

  /// Saves a map of key-value pairs to SharedPreferences.
  ///
  /// This method takes a map of key-value pairs and saves each pair into SharedPreferences.
  ///
  /// [map] - A [Map<String, dynamic>] containing the key-value pairs to store in SharedPreferences.
  ///
  /// Throws [Exception] if saving fails for any key-value pair.
  Future<void> setMap(Map<String, dynamic> map) async {
    final SharedPreferencesAsync prefs = SharedPreferencesAsync();
    for (String key in map.keys) {
      await prefs.setString(key, map[key]);
    }
  }

  /// Retrieves the value associated with a single key from SharedPreferences.
  ///
  /// This method returns the string value stored for the provided key. If the key does not exist,
  /// it returns an empty string by default.
  ///
  /// [key] - The key for which to retrieve the value.
  ///
  /// Returns the stored value as a [String], or an empty string if the key is not found.
  Future<dynamic> get(String key) async {
    final SharedPreferencesAsync prefs = SharedPreferencesAsync();
    return await prefs.getString(key) ?? "";
  }

  /// Saves a single key-value pair to SharedPreferences.
  ///
  /// This method saves a single key-value pair in SharedPreferences. The key must be a [String] and
  /// the value must be a [String].
  ///
  /// [key] - The key to store in SharedPreferences.
  /// [value] - The value to store for the given key.
  Future<void> set(String key, dynamic value) async {
    final SharedPreferencesAsync prefs = SharedPreferencesAsync();
    await prefs.setString(key, value);
  }

  /// Deletes a list of keys from SharedPreferences.
  ///
  /// This method removes the specified keys from SharedPreferences. It also clears any allowed
  /// values from the list of keys to ensure their removal.
  ///
  /// [keys] - A list of keys to be removed from SharedPreferences.
  Future<void> delete(List<String> keys) async {
    final SharedPreferencesAsync prefs = SharedPreferencesAsync();
    for (var key in keys) {
      await prefs.remove(key);
    }
    prefs.clear(allowList: keys.toSet());
  }
}

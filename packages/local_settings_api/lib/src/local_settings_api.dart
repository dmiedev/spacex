import 'dart:convert';

import 'package:local_settings_api/src/exceptions.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Simple local settings API using SharedPreferences.
class LocalSettingsApi {
  /// Creates an object that resembles simple local settings API using
  /// SharedPreferences.
  const LocalSettingsApi({
    required SharedPreferences sharedPreferences,
  }) : _sharedPreferences = sharedPreferences;

  final SharedPreferences _sharedPreferences;

  /// Saves an object of type [T] as a setting with the provided [name].
  ///
  /// Throws [SettingSaveException] if saving fails.
  Future<void> saveSetting<T>(String name, T object) async {
    bool saved;
    try {
      saved = await _sharedPreferences.setString(name, jsonEncode(object));
    } on Exception {
      throw SettingSaveException();
    }
    if (!saved) {
      throw SettingSaveException();
    }
  }

  /// Returns an object of type [T] from a setting with the provided [name],
  /// or `null` if the setting has not been saved yet.
  ///
  /// Throws [SettingLoadException] if loading fails.
  T? loadSetting<T>(String name) {
    try {
      final json = _sharedPreferences.getString(name);
      return json != null ? jsonDecode(json) as T : null;
    } on Exception {
      throw SettingLoadException();
    }
  }
}

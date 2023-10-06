import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:silme/utils/local_keys.dart';

/// This will provide the [ThemeNotifier] instance.
final themeProvider =
    ChangeNotifierProvider<ThemeNotifier>((ref) => ThemeNotifier());

/// Theme notifier class for theme provider.
/// This class will notify the listeners when the theme is changed.
class ThemeNotifier with ChangeNotifier {
  /// Default constructor.
  ThemeNotifier() {
    _loadFromPreferences();
  }

  /// Current theme index.
  int _themeIndex = 0;

  /// Shared preferences instance.
  SharedPreferences? _preferences;

  /// Get the current theme index.
  int get themeIndex => _themeIndex;

  /// Initialize the shared preferences.
  /// Call this method before using [SharedPreferences] instance.
  Future<void> _initPreferences() async {
    _preferences ??= await SharedPreferences.getInstance();
  }

  /// Load the theme index from shared preferences.
  Future<void> _loadFromPreferences() async {
    await _initPreferences();
    _themeIndex = _preferences!.getInt(LocalKeys.currentThemeNumber) ?? 0;
    notifyListeners();
  }

  /// Save the current theme index to shared preferences.
  Future<void> _savePreferences(int value) async {
    await _initPreferences();
    await _preferences!.setInt(LocalKeys.currentThemeNumber, value);
  }

  /// Set the current theme index and notify listeners.
  /// This will update the theme for the app.
  void setTheme(int value) {
    _savePreferences(value);
    _themeIndex = value;
    notifyListeners();
  }
}

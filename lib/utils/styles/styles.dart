import 'package:flutter/material.dart';
import 'package:silme/utils/common_methods.dart';

/// Styles class
/// This class is used to set the theme of the app
class Styles {
  /// Select the theme based on the [index]
  ThemeData themeData(int index, BuildContext context) {
    switch (index) {
      case 0:
        return setWhiteTheme();
      case 1:
        return setBlackTheme();
      case 2:
        return setOtherTheme();
      default:
        return setBlackTheme();
    }
  }

  /// White Theme
  ThemeData setWhiteTheme() {
    return ThemeData(
      useMaterial3: true,
      colorSchemeSeed: Colors.white,
      textTheme: textTheme(),
    );
  }

  /// Black Theme
  ThemeData setBlackTheme() {
    return ThemeData(
      useMaterial3: true,
      colorScheme: const ColorScheme(
        brightness: Brightness.dark,
        primary: Colors.white,
        onPrimary: Colors.black,
        secondary: Colors.black,
        onSecondary: Colors.white,
        error: Colors.red,
        onError: Colors.black,
        background: Colors.black,
        onBackground: Colors.white,
        surface: Colors.black,
        onSurface: Colors.white,
      ),
      textTheme: textTheme(),
    );
  }

  /// Random Theme
  ThemeData setOtherTheme() {
    return ThemeData(
      useMaterial3: true,
      colorSchemeSeed: CommonMethods.getRandomColor(),
      textTheme: textTheme(),
    );
  }

  /// Default Text Theme
  static const _defaultTextStyle =
      TextStyle(fontWeight: FontWeight.w500, fontFamily: 'poppins');

  /// Text Theme
  static TextTheme textTheme() {
    return TextTheme(
      headlineLarge: _defaultTextStyle.copyWith(fontSize: 100),
      headlineMedium: _defaultTextStyle.copyWith(fontSize: 25),
      headlineSmall: _defaultTextStyle.copyWith(fontSize: 16),
      titleMedium: _defaultTextStyle.copyWith(fontSize: 18),
      titleSmall: _defaultTextStyle.copyWith(fontSize: 14),
      bodyMedium: _defaultTextStyle.copyWith(fontSize: 13),
      bodySmall: _defaultTextStyle.copyWith(fontSize: 20),
      labelMedium: _defaultTextStyle.copyWith(fontSize: 12),
      labelSmall: _defaultTextStyle.copyWith(fontSize: 10),
    );
  }
}

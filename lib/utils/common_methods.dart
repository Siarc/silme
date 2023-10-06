import 'dart:math';

import 'package:flutter/material.dart';

/// CommonMethods class
class CommonMethods {
  /// Get Random Color
  static Color getRandomColor() {
    final random = Random();
    return Color.fromARGB(
      255,
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
    );
  }
}

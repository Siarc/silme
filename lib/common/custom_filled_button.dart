import 'package:flutter/material.dart';

/// Custom Filled Button Widget
class CustomFilledButton extends StatelessWidget {
  /// Default Constructor
  const CustomFilledButton({
    required this.label,
    super.key,
    this.onPressed,
    this.style,
  });

  /// On Pressed event
  final VoidCallback? onPressed;

  /// Button Label
  final String label;

  /// Button Style
  final ButtonStyle? style;

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      style: style ??
          FilledButton.styleFrom(
            elevation: 10,
          ),
      onPressed: onPressed,
      child: Text(label),
    );
  }
}

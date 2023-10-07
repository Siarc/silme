import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// A custom text form field widget that can be used to get user input.
class CustomOutlinedTextFormField extends ConsumerWidget {
  /// Constructor Params
  // ignore: prefer_const_constructors_in_immutables
  CustomOutlinedTextFormField({
    this.label,
    this.hint,
    this.errorColor,
    this.hintColor,
    this.lines,
    this.controller,
    this.onChanged,
    this.validator,
    super.key,
  });

  /// Value change event
  final ValueChanged<String>? onChanged;

  /// validate logic
  final FormFieldValidator<String>? validator;

  /// Controller to update the text event changes
  final TextEditingController? controller;

  /// Text Field Label
  final String? label;

  /// Number of lines
  final int? lines;

  /// Error Color
  final Color? errorColor;

  /// Hint Color
  final Color? hintColor;

  /// Hint Text
  final String? hint;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextFormField(
      minLines: lines,
      maxLines: lines,
      controller: controller,
      keyboardType: TextInputType.name,
      style: Theme.of(context).textTheme.bodySmall,
      decoration: InputDecoration(
        labelText: label,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 10,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      onChanged: onChanged,
      validator: validator,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
    this.lines = 1,
    this.controller,
    this.onChanged,
    this.validator,
    this.obscureText = false,
    this.numberOnly = false,
    this.allowDecimal = true,
    this.range = '92233720368547758',
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

  /// Obscure Text (Password)
  final bool obscureText;

  /// Numbers only
  final bool numberOnly;

  /// Allow decimal
  final bool allowDecimal;

  /// Numbers only
  final String? range;

  /// Hint Text
  final String? hint;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextFormField(
      minLines: lines,
      maxLines: obscureText ? 1 : lines,
      controller: controller,
      obscureText: obscureText,
      // if condition for number only
      keyboardType: numberOnly
          ? const TextInputType.numberWithOptions(
              decimal: true,
            )
          : TextInputType.text,
      style: Theme.of(context).textTheme.titleMedium,
      decoration: InputDecoration(
        errorStyle: Theme.of(context).textTheme.titleSmall?.copyWith(
              color: Theme.of(context).colorScheme.error,
            ),
        floatingLabelAlignment: FloatingLabelAlignment.center,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        labelText: label,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 10,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      onTapOutside: (event) {
        FocusScope.of(context).unfocus();
      },
      onChanged: onChanged,
      validator: validator,
      // if condition for number only
      inputFormatters: [
        if (numberOnly) ...[
          FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*$')),
          if (range != null && range!.isNotEmpty)
            RangeTextInputFormatter(min: 0, max: double.parse(range!)),
          if (!allowDecimal) FilteringTextInputFormatter.deny(RegExp('[.]')),
        ]
      ],
    );
  }
}

/// A custom number field widget that can be used for predefined range.
class RangeTextInputFormatter extends TextInputFormatter {
  /// Constructor Params
  RangeTextInputFormatter({required this.min, required this.max});

  /// Minimum value
  final double min;

  /// Maximum value
  final double max;

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.isEmpty) {
      return newValue;
    }

    final newValueNumber = double.tryParse(newValue.text);

    if (newValueNumber == null) {
      return oldValue;
    }

    if (newValueNumber < min) {
      return newValue.copyWith(text: min.toString());
    } else if (newValueNumber > max) {
      return newValue.copyWith(text: max.toString());
    } else {
      return newValue;
    }
  }
}

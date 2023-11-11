// ignore_for_file: use_setters_to_change_properties

import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'nonwoven_print_type_provider.g.dart';

/// Selected nonwoven print color
@riverpod
class NonwovenPrintType extends _$NonwovenPrintType {
  @override
  String build() {
    return 'Print Color';
  }

  /// Set color tpye
  void setPrintType(String value) {
    state = value;
  }
}

/// Value of the nonwoven print color
@riverpod
class NonwovenPrintTypeValue extends _$NonwovenPrintTypeValue {
  @override
  double build() {
    final value = ref.watch(nonwovenPrintTypeProvider);
    switch (value) {
      case 'Print Color':
        return 0;
      case 'One Color':
        return 1;
      case 'Two Color':
        return 2;
      case 'Three Color':
        return 3;
      case 'Four Color':
        return 4;
      default:
        return 0;
    }
  }
}

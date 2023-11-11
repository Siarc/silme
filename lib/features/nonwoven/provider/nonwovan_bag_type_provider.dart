// ignore_for_file: use_setters_to_change_properties

import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'nonwovan_bag_type_provider.g.dart';

/// Selected nonwoven type bag
@riverpod
class NonwovanBagType extends _$NonwovanBagType {
  @override
  String build() {
    return 'Select Bag Type';
  }

  /// Set nonwoven type bag
  void setNonwovenType(String value) {
    state = value;
  }

  /// Get the value based on the bag type
  double getBagTypeValue() {
    switch (state) {
      case 'Select Bag Type':
        return 0;
      case 'Handle Bag':
        return 0.65;
      case 'D Cut Bag':
        return 0.50;
      case 'Sewing Bag':
        return 4;
      case 'Autobox Handle Bag':
        return 2;
      case 'Autobox D Cut Bag':
        return 2;
      default:
        return 0;
    }
  }
}

/// Value of the nonwoven bag type
@riverpod
class NonwovanBagTypeValue extends _$NonwovanBagTypeValue {
  @override
  double build() {
    final value = ref.watch(nonwovanBagTypeProvider);
    switch (value) {
      case 'Select Bag Type':
        return 0;
      case 'Handle Bag':
        return 0.65;
      case 'D Cut Bag':
        return 0.50;
      case 'Sewing Bag':
        return 4;
      case 'Autobox Handle Bag':
        return 2;
      case 'Autobox D Cut Bag':
        return 2;
      default:
        return 0;
    }
  }
}

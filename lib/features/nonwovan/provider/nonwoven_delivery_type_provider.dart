// ignore_for_file: use_setters_to_change_properties

import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'nonwoven_delivery_type_provider.g.dart';

/// Selected cotton type bag
@riverpod
class NonwovenDeliveryType extends _$NonwovenDeliveryType {
  @override
  int build() {
    return 0;
  }

  /// Set cotton type bag
  void setDeliveryType(int value) {
    state = value;
  }
}

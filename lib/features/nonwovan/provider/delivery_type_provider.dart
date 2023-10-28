// ignore_for_file: use_setters_to_change_properties

import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'delivery_type_provider.g.dart';

/// Selected cotton type bag
@riverpod
class DeliveryType extends _$DeliveryType {
  @override
  int build() {
    return 1;
  }

  /// Set cotton type bag
  void setDeliveryType(int value) {
    state = value;
  }
}

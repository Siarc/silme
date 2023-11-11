// ignore_for_file: use_setters_to_change_properties

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:silme/features/nonwoven/provider/nonwoven_bag_provider.dart';

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
    ref.read(nonwovanBagProvider.notifier).setDeliveryType(value.toString());
    state = value;
  }
}

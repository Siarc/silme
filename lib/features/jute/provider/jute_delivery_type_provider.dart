// ignore_for_file: use_setters_to_change_properties

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:silme/features/Jute/provider/jute_bag_provider.dart';

part 'jute_delivery_type_provider.g.dart';

/// Selected cotton type bag
@riverpod
class JuteDeliveryType extends _$JuteDeliveryType {
  @override
  int build() {
    return 0;
  }

  /// Set cotton type bag
  void setDeliveryType(int value) {
    ref.read(juteBagProvider.notifier).setDeliveryType(value.toString());
    state = value;
  }
}

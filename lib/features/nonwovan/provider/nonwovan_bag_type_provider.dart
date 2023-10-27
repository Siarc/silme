// ignore_for_file: use_setters_to_change_properties

import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'nonwovan_bag_type_provider.g.dart';

/// Selected cotton type bag
@riverpod
class NonwovanBagType extends _$NonwovanBagType {
  @override
  String build() {
    return 'Select Bag Type';
  }

  /// Set cotton type bag
  void setCottonType(String value) {
    state = value;
  }
}

// ignore_for_file: use_setters_to_change_properties

import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'nonwovan_type_provider.g.dart';

/// Selected cotton type bag
@riverpod
class NonwovanType extends _$NonwovanType {
  @override
  String build() {
    return 'Select Bag Type';
  }

  /// Set cotton type bag
  void setCottonType(String value) {
    state = value;
  }
}

// ignore_for_file: use_setters_to_change_properties

import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'cotton_type_provider.g.dart';

/// Selected cotton type bag
@riverpod
class CottonType extends _$CottonType {
  @override
  String build() {
    return 'Select Bag Type';
  }

  /// Set cotton type bag
  void setCottonType(String value) {
    state = value;
  }
}

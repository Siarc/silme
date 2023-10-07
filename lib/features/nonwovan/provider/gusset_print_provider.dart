// ignore_for_file: use_setters_to_change_properties

import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'gusset_print_provider.g.dart';

/// Selected cotton type bag
@riverpod
class GussetPrint extends _$GussetPrint {
  @override
  int build() {
    return 0;
  }

  /// Set cotton type bag
  void setGussetPrint(int value) {
    state = value;
  }
}

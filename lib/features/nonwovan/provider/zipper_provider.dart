// ignore_for_file: use_setters_to_change_properties

import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'zipper_provider.g.dart';

/// Selected cotton type bag
@riverpod
class Zipper extends _$Zipper {
  @override
  int build() {
    return 0;
  }

  /// Set cotton type bag
  void setZipper(int value) {
    state = value;
  }
}

// ignore_for_file: use_setters_to_change_properties

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:silme/features/nonwoven/provider/nonwoven_bag_provider.dart';

part 'nonwoven_zipper_provider.g.dart';

/// Selected cotton type bag
@riverpod
class NonwovenZipper extends _$NonwovenZipper {
  @override
  int build() {
    return 2;
  }

  /// Set cotton type bag
  void setZipper(int value) {
    ref.read(nonwovanBagProvider.notifier).setZipper(value.toString());
    state = value;
  }
}

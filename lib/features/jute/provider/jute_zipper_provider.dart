// ignore_for_file: use_setters_to_change_properties

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:silme/features/jute/provider/jute_bag_provider.dart';

part 'jute_zipper_provider.g.dart';

/// Selected cotton type bag
@riverpod
class JuteZipper extends _$JuteZipper {
  @override
  int build() {
    return 2;
  }

  /// Set cotton type bag
  void setZipper(int value) {
    ref.read(juteBagProvider.notifier).setZipper(value.toString());
    state = value;
  }
}

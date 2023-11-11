// ignore_for_file: use_setters_to_change_properties

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:silme/features/nonwoven/provider/nonwoven_bag_provider.dart';

part 'nonwoven_gusset_print_provider.g.dart';

/// Selected cotton type bag
@riverpod
class NonwovenGussetPrint extends _$NonwovenGussetPrint {
  @override
  int build() {
    return 2;
  }

  /// Set cotton type bag
  void setGussetPrint(int value) {
    ref.read(nonwovanBagProvider.notifier).setGussetPrint(value.toString());
    state = value;
  }
}

// ignore_for_file: use_setters_to_change_properties

import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'print_type_provider.g.dart';

/// Selected cotton type bag
@riverpod
class PrintType extends _$PrintType {
  @override
  String build() {
    return 'Print Color';
  }

  /// Set cotton type bag
  void setPrintType(String value) {
    state = value;
  }
}

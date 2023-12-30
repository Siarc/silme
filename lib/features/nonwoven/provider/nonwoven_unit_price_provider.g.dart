// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nonwoven_unit_price_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$nonwovenUnitPriceHash() => r'9158b403efa5f126412bbf9dbca9ec34f2f97e68';

/// A Riverpod provider that calculates the unit price of a nonwoven bag.
///
/// This provider uses the details of the nonwoven bag and its type to calculate the unit price.
/// It also saves the current state of the nonwoven bag to shared preferences.
///
/// Copied from [NonwovenUnitPrice].
@ProviderFor(NonwovenUnitPrice)
final nonwovenUnitPriceProvider =
    AutoDisposeAsyncNotifierProvider<NonwovenUnitPrice, String>.internal(
  NonwovenUnitPrice.new,
  name: r'nonwovenUnitPriceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$nonwovenUnitPriceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$NonwovenUnitPrice = AutoDisposeAsyncNotifier<String>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member

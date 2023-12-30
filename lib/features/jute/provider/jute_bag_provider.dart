// ignore_for_file: use_setters_to_change_properties
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:silme/features/jute/model/jute.dart';

part 'jute_bag_provider.g.dart';

/// Selected nonwoven bag
@riverpod
class JuteBag extends _$JuteBag {
  /// Default constructor
  @override
  Jute build() {
    return Jute(
      bodyFabricPrice: '',
      gussetFabricPrice: '',
      usableBodyFabric: '',
      usableGussetFabric: '',
      height: '',
      width: '',
      handle: '',
      gusset: '',
      print: '',
      accessories: '',
      quantity: '',
      profit: '',
      zipper: '2',
      deliveryType: '',
      homeDeliveryCost: '',
      unitPrice: '',
    );
  }

  /// Set nonwoven bag if we already have one saved
  void setJuteBag(Jute item) {
    state = item;
  }

  /// set body fabric price
  void setBodyFabricPrice(String value) {
    state = state.copyWith(bodyFabricPrice: value);
  }

  /// set gusset fabric price
  void setGussetFabricPrice(String value) {
    state = state.copyWith(gussetFabricPrice: value);
  }

  /// set usable body fabric
  void setUsableBodyFabric(String value) {
    state = state.copyWith(usableBodyFabric: value);
  }

  /// set usable gusset fabric
  void setUsableGussetFabric(String value) {
    state = state.copyWith(usableGussetFabric: value);
  }

  /// set height
  void setHeight(String value) {
    state = state.copyWith(height: value);
  }

  /// set width
  void setWidth(String value) {
    state = state.copyWith(width: value);
  }

  /// set handle
  void setHandle(String value) {
    state = state.copyWith(handle: value);
  }

  /// set gusset
  void setGusset(String value) {
    state = state.copyWith(gusset: value);
  }

  /// set print
  void setPrint(String value) {
    state = state.copyWith(print: value);
  }

  /// set accessories
  void setAccessories(String value) {
    state = state.copyWith(accessories: value);
  }

  /// set quantity
  void setQuantity(String value) {
    state = state.copyWith(quantity: value);
  }

  /// set profit
  void setProfit(String value) {
    state = state.copyWith(profit: value);
  }

  /// set zipper
  void setZipper(String value) {
    state = state.copyWith(zipper: value);
  }

  /// set delivery type
  void setDeliveryType(String value) {
    state = state.copyWith(deliveryType: value);
  }

  /// set home delivery cost
  void setHomeDeliveryCost(String value) {
    state = state.copyWith(homeDeliveryCost: value);
  }

  /// set unit price
  void setUnitPrice(String value) {
    state = state.copyWith(unitPrice: value);
  }
}

// ignore_for_file: use_setters_to_change_properties
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:silme/features/nonwoven/model/nonwoven.dart';

part 'nonwoven_bag_provider.g.dart';

/// Selected nonwoven bag
@riverpod
class NonwovanBag extends _$NonwovanBag {
  /// Default constructor
  @override
  Nonwovan build() {
    return Nonwovan(
      bagType: '',
      fabricPrice: '',
      height: '',
      width: '',
      gsm: '',
      gusset: '',
      printColor: '',
      gussetPrint: '2',
      zipper: '2',
      quanntity: '',
      additioonalCost: '',
      deliveryType: '',
      homeDeliveryCost: '',
      profit: '',
      unitPrice: '',
    );
  }

  /// Set nonwoven bag if we already have one saved
  void setNonwovenBag(Nonwovan item) {
    state = item;
  }

  /// set bag type
  void setBagType(String value) {
    state = state.copyWith(bagType: value);
  }

  /// set fabric price
  void setFabricPrice(String value) {
    state = state.copyWith(fabricPrice: value);
  }

  /// set height
  void setHeight(String value) {
    state = state.copyWith(height: value);
  }

  /// set width
  void setWidth(String value) {
    state = state.copyWith(width: value);
  }

  /// set gsm
  void setGsm(String value) {
    state = state.copyWith(gsm: value);
  }

  /// set gusset
  void setGusset(String value) {
    state = state.copyWith(gusset: value);
  }

  /// set print color
  void setPrintColor(String value) {
    state = state.copyWith(printColor: value);
  }

  /// set gusset print
  void setGussetPrint(String value) {
    state = state.copyWith(gussetPrint: value);
  }

  /// set zipper
  void setZipper(String value) {
    state = state.copyWith(zipper: value);
  }

  /// set quantity
  void setQuantity(String value) {
    state = state.copyWith(quanntity: value);
  }

  /// set additional cost
  void setAdditionalCost(String value) {
    state = state.copyWith(additioonalCost: value);
  }

  /// set delivery type
  void setDeliveryType(String value) {
    state = state.copyWith(deliveryType: value);
  }

  /// set home delivery cost
  void setHomeDeliveryCost(String value) {
    state = state.copyWith(homeDeliveryCost: value);
  }

  /// set profit
  void setProfit(String value) {
    state = state.copyWith(profit: value);
  }

  /// set unit price
  void setUnitPrice(String value) {
    state = state.copyWith(unitPrice: value);
  }
}

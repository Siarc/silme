// ignore_for_file: use_setters_to_change_properties

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:silme/features/nonwovan/model/nonwoven.dart';

part 'nonwoven_bag_provider.g.dart';

/// Selected cotton type bag
@riverpod
class NonwovanBag extends _$NonwovanBag {
  @override
  Nonwovan build() {
    return Nonwovan(
      bagType: '',
      fabricPrice: 0,
      height: 0,
      width: 0,
      gsm: 0,
      gusset: 0,
      printColor: '',
      gussetPrint: false,
      zipper: false,
      quanntity: 0,
      additioonalCost: 0,
      deliveryType: '',
      homeDeliveryCost: 0,
      profit: 0,
      unitPrice: 0,
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

  /// get bag type
  String getBagType() {
    return state.bagType;
  }

  /// set fabric price
  void setFabricPrice(double value) {
    state = state.copyWith(fabricPrice: value);
  }

  /// get fabric price
  double getFabricPrice() {
    return state.fabricPrice;
  }

  /// set height
  void setHeight(double value) {
    state = state.copyWith(height: value);
  }

  /// get height
  double getHeight() {
    return state.height;
  }

  /// set width
  void setWidth(double value) {
    state = state.copyWith(width: value);
  }

  /// get width
  double getWidth() {
    return state.width;
  }

  /// set gsm
  void setGsm(double value) {
    state = state.copyWith(gsm: value);
  }

  /// get gsm
  double getGsm() {
    return state.gsm;
  }

  /// set gusset
  void setGusset(double value) {
    state = state.copyWith(gusset: value);
  }

  /// get gusset
  double getGusset() {
    return state.gusset;
  }

  /// set print color
  void setPrintColor(String value) {
    state = state.copyWith(printColor: value);
  }

  /// get print color
  String getPrintColor() {
    return state.printColor;
  }

  /// set gusset print
  void setGussetPrint({bool value = false}) {
    state = state.copyWith(gussetPrint: value);
  }

  /// get gusset print
  bool getGussetPrint() {
    return state.gussetPrint;
  }

  /// set zipper
  void setZipper({bool value = false}) {
    state = state.copyWith(zipper: value);
  }

  /// get zipper
  bool getZipper() {
    return state.zipper;
  }

  /// set quantity
  void setQuantity(int value) {
    state = state.copyWith(quanntity: value);
  }

  /// get quantity
  int getQuantity() {
    return state.quanntity;
  }

  /// set additional cost
  void setAdditionalCost(double value) {
    state = state.copyWith(additioonalCost: value);
  }

  /// get additional cost
  double getAdditionalCost() {
    return state.additioonalCost;
  }

  /// set delivery type
  void setDeliveryType(String value) {
    state = state.copyWith(deliveryType: value);
  }

  /// get delivery type
  String getDeliveryType() {
    return state.deliveryType;
  }

  /// set home delivery cost
  void setHomeDeliveryCost(double value) {
    state = state.copyWith(homeDeliveryCost: value);
  }

  /// get home delivery cost
  double getHomeDeliveryCost() {
    return state.homeDeliveryCost;
  }

  /// set profit
  void setProfit(double value) {
    state = state.copyWith(profit: value);
  }

  /// get profit
  double getProfit() {
    return state.profit;
  }

  /// set unit price
  void setUnitPrice(double value) {
    state = state.copyWith(unitPrice: value);
  }

  /// get unit price
  double getUnitPrice() {
    return state.unitPrice;
  }
}

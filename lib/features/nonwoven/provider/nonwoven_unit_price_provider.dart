// ignore_for_file: use_setters_to_change_properties

import 'dart:convert';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:silme/features/nonwoven/model/nonwoven.dart';
import 'package:silme/features/nonwoven/model/nonwoven_unit_locals.dart';
import 'package:silme/features/nonwoven/provider/nonwoven_gusset_print_provider.dart';
import 'package:silme/features/nonwoven/provider/nonwovan_bag_type_provider.dart';
import 'package:silme/features/nonwoven/provider/nonwoven_bag_provider.dart';
import 'package:silme/features/nonwoven/provider/nonwoven_delivery_type_provider.dart';
import 'package:silme/features/nonwoven/provider/nonwoven_print_type_provider.dart';
import 'package:silme/features/nonwoven/provider/nonwoven_zipper_provider.dart';
import 'package:silme/utils/local_keys.dart';

part 'nonwoven_unit_price_provider.g.dart';

/// A Riverpod provider that calculates the unit price of a nonwoven bag.
///
/// This provider uses the details of the nonwoven bag and its type to calculate the unit price.
/// It also saves the current state of the nonwoven bag to shared preferences.
@riverpod
class NonwovenUnitPrice extends _$NonwovenUnitPrice {
  @override
  Future<String> build() async {
    final nonwovenBag = ref.watch(nonwovanBagProvider);
    final nonwovenBagType = ref.watch(nonwovanBagTypeProvider);
    final nonwovenBagTypeValue = ref.watch(nonwovanBagTypeValueProvider);
    final printColorValue = ref.watch(nonwovenPrintTypeValueProvider);
    final allowGussetPrint = ref.watch(nonwovenGussetPrintProvider);
    final allowZipper = ref.watch(nonwovenZipperProvider);
    final deliveryType = ref.watch(nonwovenDeliveryTypeProvider);

    final fabricPrice = double.tryParse(nonwovenBag.fabricPrice) ?? 0;
    final gsm = double.tryParse(nonwovenBag.gsm) ?? 0;
    final height = double.tryParse(nonwovenBag.height) ?? 0;
    final width = double.tryParse(nonwovenBag.width) ?? 0;
    final quanntity = double.tryParse(nonwovenBag.quanntity) ?? 0;
    final homeDeliveryCost = double.tryParse(nonwovenBag.homeDeliveryCost) ?? 0;
    final additioonalCost = double.tryParse(nonwovenBag.additioonalCost) ?? 0;
    final profit = double.tryParse(nonwovenBag.profit) ?? 0;
    var deliveryCost = 0.0;

    final nonwovanUnitLocals = getNonwovenUnitLocals(
      nonwovenBagType,
      nonwovenBag,
      allowGussetPrint,
      allowZipper,
    );

    final nonwovenBagFabricPricePerUnit =
        nonwovanUnitLocals.fabricSqInch * 0.00067 * (fabricPrice / 1000) * gsm;

    final wastage = nonwovenBagFabricPricePerUnit * (2 / 100);

    final blockCost = ((height - 4) * (width - 3) * 10) / quanntity;
    if (deliveryType == 1) {
      deliveryCost = homeDeliveryCost / quanntity;
    }

    final bagPrice = nonwovenBagFabricPricePerUnit +
        nonwovenBagTypeValue +
        blockCost +
        printColorValue +
        wastage +
        nonwovanUnitLocals.gussetPrint +
        nonwovanUnitLocals.zipper +
        deliveryCost +
        additioonalCost +
        profit;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      LocalKeys.nonwovenModelState,
      jsonEncode(nonwovenBag.toJson()),
    );

    return bagPrice.toStringAsFixed(4);
  }

  /// Calculates the nonwoven unit locals based on the given parameters.
  ///
  /// [nonwovenBagType] specifies the type of nonwoven bag.
  /// [nonwovenBag] contains the details of the nonwoven bag.
  /// [allowGussetPrint] specifies whether gusset print is allowed or not.
  /// [allowZipper] specifies whether zipper is allowed or not.
  ///
  /// Returns a [NonwovenUnitLocals] object containing the calculated values.
  NonwovenUnitLocals getNonwovenUnitLocals(
    String nonwovenBagType,
    Nonwovan nonwovenBag,
    int allowGussetPrint,
    int allowZipper,
  ) {
    final nonwovenUnitLocals = NonwovenUnitLocals(
      heming: 0,
      handleFabric: 0,
      runner: 0,
      gussetPrint: 0,
      piping: 0,
      zipper: 0,
      fabricSqInch: 0,
    );
    final height = double.tryParse(nonwovenBag.height) ?? 0;
    final width = double.tryParse(nonwovenBag.width) ?? 0;
    final gusset = double.tryParse(nonwovenBag.gusset) ?? 0;
    final quanntity = double.tryParse(nonwovenBag.quanntity) ?? 0;
    final gsm = double.tryParse(nonwovenBag.gsm) ?? 0;
    final fabricPrice = double.tryParse(nonwovenBag.fabricPrice) ?? 0;
    switch (nonwovenBagType) {
      case 'Select Bag Type':
        return nonwovenUnitLocals;
      case 'Handle Bag':
        const heming = 1.5;
        const handleFabric = 70.0;

        nonwovenUnitLocals.heming = heming;

        nonwovenUnitLocals.handleFabric = handleFabric;

        nonwovenUnitLocals.fabricSqInch =
            ((height + heming) * width * 2) + (gusset * width) + handleFabric;

        return nonwovenUnitLocals;
      case 'D Cut Bag':
        const heming = 2.5;

        nonwovenUnitLocals.heming = heming;

        nonwovenUnitLocals.fabricSqInch =
            ((height + heming) * width * 2) + (gusset * width);

        return nonwovenUnitLocals;
      case 'Sewing Bag':
        const heming = 1.5;
        const handleFabric = 70.0;
        const runner = 1.0;
        final piping = (height * 4) + (width * 2) + 10;

        nonwovenUnitLocals.heming = heming;

        nonwovenUnitLocals.handleFabric = handleFabric;

        nonwovenUnitLocals.runner = runner;

        if (allowGussetPrint == 1) {
          nonwovenUnitLocals.gussetPrint =
              1 + ((height - 3) * (gusset - 1) * 10) / quanntity;
        }

        nonwovenUnitLocals.piping = piping;

        if (allowZipper == 1) {
          nonwovenUnitLocals.zipper = runner +
              ((width + 3) * 0.15) +
              3 +
              ((width + 1) * height) * 0.00067 * gsm * (fabricPrice / 1000);
        }

        nonwovenUnitLocals.fabricSqInch = ((height + heming) * width * 2) +
            (gusset * ((height + heming) * 2 + width)) +
            handleFabric +
            piping;

        return nonwovenUnitLocals;
      case 'Autobox Handle Bag':
        const heming = 1.5;
        const handleFabric = 70.0;

        nonwovenUnitLocals.heming = heming;

        nonwovenUnitLocals.handleFabric = handleFabric;

        nonwovenUnitLocals.fabricSqInch = ((height + heming) * width * 2) +
            ((gusset + 0.75) * ((height + heming) * 2 + width)) +
            handleFabric;
        return nonwovenUnitLocals;
      case 'Autobox D Cut Bag':
        const heming = 2.5;

        nonwovenUnitLocals.heming = heming;

        nonwovenUnitLocals.fabricSqInch = ((height + heming) * width * 2) +
            ((gusset + 0.75) * ((height + heming) * 2 + width));

        return nonwovenUnitLocals;
      default:
        return nonwovenUnitLocals;
    }
  }

  /// Determines the handle price of a nonwoven bag based on its type.
  /// Returns an integer representing the handle price.
  /// If the nonwovenBagType is not recognized, returns 0.
  ///
  /// [nonwovenBagType] A string representing the type of nonwoven bag.
  ///
  /// Returns an integer representing the handle price.
  int handleFabricBasedOnBagType(String nonwovenBagType) {
    switch (nonwovenBagType) {
      case 'Select Bag Type':
        return 0;
      case 'Handle Bag':
        return 70;
      case 'D Cut Bag':
        return 0;
      case 'Sewing Bag':
        return 70;
      case 'Autobox Handle Bag':
        return 70;
      case 'Autobox D Cut Bag':
        return 0;
      default:
        return 0;
    }
  }
}

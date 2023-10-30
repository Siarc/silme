// ignore_for_file: use_setters_to_change_properties

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:silme/features/nonwovan/model/nonwoven.dart';
import 'package:silme/features/nonwovan/model/nonwoven_unit_locals.dart';
import 'package:silme/features/nonwovan/provider/gusset_print_provider.dart';
import 'package:silme/features/nonwovan/provider/nonwovan_bag_type_provider.dart';
import 'package:silme/features/nonwovan/provider/nonwoven_bag_provider.dart';
import 'package:silme/features/nonwovan/provider/nonwoven_delivery_type_provider.dart';
import 'package:silme/features/nonwovan/provider/nonwoven_print_type_provider.dart';
import 'package:silme/features/nonwovan/provider/zipper_provider.dart';
import 'package:silme/utils/local_keys.dart';

part 'nonwoven_unit_price_provider.g.dart';

/// Selected cotton type bag
@riverpod
class NonwovenUnitPrice extends _$NonwovenUnitPrice {
  @override
  Future<String> build() async {
    final nonwovenBag = ref.watch(nonwovanBagProvider);
    final nonwovenBagType = ref.watch(nonwovanBagTypeProvider);
    final nonwovenBagTypeValue = ref.watch(nonwovanBagTypeValueProvider);
    final printColorValue = ref.watch(nonwovenPrintTypeValueProvider);
    final allowGussetPrint = ref.watch(gussetPrintProvider);
    final allowZipper = ref.watch(zipperProvider);
    final deliveryType = ref.watch(nonwovenDeliveryTypeProvider);

    final fabricPrice = double.tryParse(nonwovenBag.fabricPrice) ?? 0;
    final gsm = double.tryParse(nonwovenBag.gsm) ?? 0;
    final height = double.tryParse(nonwovenBag.height) ?? 0;
    final width = double.tryParse(nonwovenBag.width) ?? 0;
    final quanntity = double.tryParse(nonwovenBag.quanntity) ?? 0;
    final homeDeliveryCost = double.tryParse(nonwovenBag.homeDeliveryCost) ?? 0;
    final additioonalCost = double.tryParse(nonwovenBag.additioonalCost) ?? 0;
    final profit = double.tryParse(nonwovenBag.profit) ?? 0;

    final nonwovanUnitLocals = getNonwovenUnitLocals(
      nonwovenBagType,
      nonwovenBag,
      allowGussetPrint,
      allowZipper,
    );

    debugPrint('Rony2 fabricPrice -> $fabricPrice');
    debugPrint('Rony2 gsm -> $gsm');
    debugPrint('Rony2 height -> $height');
    debugPrint('Rony2 width -> $width');
    debugPrint('Rony2 quanntity -> $quanntity');
    debugPrint('Rony2 homeDeliveryCost -> $homeDeliveryCost');
    debugPrint('Rony2 additioonalCost -> $additioonalCost');
    debugPrint('Rony2 profit -> $profit');
    debugPrint('Rony2 fabricSqInch -> ${nonwovanUnitLocals.fabricSqInch}');
    debugPrint('Rony2 heming -> ${nonwovanUnitLocals.heming}');
    debugPrint('Rony2 handleFabric -> ${nonwovanUnitLocals.handleFabric}');
    debugPrint('Rony2 runner -> ${nonwovanUnitLocals.runner}');
    debugPrint('Rony2 gussetPrint -> ${nonwovanUnitLocals.gussetPrint}');
    debugPrint('Rony2 piping -> ${nonwovanUnitLocals.piping}');
    debugPrint('Rony2 zipper -> ${nonwovanUnitLocals.zipper}');

    final nonwovenBagFabricPricePerUnit =
        nonwovanUnitLocals.fabricSqInch * 0.00067 * (fabricPrice / 1000) * gsm;

    final wastage = nonwovenBagFabricPricePerUnit * (2 / 100);

    final blockCost = ((height - 4) * (width - 3) * 10) / quanntity;
    var deliveryCost = 0.0;
    if (deliveryType == 1) {
      deliveryCost = homeDeliveryCost / quanntity;
    }
    debugPrint(
        'Rony2 nonwovenBagFabricPricePerUnit -> ${nonwovenBagFabricPricePerUnit}');
    debugPrint('Rony2 nonwovenBagTypeValue -> ${nonwovenBagTypeValue}');
    debugPrint('Rony2 blockCost -> ${blockCost}');
    debugPrint('Rony2 printColorValue -> ${printColorValue}');
    debugPrint('Rony2 wastage -> ${wastage}');
    debugPrint(
        'Rony2 nonwovanUnitLocals.gussetPrint -> ${nonwovanUnitLocals.gussetPrint}');
    debugPrint(
        'Rony2 nonwovanUnitLocals.zipper -> ${nonwovanUnitLocals.zipper}');
    debugPrint('Rony2 deliveryCost -> ${deliveryCost}');
    debugPrint('Rony2 additioonalCost -> ${additioonalCost}');
    debugPrint('Rony2 profit -> ${profit}');
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

    //ref.read(nonwovanBagProvider.notifier).setUnitPrice(bagPrice);

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      LocalKeys.nonwovenModelState,
      jsonEncode(nonwovenBag.toJson()),
    );

    debugPrint('Rony2 bagPrice -> $bagPrice');

    return bagPrice.toStringAsFixed(4);
  }

  /// Get NonwovenUnitLocals value based on the bag type
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

  /// Get handle Fabric value based on the bag type
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

// ignore_for_file: use_setters_to_change_properties

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:silme/features/nonwovan/model/nonwoven.dart';
import 'package:silme/features/nonwovan/model/nonwoven_unit_locals.dart';
import 'package:silme/features/nonwovan/provider/gusset_print_provider.dart';
import 'package:silme/features/nonwovan/provider/nonwovan_bag_type_provider.dart';
import 'package:silme/features/nonwovan/provider/nonwoven_bag_provider.dart';
import 'package:silme/features/nonwovan/provider/nonwoven_delivery_type_provider.dart';
import 'package:silme/features/nonwovan/provider/nonwoven_print_type_provider.dart';

part 'nonwoven_unit_price_provider.g.dart';

/// Selected cotton type bag
@riverpod
class NonwovenUnitPrice extends _$NonwovenUnitPrice {
  @override
  String build() {
    final nonWovenBag = ref.watch(nonwovanBagProvider);
    final nonwovenBagType = ref.watch(nonwovanBagTypeProvider);
    final nonwovenBagTypeValue = ref.watch(nonwovanBagTypeValueProvider);
    final printColorValue = ref.watch(nonwovenPrintTypeValueProvider);
    final allowGussetPrint = ref.watch(gussetPrintProvider);
    final allowZipper = ref.watch(gussetPrintProvider);
    final deliveryType = ref.watch(nonwovenDeliveryTypeProvider);

    final nonwovanUnitLocals = getNonwovenUnitLocals(
      nonwovenBagType,
      nonWovenBag,
      allowGussetPrint,
      allowZipper,
    );

    final fabricPrice = nonwovanUnitLocals.fabricSqInch *
        0.00067 *
        (nonWovenBag.fabricPrice / 1000) *
        nonWovenBag.gsm;

    final wastage = nonWovenBag.fabricPrice * (2 / 100);

    final blockCost =
        ((nonWovenBag.height - 4) * (nonWovenBag.width - 3) * 10) /
            nonWovenBag.quanntity;
    var deliveryCost = 0.0;
    if (deliveryType == 1) {
      deliveryCost = nonWovenBag.homeDeliveryCost / nonWovenBag.quanntity;
    }

    final bagPrice = fabricPrice +
        nonwovenBagTypeValue +
        blockCost +
        printColorValue +
        wastage +
        nonwovanUnitLocals.gussetPrint +
        nonwovanUnitLocals.zipper +
        deliveryCost +
        nonWovenBag.additioonalCost +
        nonWovenBag.profit;

    return bagPrice.toStringAsFixed(4);
  }

  /// Get NonwovenUnitLocals value based on the bag type
  NonwovenUnitLocals getNonwovenUnitLocals(
    String nonwovenBagType,
    Nonwovan nonWovenBag,
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
    switch (nonwovenBagType) {
      case 'Select Bag Type':
        return nonwovenUnitLocals;
      case 'Handle Bag':
        const heming = 1.5;
        const handleFabric = 70.0;

        nonwovenUnitLocals.heming = heming;

        nonwovenUnitLocals.handleFabric = handleFabric;

        nonwovenUnitLocals.fabricSqInch =
            ((nonWovenBag.height + heming) * nonWovenBag.width * 2) +
                (nonWovenBag.gusset * nonWovenBag.width) +
                handleFabric;

        return nonwovenUnitLocals;
      case 'D Cut Bag':
        const heming = 2.5;

        nonwovenUnitLocals.heming = heming;

        nonwovenUnitLocals.fabricSqInch =
            ((nonWovenBag.height + heming) * nonWovenBag.width * 2) +
                (nonWovenBag.gusset * nonWovenBag.width);

        return nonwovenUnitLocals;
      case 'Sewing Bag':
        const heming = 1.5;
        const handleFabric = 70.0;
        const runner = 1.0;
        final piping = (nonWovenBag.height * 4) + (nonWovenBag.width * 2) + 10;

        nonwovenUnitLocals.heming = heming;

        nonwovenUnitLocals.handleFabric = handleFabric;

        nonwovenUnitLocals.runner = runner;

        if (allowGussetPrint == 1) {
          nonwovenUnitLocals.gussetPrint = 1 +
              ((nonWovenBag.height - 3) * (nonWovenBag.width - 1) * 10) /
                  nonWovenBag.quanntity;
        }

        nonwovenUnitLocals.piping = piping;

        if (allowZipper == 1) {
          nonwovenUnitLocals.zipper = runner +
              ((nonWovenBag.width + 3) * 0.15) +
              3 +
              ((nonWovenBag.width + 1) * nonWovenBag.height) *
                  0.00067 *
                  nonWovenBag.gsm *
                  (nonWovenBag.fabricPrice / 1000);
        }

        nonwovenUnitLocals.fabricSqInch =
            ((nonWovenBag.height + heming) * nonWovenBag.width * 2) +
                (nonWovenBag.gusset *
                    ((nonWovenBag.height + heming) * 2 + nonWovenBag.width)) +
                handleFabric +
                piping;

        return nonwovenUnitLocals;
      case 'Autobox Handle Bag':
        const heming = 1.5;
        const handleFabric = 70.0;

        nonwovenUnitLocals.heming = heming;

        nonwovenUnitLocals.handleFabric = handleFabric;

        nonwovenUnitLocals.fabricSqInch =
            ((nonWovenBag.height + heming) * nonWovenBag.width * 2) +
                ((nonWovenBag.gusset + 0.75) *
                    ((nonWovenBag.height + heming) * 2 + nonWovenBag.width)) +
                handleFabric;

        return nonwovenUnitLocals;
      case 'Autobox D Cut Bag':
        const heming = 2.5;

        nonwovenUnitLocals.heming = heming;

        nonwovenUnitLocals.fabricSqInch =
            ((nonWovenBag.height + heming) * nonWovenBag.width * 2) +
                ((nonWovenBag.gusset + 0.75) *
                    ((nonWovenBag.height + heming) * 2 + nonWovenBag.width));

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

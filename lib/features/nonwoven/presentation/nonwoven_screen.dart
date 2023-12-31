import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:silme/common/custom_outlined_text_form_field.dart';
import 'package:silme/features/nonwoven/model/nonwoven.dart';
import 'package:silme/features/nonwoven/presentation/component/nonwoven_bag_type_dropdown.dart';
import 'package:silme/features/nonwoven/presentation/component/nonwoven_delivery_container.dart';
import 'package:silme/features/nonwoven/presentation/component/print_color_dropdown.dart';
import 'package:silme/features/nonwoven/provider/nonwoven_gusset_print_provider.dart';
import 'package:silme/features/nonwoven/provider/nonwovan_bag_type_provider.dart';
import 'package:silme/features/nonwoven/provider/nonwoven_bag_provider.dart';
import 'package:silme/features/nonwoven/provider/nonwoven_delivery_type_provider.dart';
import 'package:silme/features/nonwoven/provider/nonwoven_print_type_provider.dart';
import 'package:silme/features/nonwoven/provider/nonwoven_unit_price_provider.dart';
import 'package:silme/features/nonwoven/provider/nonwoven_zipper_provider.dart';
import 'package:silme/utils/local_keys.dart';

/// This file contains the NonwovanScreen widget which is responsible for
/// rendering the UI for the Non-wovan Bag feature.
///
/// It also contains several helper methods for building the UI components such
/// as fabricDetails, fabricPrice, bagSize, bagGSMGusset, bagGussetPrint,
/// bagZipper, etc.
///
/// The widget uses the ConsumerStatefulWidget and ConsumerState classes from
/// the flutter_riverpod package to manage the state of the NonwovanScreen
/// widget.
///
/// It also uses several TextEditingController instances to manage the input
/// fields and SharedPreferences to persist the state of the widget.
class NonwovenScreen extends ConsumerStatefulWidget {
  /// Default Constructor
  const NonwovenScreen({super.key});
  @override
  ConsumerState<NonwovenScreen> createState() => _NonwovenScreenState();
}

class _NonwovenScreenState extends ConsumerState<NonwovenScreen> {
  final fabricPriceController = TextEditingController();
  final heightController = TextEditingController();
  final widthController = TextEditingController();
  final gsmController = TextEditingController();
  final gussetController = TextEditingController();
  final quantityController = TextEditingController();
  final additionaCostController = TextEditingController();
  final profitController = TextEditingController();
  final homeDeliveryController = TextEditingController();

  @override
  void initState() {
    _loadSharedPreference();
    super.initState();
  }

  @override
  void dispose() {
    fabricPriceController.dispose();
    heightController.dispose();
    widthController.dispose();
    gsmController.dispose();
    gussetController.dispose();
    quantityController.dispose();
    additionaCostController.dispose();
    profitController.dispose();
    homeDeliveryController.dispose();
    super.dispose();
  }

  /// Load saved value from shared preference
  Future<void> _loadSharedPreference() async {
    final prefs = await SharedPreferences.getInstance();
    final encodedJson = prefs.getString(LocalKeys.nonwovenModelState);
    // ignore: inference_failure_on_uninitialized_variable, prefer_typing_uninitialized_variables
    var nonwovenBagJson;

    try {
      if (encodedJson != null) {
        final decodedJson = jsonDecode(encodedJson) as Map<String, dynamic>;
        nonwovenBagJson = Nonwovan.fromJson(decodedJson);
      }
    } catch (e) {
      debugPrint('Rony2 nonwovenBagJson jsonDecode error -> $e');
    }

    if (nonwovenBagJson != null && nonwovenBagJson is Nonwovan) {
      ref.read(nonwovanBagProvider.notifier).setNonwovenBag(nonwovenBagJson);
      setInitialControllerValues();
    }
  }

  void setInitialControllerValues() {
    final nonwovanBag = ref.read(nonwovanBagProvider);
    if (nonwovanBag.fabricPrice.isNotEmpty) {
      fabricPriceController.text = nonwovanBag.fabricPrice;
    }
    if (nonwovanBag.height.isNotEmpty) {
      heightController.text = nonwovanBag.height;
    }
    if (nonwovanBag.width.isNotEmpty) {
      widthController.text = nonwovanBag.width;
    }
    if (nonwovanBag.gsm.isNotEmpty) {
      gsmController.text = nonwovanBag.gsm;
    }
    if (nonwovanBag.gusset.isNotEmpty) {
      gussetController.text = nonwovanBag.gusset;
    }
    if (nonwovanBag.quanntity.isNotEmpty) {
      quantityController.text = nonwovanBag.quanntity;
    }
    if (nonwovanBag.additioonalCost.isNotEmpty) {
      additionaCostController.text = nonwovanBag.additioonalCost;
    }
    if (nonwovanBag.profit.isNotEmpty) {
      profitController.text = nonwovanBag.profit;
    }
    if (nonwovanBag.homeDeliveryCost.isNotEmpty) {
      homeDeliveryController.text = nonwovanBag.homeDeliveryCost;
    }
    if (nonwovanBag.bagType.isNotEmpty) {
      ref
          .read(nonwovanBagTypeProvider.notifier)
          .setNonwovenType(nonwovanBag.bagType);
    }
    if (nonwovanBag.printColor.isNotEmpty) {
      ref
          .read(nonwovenPrintTypeProvider.notifier)
          .setPrintType(nonwovanBag.printColor);
    }
    if (nonwovanBag.deliveryType.contains('1')) {
      ref
          .read(nonwovenDeliveryTypeProvider.notifier)
          .setDeliveryType(int.parse(nonwovanBag.deliveryType));
    }
    if (nonwovanBag.gussetPrint.contains('1')) {
      ref
          .read(nonwovenGussetPrintProvider.notifier)
          .setGussetPrint(int.parse(nonwovanBag.gussetPrint));
    }
    if (nonwovanBag.zipper.contains('1')) {
      ref
          .read(nonwovenZipperProvider.notifier)
          .setZipper(int.parse(nonwovanBag.zipper));
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            height: 220,
            child: Image.asset(
              'assets/images/round_shape.png',
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              title: const Text('Non-wovan Bag'),
            ),
            body: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.only(
                  top: 40,
                  left: 20,
                  right: 20,
                ),
                width: size.width,
                child: fabricDetails(
                  ref,
                  context,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Fabric details
  Column fabricDetails(
    WidgetRef ref,
    BuildContext context,
  ) {
    final showGussetZipper = ref.watch(nonwovanBagTypeProvider);
    return Column(
      children: [
        NonwovenBagTypeDropdown(),
        const Gap(12),
        fabricPrice(ref),
        const Gap(8),
        bagSize(ref),
        const Gap(8),
        bagGSMGusset(ref),
        const Gap(8),
        PrintColorDropdown(),
        const Gap(12),
        if (showGussetZipper == 'Sewing Bag')
          bagGussetPrintAndZipper(ref, context),
        bagQuantityAdditionalCost(ref),
        const Gap(8),
        bagProfit(ref),
        const Gap(8),
        NonwovenDeliveryContianer(
          homeDeliveryController: homeDeliveryController,
        ),
        const Gap(12),
        unitPrice(ref, context),
        const Gap(8),
      ],
    );
  }

  /// Bag Gusset and Zipper
  Column bagGussetPrintAndZipper(WidgetRef ref, BuildContext context) {
    return Column(
      children: [
        bagGussetPrint(ref, context),
        const Gap(8),
        bagZipper(ref, context),
        const Gap(8),
      ],
    );
  }

  /// Fabric Price
  Widget fabricPrice(WidgetRef ref) {
    return CustomOutlinedTextFormField(
      controller: fabricPriceController,
      label: 'Fabric Price',
      numberOnly: true,
      onChanged: (value) {
        if (value == '') {
          ref.read(nonwovanBagProvider.notifier).setFabricPrice('');
        } else {
          ref.read(nonwovanBagProvider.notifier).setFabricPrice(value);
        }
      },
    );
  }

  /// Bag Gusset and Print Color
  Row bagGSMGusset(WidgetRef ref) {
    return Row(
      children: [
        Expanded(
          child: CustomOutlinedTextFormField(
            controller: gsmController,
            label: 'GSM',
            numberOnly: true,
            onChanged: (value) {
              if (value == '') {
                ref.read(nonwovanBagProvider.notifier).setGsm('');
              } else {
                ref.read(nonwovanBagProvider.notifier).setGsm(value);
              }
            },
          ),
        ),
        const Gap(8),
        Expanded(
          child: CustomOutlinedTextFormField(
            controller: gussetController,
            label: 'Gusset',
            numberOnly: true,
            onChanged: (value) {
              if (value == '') {
                ref.read(nonwovanBagProvider.notifier).setGusset('');
              } else {
                ref.read(nonwovanBagProvider.notifier).setGusset(value);
              }
            },
          ),
        ),
      ],
    );
  }

  /// Bag Size (Height and Width)
  Row bagSize(WidgetRef ref) {
    return Row(
      children: [
        Expanded(
          child: CustomOutlinedTextFormField(
            controller: heightController,
            label: 'Height',
            numberOnly: true,
            onChanged: (value) {
              if (value == '') {
                ref.read(nonwovanBagProvider.notifier).setHeight('');
              } else {
                ref.read(nonwovanBagProvider.notifier).setHeight(value);
              }
            },
          ),
        ),
        const Gap(8),
        Expanded(
          child: CustomOutlinedTextFormField(
            controller: widthController,
            label: 'Width',
            numberOnly: true,
            onChanged: (value) {
              if (value == '') {
                ref.read(nonwovanBagProvider.notifier).setWidth('');
              } else {
                ref.read(nonwovanBagProvider.notifier).setWidth(value);
              }
            },
          ),
        ),
      ],
    );
  }

  /// Bag Gusset Print (Yes or No)
  Row bagGussetPrint(WidgetRef ref, BuildContext context) {
    final selectedValue = ref.watch(nonwovenGussetPrintProvider);
    return Row(
      children: [
        Text(
          'Gusset Print',
          style: Theme.of(context).textTheme.titleSmall,
        ),
        Row(
          children: [
            SizedBox(
              width: 100,
              height: 48,
              child: RadioListTile(
                contentPadding: EdgeInsets.zero,
                value: 1,
                visualDensity: VisualDensity.compact,
                groupValue: selectedValue,
                title: const Text('Yes'),
                onChanged: (val) {
                  ref
                      .read(nonwovenGussetPrintProvider.notifier)
                      .setGussetPrint(val!);
                },
                activeColor: Colors.green[700],
                selected: selectedValue == 1,
              ),
            ),
            SizedBox(
              width: 100,
              height: 48,
              child: RadioListTile(
                contentPadding: EdgeInsets.zero,
                value: 2,
                visualDensity: VisualDensity.compact,
                groupValue: selectedValue,
                title: const Text('No'),
                onChanged: (val) {
                  ref
                      .read(nonwovenGussetPrintProvider.notifier)
                      .setGussetPrint(val!);
                },
                activeColor: Colors.green[700],
                selected: selectedValue == 2,
              ),
            ),
          ],
        )
      ],
    );
  }

  /// Bag Zipper (Yes or No)
  Row bagZipper(WidgetRef ref, BuildContext context) {
    final selectedValue = ref.watch(nonwovenZipperProvider);
    return Row(
      children: [
        Text(
          'Zipper',
          style: Theme.of(context).textTheme.titleSmall,
        ),
        Row(
          children: [
            SizedBox(
              width: 100,
              height: 48,
              child: RadioListTile(
                contentPadding: EdgeInsets.zero,
                value: 1,
                visualDensity: VisualDensity.compact,
                groupValue: selectedValue,
                title: const Text('Yes'),
                onChanged: (val) {
                  ref.read(nonwovenZipperProvider.notifier).setZipper(val!);
                },
                activeColor: Colors.green[700],
                selected: selectedValue == 1,
              ),
            ),
            SizedBox(
              width: 100,
              height: 48,
              child: RadioListTile(
                contentPadding: EdgeInsets.zero,
                value: 2,
                visualDensity: VisualDensity.compact,
                groupValue: selectedValue,
                title: const Text('No'),
                onChanged: (val) {
                  ref.read(nonwovenZipperProvider.notifier).setZipper(val!);
                },
                activeColor: Colors.green[700],
                selected: selectedValue == 2,
              ),
            ),
          ],
        )
      ],
    );
  }

  /// Bag Quantity
  Widget bagQuantityAdditionalCost(WidgetRef ref) {
    return Row(
      children: [
        Expanded(
          child: CustomOutlinedTextFormField(
            controller: quantityController,
            label: 'Quantity',
            numberOnly: true,
            allowDecimal: false,
            onChanged: (value) {
              if (value == '') {
                ref.read(nonwovanBagProvider.notifier).setQuantity('');
              } else {
                ref.read(nonwovanBagProvider.notifier).setQuantity(value);
              }
            },
          ),
        ),
        const Gap(8),
        Expanded(
          child: CustomOutlinedTextFormField(
            controller: additionaCostController,
            label: 'Additional Cost',
            numberOnly: true,
            onChanged: (value) {
              if (value == '') {
                ref.read(nonwovanBagProvider.notifier).setAdditionalCost('');
              } else {
                ref.read(nonwovanBagProvider.notifier).setAdditionalCost(value);
              }
            },
          ),
        ),
      ],
    );
  }

  /// Total Price of the bag
  Widget unitPrice(WidgetRef ref, BuildContext context) {
    final unitPrice = ref.watch(nonwovenUnitPriceProvider);

    var value = '';
    if (unitPrice.value != null && unitPrice.value != 'null') {
      value = unitPrice.value!;
    }

    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Theme.of(context).colorScheme.primary,
        ),
        color: Theme.of(context).colorScheme.surfaceVariant,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 5,
          ),
        ],
      ),
      child: Row(
        children: [
          Text(
            'Unit Price',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const Spacer(),
          Text(
            value,
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ],
      ),
    );
  }

  /// Bag Profit
  Widget bagProfit(WidgetRef ref) {
    return CustomOutlinedTextFormField(
      controller: profitController,
      label: 'Profit',
      numberOnly: true,
      onChanged: (value) {
        if (value == '') {
          ref.read(nonwovanBagProvider.notifier).setProfit('');
        } else {
          ref.read(nonwovanBagProvider.notifier).setProfit(value);
        }
      },
    );
  }
}

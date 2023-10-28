import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:silme/common/custom_outlined_text_form_field.dart';
import 'package:silme/features/nonwovan/model/nonwoven.dart';
import 'package:silme/features/nonwovan/presentation/component/nonwoven_bag_type_dropdown.dart';
import 'package:silme/features/nonwovan/presentation/component/print_color_dropdown.dart';
import 'package:silme/features/nonwovan/provider/gusset_print_provider.dart';
import 'package:silme/features/nonwovan/provider/nonwovan_bag_type_provider.dart';
import 'package:silme/features/nonwovan/provider/nonwoven_bag_provider.dart';
import 'package:silme/features/nonwovan/provider/nonwoven_delivery_type_provider.dart';
import 'package:silme/features/nonwovan/provider/nonwoven_unit_price_provider.dart';
import 'package:silme/features/nonwovan/provider/zipper_provider.dart';
import 'package:silme/utils/app_sizes.dart';
import 'package:silme/utils/local_keys.dart';

/// Returns the column containing the fabric details.
class NonwovanScreen extends StatefulHookConsumerWidget {
  /// Default Constructor
  const NonwovanScreen({super.key});
  @override
  ConsumerState<NonwovanScreen> createState() => _NonwovanScreenState();
}

class _NonwovanScreenState extends ConsumerState<NonwovanScreen> {
  @override
  void initState() {
    _loadSharedPreference();
    super.initState();
  }

  /// Load saved value from shared preference
  Future<void> _loadSharedPreference() async {
    final prefs = await SharedPreferences.getInstance();
    final nonwovenBagJsonEncoded =
        prefs.getString(LocalKeys.nonwovenModelState);
    // ignore: inference_failure_on_uninitialized_variable
    var nonwovenBagJson;
    try {
      if (nonwovenBagJsonEncoded != null) {
        nonwovenBagJson = jsonDecode(nonwovenBagJsonEncoded);
      }
    } catch (e) {
      debugPrint('Rony2 nonwovenBagJson jsonDecode error -> $e');
    }

    if (nonwovenBagJson != null && nonwovenBagJson is Nonwovan) {
      ref.read(nonwovanBagProvider.notifier).setNonwovenBag(nonwovenBagJson);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final nonwovenBag = ref.watch(nonwovanBagProvider);

    final fabricPriceController = useTextEditingController(
      text: (nonwovenBag.fabricPrice != 0.0)
          ? nonwovenBag.fabricPrice.toString()
          : '',
    );
    final heightController = useTextEditingController(
      text: (nonwovenBag.height != 0.0) ? nonwovenBag.height.toString() : '',
    );
    final widthController = useTextEditingController(
      text: (nonwovenBag.width != 0.0) ? nonwovenBag.width.toString() : '',
    );
    final gsmController = useTextEditingController(
      text: (nonwovenBag.gsm != 0.0) ? nonwovenBag.gsm.toString() : '',
    );
    final gussetController = useTextEditingController(
      text: (nonwovenBag.gusset != 0.0) ? nonwovenBag.gusset.toString() : '',
    );
    final quantityController = useTextEditingController(
      text:
          (nonwovenBag.quanntity != 0) ? nonwovenBag.quanntity.toString() : '',
    );
    final additionaCostController = useTextEditingController(
      text: (nonwovenBag.additioonalCost != 0.0)
          ? nonwovenBag.additioonalCost.toString()
          : '',
    );
    final profitController = useTextEditingController(
      text: (nonwovenBag.profit != 0.0) ? nonwovenBag.profit.toString() : '',
    );
    final homeDeliveryController = useTextEditingController(
      text: (nonwovenBag.homeDeliveryCost != 0.0)
          ? nonwovenBag.homeDeliveryCost.toString()
          : '',
    );
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
                  fabricPriceController,
                  heightController,
                  widthController,
                  gsmController,
                  gussetController,
                  quantityController,
                  additionaCostController,
                  profitController,
                  homeDeliveryController,
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
    TextEditingController fabricPriceController,
    TextEditingController heightController,
    TextEditingController widthController,
    TextEditingController gsmController,
    TextEditingController gussetController,
    TextEditingController quantityController,
    TextEditingController additionaCostController,
    TextEditingController profitController,
    TextEditingController homeDeliveryController,
  ) {
    final showGussetZipper = ref.watch(nonwovanBagTypeProvider);
    return Column(
      children: [
        NonwovenBagTypeDropdown(),
        gapH12,
        fabricPrice(
          ref,
          fabricPriceController,
        ),
        gapH8,
        bagSize(
          ref,
          heightController,
          widthController,
        ),
        gapH8,
        bagGSMGusset(
          ref,
          gsmController,
          gussetController,
        ),
        gapH8,
        PrintColorDropdown(),
        gapH8,
        if (showGussetZipper == 'Sewing Bag')
          bagGussetPrintAndZipper(ref, context),
        bagQuantityAdditionalCost(
          ref,
          quantityController,
          additionaCostController,
        ),
        gapH8,
        bagProfit(ref, profitController),
        gapH8,
        bagDeliveryType(
          ref,
          context,
          homeDeliveryController,
        ),
        gapH12,
        unitPrice(ref, context),
        gapH8,
      ],
    );
  }

  /// Bag Gusset and Zipper
  Column bagGussetPrintAndZipper(WidgetRef ref, BuildContext context) {
    return Column(
      children: [
        bagGussetPrint(ref, context),
        gapH8,
        bagZipper(ref, context),
        gapH8,
      ],
    );
  }

  /// Fabric Price
  Widget fabricPrice(
    WidgetRef ref,
    TextEditingController fabricPriceController,
  ) {
    return CustomOutlinedTextFormField(
      controller: fabricPriceController,
      label: 'Fabric Price',
      numberOnly: true,
      onChanged: (value) {
        if (value == '') {
          ref.read(nonwovanBagProvider.notifier).setFabricPrice(0);
        } else {
          ref
              .read(nonwovanBagProvider.notifier)
              .setFabricPrice(double.parse(value));
        }
      },
    );
  }

  /// Bag Gusset and Print Color
  Row bagGSMGusset(
    WidgetRef ref,
    TextEditingController gsmController,
    TextEditingController gussetController,
  ) {
    return Row(
      children: [
        Expanded(
          child: CustomOutlinedTextFormField(
            controller: gsmController,
            label: 'GSM',
            numberOnly: true,
            onChanged: (value) {
              if (value == '') {
                ref.read(nonwovanBagProvider.notifier).setGsm(0);
              } else {
                ref
                    .read(nonwovanBagProvider.notifier)
                    .setGsm(double.parse(value));
              }
            },
          ),
        ),
        gapW8,
        Expanded(
          child: CustomOutlinedTextFormField(
            controller: gussetController,
            label: 'Gusset',
            numberOnly: true,
            onChanged: (value) {
              if (value == '') {
                ref.read(nonwovanBagProvider.notifier).setGusset(0);
              } else {
                ref
                    .read(nonwovanBagProvider.notifier)
                    .setGusset(double.parse(value));
              }
            },
          ),
        ),
      ],
    );
  }

  /// Bag Size (Height and Width)
  Row bagSize(
    WidgetRef ref,
    TextEditingController heightController,
    TextEditingController widthController,
  ) {
    return Row(
      children: [
        Expanded(
          child: CustomOutlinedTextFormField(
            controller: heightController,
            label: 'Height',
            numberOnly: true,
            onChanged: (value) {
              if (value == '') {
                ref.read(nonwovanBagProvider.notifier).setHeight(0);
              } else {
                ref
                    .read(nonwovanBagProvider.notifier)
                    .setHeight(double.parse(value));
              }
            },
          ),
        ),
        gapW8,
        Expanded(
          child: CustomOutlinedTextFormField(
            controller: widthController,
            label: 'Width',
            numberOnly: true,
            onChanged: (value) {
              if (value == '') {
                ref.read(nonwovanBagProvider.notifier).setWidth(0);
              } else {
                ref
                    .read(nonwovanBagProvider.notifier)
                    .setWidth(double.parse(value));
              }
            },
          ),
        ),
      ],
    );
  }

  /// Bag Gusset Print (Yes or No)
  Row bagGussetPrint(WidgetRef ref, BuildContext context) {
    final selectedValue = ref.watch(gussetPrintProvider);
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
                  ref.read(gussetPrintProvider.notifier).setGussetPrint(val!);
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
                  ref.read(gussetPrintProvider.notifier).setGussetPrint(val!);
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
    final selectedValue = ref.watch(zipperProvider);
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
                  ref.read(zipperProvider.notifier).setZipper(val!);
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
                  ref.read(zipperProvider.notifier).setZipper(val!);
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
  Widget bagQuantityAdditionalCost(
    WidgetRef ref,
    TextEditingController quantityController,
    TextEditingController additionaCostController,
  ) {
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
                ref.read(nonwovanBagProvider.notifier).setQuantity(0);
              } else {
                ref
                    .read(nonwovanBagProvider.notifier)
                    .setQuantity(int.parse(value));
              }
            },
          ),
        ),
        gapW8,
        Expanded(
          child: CustomOutlinedTextFormField(
            controller: additionaCostController,
            label: 'Additional Cost',
            numberOnly: true,
            onChanged: (value) {
              if (value == '') {
                ref.read(nonwovanBagProvider.notifier).setAdditionalCost(0);
              } else {
                ref
                    .read(nonwovanBagProvider.notifier)
                    .setAdditionalCost(double.parse(value));
              }
            },
          ),
        ),
      ],
    );
  }

  /// Bag Delivery Type options
  Widget bagDeliveryType(
    WidgetRef ref,
    BuildContext context,
    TextEditingController homeDeliveryController,
  ) {
    final selectedValue = ref.watch(nonwovenDeliveryTypeProvider);
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Theme.of(context).colorScheme.primary,
        ),
        color: Theme.of(context).colorScheme.surfaceVariant,
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'Delivery',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ),
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    SizedBox(
                      height: 48,
                      child: RadioListTile(
                        contentPadding: EdgeInsets.zero,
                        value: 0,
                        visualDensity: VisualDensity.compact,
                        groupValue: selectedValue,
                        title: const Text('Without Delivery'),
                        onChanged: (val) {
                          ref
                              .read(nonwovenDeliveryTypeProvider.notifier)
                              .setDeliveryType(val!);
                        },
                        activeColor: Colors.green[700],
                        selected: selectedValue == 0,
                      ),
                    ),
                    SizedBox(
                      height: 48,
                      child: RadioListTile(
                        contentPadding: EdgeInsets.zero,
                        value: 1,
                        visualDensity: VisualDensity.compact,
                        groupValue: selectedValue,
                        title: const Text('Home Delivery'),
                        onChanged: (val) {
                          ref
                              .read(nonwovenDeliveryTypeProvider.notifier)
                              .setDeliveryType(val!);
                        },
                        activeColor: Colors.green[700],
                        selected: selectedValue == 1,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          if (selectedValue == 1)
            CustomOutlinedTextFormField(
              controller: homeDeliveryController,
              label: 'Home Delivery',
              numberOnly: true,
              onChanged: (value) async {
                if (value == '') {
                  ref.read(nonwovanBagProvider.notifier).setHomeDeliveryCost(0);
                } else {
                  ref
                      .read(nonwovanBagProvider.notifier)
                      .setHomeDeliveryCost(double.parse(value));
                  final nonwovenBag = ref.read(nonwovanBagProvider);

                  final prefs = await SharedPreferences.getInstance();
                  await prefs.setString(
                    LocalKeys.nonwovenModelState,
                    jsonEncode(nonwovenBag.toJson()),
                  );
                }
              },
            ),
        ],
      ),
    );
  }

  /// Total Price of the bag
  Widget unitPrice(WidgetRef ref, BuildContext context) {
    final unitPrice = ref.watch(nonwovenUnitPriceProvider);
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
            unitPrice,
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ],
      ),
    );
  }

  /// Bag Profit
  Widget bagProfit(WidgetRef ref, TextEditingController profitController) {
    return CustomOutlinedTextFormField(
      controller: profitController,
      label: 'Profit',
      numberOnly: true,
      onChanged: (value) {
        if (value == '') {
          ref.read(nonwovanBagProvider.notifier).setProfit(0);
        } else {
          ref.read(nonwovanBagProvider.notifier).setProfit(double.parse(value));
        }
      },
    );
  }
}

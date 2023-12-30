import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:silme/common/custom_outlined_text_form_field.dart';
import 'package:silme/features/jute/model/jute.dart';
import 'package:silme/features/jute/presentation/component/jute_delivery_container.dart';
import 'package:silme/features/jute/provider/jute_bag_provider.dart';
import 'package:silme/features/jute/provider/jute_delivery_type_provider.dart';
import 'package:silme/features/jute/provider/jute_unit_price_provider.dart';
import 'package:silme/features/jute/provider/jute_zipper_provider.dart';
import 'package:silme/utils/local_keys.dart';

/// Jute Screen
class JuteScreen extends ConsumerStatefulWidget {
  /// Default Constructor
  const JuteScreen({super.key});

  @override
  ConsumerState<JuteScreen> createState() => _JuteScreenState();
}

class _JuteScreenState extends ConsumerState<JuteScreen> {
  final bodyFabricPriceController = TextEditingController();
  final gussetFabricPriceController = TextEditingController();
  final usablebodyFabricController = TextEditingController();
  final usablegussetFabricController = TextEditingController();
  final heightController = TextEditingController();
  final widthController = TextEditingController();
  final handleController = TextEditingController();
  final gussetController = TextEditingController();
  final printController = TextEditingController();
  final accessoriesController = TextEditingController();
  final quantityController = TextEditingController();
  final profitController = TextEditingController();
  final homeDeliveryController = TextEditingController();

  @override
  void initState() {
    _loadSharedPreference();
    super.initState();
  }

  @override
  void dispose() {
    bodyFabricPriceController.dispose();
    gussetFabricPriceController.dispose();
    heightController.dispose();
    widthController.dispose();
    handleController.dispose();
    gussetController.dispose();
    printController.dispose();
    accessoriesController.dispose();
    quantityController.dispose();
    profitController.dispose();
    homeDeliveryController.dispose();
    super.dispose();
  }

  /// Load saved value from shared preference
  Future<void> _loadSharedPreference() async {
    final prefs = await SharedPreferences.getInstance();
    final encodedJson = prefs.getString(LocalKeys.juteModelState);
    // ignore: inference_failure_on_uninitialized_variable, prefer_typing_uninitialized_variables
    var juteBagJson;

    try {
      if (encodedJson != null) {
        final decodedJson = jsonDecode(encodedJson) as Map<String, dynamic>;
        juteBagJson = Jute.fromJson(decodedJson);
      }
    } catch (e) {
      debugPrint('Rony2 nonwovenBagJson jsonDecode error -> $e');
    }

    if (juteBagJson != null && juteBagJson is Jute) {
      ref.read(juteBagProvider.notifier).setJuteBag(juteBagJson);
      setInitialControllerValues();
    }
  }

  void setInitialControllerValues() {
    final juteBag = ref.read(juteBagProvider);
    if (juteBag.bodyFabricPrice.isNotEmpty) {
      bodyFabricPriceController.text = juteBag.bodyFabricPrice;
    }

    if (juteBag.gussetFabricPrice.isNotEmpty) {
      gussetFabricPriceController.text = juteBag.gussetFabricPrice;
    }

    if (juteBag.usableBodyFabric.isNotEmpty) {
      usablebodyFabricController.text = juteBag.usableBodyFabric;
    }

    if (juteBag.usableGussetFabric.isNotEmpty) {
      usablegussetFabricController.text = juteBag.usableGussetFabric;
    }

    if (juteBag.height.isNotEmpty) {
      heightController.text = juteBag.height;
    }

    if (juteBag.width.isNotEmpty) {
      widthController.text = juteBag.width;
    }

    if (juteBag.handle.isNotEmpty) {
      handleController.text = juteBag.handle;
    }

    if (juteBag.gusset.isNotEmpty) {
      gussetController.text = juteBag.gusset;
    }

    if (juteBag.print.isNotEmpty) {
      printController.text = juteBag.print;
    }

    if (juteBag.accessories.isNotEmpty) {
      accessoriesController.text = juteBag.accessories;
    }

    if (juteBag.quantity.isNotEmpty) {
      quantityController.text = juteBag.quantity;
    }

    if (juteBag.profit.isNotEmpty) {
      profitController.text = juteBag.profit;
    }

    if (juteBag.homeDeliveryCost.isNotEmpty) {
      homeDeliveryController.text = juteBag.homeDeliveryCost;
    }

    if (juteBag.zipper.isNotEmpty) {
      ref
          .read(juteZipperProvider.notifier)
          .setZipper(int.parse(juteBag.zipper));
    }

    if (juteBag.deliveryType.contains('1')) {
      ref
          .read(juteDeliveryTypeProvider.notifier)
          .setDeliveryType(int.parse(juteBag.deliveryType));
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
              title: const Text('Jute Bag'),
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
    return Column(
      children: [
        bagBodyfabricPriceAndGussetFabricPrice(ref),
        const Gap(8),
        bagUsableBodyfabricWidthAndUsableGussetFabricWidth(ref),
        const Gap(8),
        bagSize(ref),
        const Gap(8),
        bagHandleAndGusset(ref),
        const Gap(8),
        bagPrintAndAccessories(ref),
        const Gap(8),
        bagQuantityAndProfit(ref),
        const Gap(8),
        bagZipper(ref, context),
        const Gap(8),
        JuteDeliveryContianer(
          homeDeliveryController: homeDeliveryController,
        ),
        const Gap(12),
        unitPrice(ref, context),
        const Gap(8),
      ],
    );
  }

  // Bag Usable Body Fabric Width and Usable Gusset Fabric Width
  bagUsableBodyfabricWidthAndUsableGussetFabricWidth(WidgetRef ref) {
    return Row(
      children: [
        Expanded(
          child: CustomOutlinedTextFormField(
            controller: usablebodyFabricController,
            label: 'Usable Body Fabric',
            hint: 'cm',
            numberOnly: true,
            onChanged: (value) {
              if (value == '') {
                ref.read(juteBagProvider.notifier).setUsableBodyFabric('');
              } else {
                ref.read(juteBagProvider.notifier).setUsableBodyFabric(value);
              }
            },
          ),
        ),
        const Gap(8),
        Expanded(
          child: CustomOutlinedTextFormField(
            controller: usablegussetFabricController,
            label: 'Usable Gusset Fabric',
            hint: 'cm',
            numberOnly: true,
            onChanged: (value) {
              if (value == '') {
                ref.read(juteBagProvider.notifier).setUsableGussetFabric('');
              } else {
                ref.read(juteBagProvider.notifier).setUsableGussetFabric(value);
              }
            },
          ),
        ),
      ],
    );
  }

  /// Bag Body Fabric Price and Gusset Fabric Price (Per Yard)
  Widget bagBodyfabricPriceAndGussetFabricPrice(WidgetRef ref) {
    return Row(
      children: [
        Expanded(
          child: CustomOutlinedTextFormField(
            controller: bodyFabricPriceController,
            label: 'Body Fabric',
            hint: 'Per Yard Price',
            numberOnly: true,
            onChanged: (value) {
              if (value == '') {
                ref.read(juteBagProvider.notifier).setBodyFabricPrice('');
              } else {
                ref.read(juteBagProvider.notifier).setBodyFabricPrice(value);
              }
            },
          ),
        ),
        const Gap(8),
        Expanded(
          child: CustomOutlinedTextFormField(
            controller: gussetFabricPriceController,
            label: 'Gusset Fabric',
            hint: 'Per Yard Price',
            numberOnly: true,
            onChanged: (value) {
              if (value == '') {
                ref.read(juteBagProvider.notifier).setGussetFabricPrice('');
              } else {
                ref.read(juteBagProvider.notifier).setGussetFabricPrice(value);
              }
            },
          ),
        ),
      ],
    );
  }

  /// Bag Handle and Gusset
  Row bagHandleAndGusset(WidgetRef ref) {
    return Row(
      children: [
        Expanded(
          child: CustomOutlinedTextFormField(
            controller: handleController,
            label: 'Handle',
            hint: 'cm',
            numberOnly: true,
            onChanged: (value) {
              if (value == '') {
                ref.read(juteBagProvider.notifier).setHandle('');
              } else {
                ref.read(juteBagProvider.notifier).setHandle(value);
              }
            },
          ),
        ),
        const Gap(8),
        Expanded(
          child: CustomOutlinedTextFormField(
            controller: gussetController,
            label: 'Gusset Width',
            hint: 'cm',
            numberOnly: true,
            onChanged: (value) {
              if (value == '') {
                ref.read(juteBagProvider.notifier).setGusset('');
              } else {
                ref.read(juteBagProvider.notifier).setGusset(value);
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
            hint: 'cm',
            numberOnly: true,
            onChanged: (value) {
              if (value == '') {
                ref.read(juteBagProvider.notifier).setHeight('');
              } else {
                ref.read(juteBagProvider.notifier).setHeight(value);
              }
            },
          ),
        ),
        const Gap(8),
        Expanded(
          child: CustomOutlinedTextFormField(
            controller: widthController,
            label: 'Width',
            hint: 'cm',
            numberOnly: true,
            onChanged: (value) {
              if (value == '') {
                ref.read(juteBagProvider.notifier).setWidth('');
              } else {
                ref.read(juteBagProvider.notifier).setWidth(value);
              }
            },
          ),
        ),
      ],
    );
  }

  /// Bag Zipper (Yes or No)
  Row bagZipper(WidgetRef ref, BuildContext context) {
    final selectedValue = ref.watch(juteZipperProvider);
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
                  ref.read(juteZipperProvider.notifier).setZipper(val!);
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
                  ref.read(juteZipperProvider.notifier).setZipper(val!);
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

  /// Bag Quantity and Additional Cost
  Widget bagPrintAndAccessories(WidgetRef ref) {
    return Row(
      children: [
        Expanded(
          child: CustomOutlinedTextFormField(
            controller: printController,
            label: 'Print',
            hint: 'Price',
            numberOnly: true,
            onChanged: (value) {
              if (value == '') {
                ref.read(juteBagProvider.notifier).setPrint('');
              } else {
                ref.read(juteBagProvider.notifier).setPrint(value);
              }
            },
          ),
        ),
        const Gap(8),
        Expanded(
          child: CustomOutlinedTextFormField(
            controller: accessoriesController,
            label: 'Accessories',
            hint: 'Price',
            numberOnly: true,
            onChanged: (value) {
              if (value == '') {
                ref.read(juteBagProvider.notifier).setAccessories('');
              } else {
                ref.read(juteBagProvider.notifier).setAccessories(value);
              }
            },
          ),
        ),
      ],
    );
  }

  /// Total Price of the bag
  Widget unitPrice(WidgetRef ref, BuildContext context) {
    final unitPrice = ref.watch(juteUnitPriceProvider);

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

  /// Bag Quantity and Profit
  Widget bagQuantityAndProfit(WidgetRef ref) {
    return Row(
      children: [
        Expanded(
          child: CustomOutlinedTextFormField(
            controller: quantityController,
            label: 'Quantity',
            hint: 'Unit',
            numberOnly: true,
            allowDecimal: false,
            onChanged: (value) {
              if (value == '') {
                ref.read(juteBagProvider.notifier).setQuantity('');
              } else {
                ref.read(juteBagProvider.notifier).setQuantity(value);
              }
            },
          ),
        ),
        const Gap(8),
        Expanded(
          child: CustomOutlinedTextFormField(
            controller: profitController,
            label: 'Profit',
            hint: 'Price',
            numberOnly: true,
            onChanged: (value) {
              if (value == '') {
                ref.read(juteBagProvider.notifier).setProfit('');
              } else {
                ref.read(juteBagProvider.notifier).setProfit(value);
              }
            },
          ),
        ),
      ],
    );
  }
}

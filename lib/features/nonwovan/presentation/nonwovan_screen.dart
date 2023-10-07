import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:silme/features/nonwovan/presentation/component/cotton_type_dropdown.dart';
import 'package:silme/features/nonwovan/presentation/component/print_type_dropdown.dart';
import 'package:silme/features/nonwovan/provider/delivery_type_provider.dart';
import 'package:silme/features/nonwovan/provider/gusset_print_provider.dart';
import 'package:silme/features/nonwovan/provider/zipper_provider.dart';
import 'package:silme/utils/app_sizes.dart';

/// Returns the column containing the fabric details.
class NonwovanScreen extends ConsumerWidget {
  /// Default Constructor
  const NonwovanScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                child: Column(
                  children: [
                    CottonTypeDropdown(),
                    gapH12,
                    fabricDetails(ref, context),
                    gapH8,
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Fabric details
  Column fabricDetails(WidgetRef ref, BuildContext context) {
    return Column(
      children: [
        fabricPrice(),
        gapH8,
        bagSize(),
        gapH8,
        bagGsmPrintType(),
        gapH8,
        bagGussetPrintColor(),
        gapH8,
        bagGussetPrint(ref, context),
        gapH8,
        bagZipper(ref, context),
        gapH8,
        bagQuantity(),
        gapH8,
        bagDeliveryType(ref, context),
        gapH12,
        totalPrice(ref, context),
      ],
    );
  }

  /// Bag GSM and Print Type
  Row bagGsmPrintType() {
    return Row(
      children: [
        Expanded(
          child: TextField(
            decoration: const InputDecoration(
              labelText: 'GSM',
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.symmetric(
                horizontal: 10,
              ),
            ),
            onChanged: (value) {
              // Do something with the value
            },
          ),
        ),
        gapW8,
        Expanded(
          child: PrintTypeDropdown(),
        ),
      ],
    );
  }

  /// Fabric Price
  TextField fabricPrice() {
    return TextField(
      decoration: const InputDecoration(
        labelText: 'Fabric Price',
        border: OutlineInputBorder(),
        contentPadding: EdgeInsets.symmetric(
          horizontal: 10,
        ),
      ),
      onChanged: (value) {
        // Do something with the value
      },
    );
  }

  /// Bag Gusset and Print Color
  Row bagGussetPrintColor() {
    return Row(
      children: [
        Expanded(
          child: TextField(
            decoration: const InputDecoration(
              labelText: 'Gusset',
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.symmetric(
                horizontal: 10,
              ),
            ),
            onChanged: (value) {
              // Do something with the value
            },
          ),
        ),
        gapW8,
        Expanded(
          child: TextField(
            decoration: const InputDecoration(
              labelText: 'Print Color',
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.symmetric(
                horizontal: 10,
              ),
            ),
            onChanged: (value) {
              // Do something with the value
            },
          ),
        ),
      ],
    );
  }

  /// Bag Size (Height and Width)
  Row bagSize() {
    return Row(
      children: [
        Expanded(
          child: TextField(
            decoration: const InputDecoration(
              labelText: 'Height',
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.symmetric(
                horizontal: 10,
              ),
            ),
            onChanged: (value) {
              // Do something with the value
            },
          ),
        ),
        gapW8,
        Expanded(
          child: TextField(
            decoration: const InputDecoration(
              labelText: 'Width',
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.symmetric(
                horizontal: 10,
              ),
            ),
            onChanged: (value) {
              // Do something with the value
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
  Widget bagQuantity() {
    return TextField(
      decoration: const InputDecoration(
        labelText: 'Quantity',
        border: OutlineInputBorder(),
        contentPadding: EdgeInsets.symmetric(
          horizontal: 10,
        ),
      ),
      onChanged: (value) {
        // Do something with the value
      },
    );
  }

  /// Bag Delivery Type options
  Widget bagDeliveryType(WidgetRef ref, BuildContext context) {
    final selectedValue = ref.watch(deliveryTypeProvider);
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Theme.of(context).colorScheme.primary,
        ),
        color: Theme.of(context).colorScheme.surfaceVariant,
      ),
      child: Row(
        children: [
          Text(
            'Delivery',
            style: Theme.of(context).textTheme.titleSmall,
          ),
          const Spacer(),
          Column(
            children: [
              SizedBox(
                width: 240,
                height: 48,
                child: RadioListTile(
                  contentPadding: EdgeInsets.zero,
                  value: 1,
                  visualDensity: VisualDensity.compact,
                  groupValue: selectedValue,
                  title: const Text('Without Delivery'),
                  onChanged: (val) {
                    ref
                        .read(deliveryTypeProvider.notifier)
                        .setDeliveryType(val!);
                  },
                  activeColor: Colors.green[700],
                  selected: selectedValue == 1,
                ),
              ),
              SizedBox(
                width: 240,
                height: 48,
                child: RadioListTile(
                  contentPadding: EdgeInsets.zero,
                  value: 2,
                  visualDensity: VisualDensity.compact,
                  groupValue: selectedValue,
                  title: const Text('Courier Delivery'),
                  onChanged: (val) {
                    ref
                        .read(deliveryTypeProvider.notifier)
                        .setDeliveryType(val!);
                  },
                  activeColor: Colors.green[700],
                  selected: selectedValue == 2,
                ),
              ),
              SizedBox(
                width: 240,
                height: 48,
                child: RadioListTile(
                  contentPadding: EdgeInsets.zero,
                  value: 3,
                  visualDensity: VisualDensity.compact,
                  groupValue: selectedValue,
                  title: const Text('Home Delivery'),
                  onChanged: (val) {
                    ref
                        .read(deliveryTypeProvider.notifier)
                        .setDeliveryType(val!);
                  },
                  activeColor: Colors.green[700],
                  selected: selectedValue == 3,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  /// Total Price of the bag
  Widget totalPrice(WidgetRef ref, BuildContext context) {
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
            'Total Price',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const Spacer(),
          Text(
            '120000',
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ],
      ),
    );
  }
}

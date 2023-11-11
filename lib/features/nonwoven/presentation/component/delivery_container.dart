import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:silme/common/custom_outlined_text_form_field.dart';
import 'package:silme/features/nonwoven/provider/nonwoven_bag_provider.dart';
import 'package:silme/features/nonwoven/provider/nonwoven_delivery_type_provider.dart';

/// Delivery Container
class DeliveryContianer extends ConsumerStatefulWidget {
  /// Default constructor
  const DeliveryContianer({required this.homeDeliveryController, super.key});

  /// Home delivery controller
  final TextEditingController homeDeliveryController;

  @override
  ConsumerState<DeliveryContianer> createState() => _DeliveryContianerState();
}

class _DeliveryContianerState extends ConsumerState<DeliveryContianer> {
  @override
  Widget build(BuildContext context) {
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
              controller: widget.homeDeliveryController,
              label: 'Home Delivery',
              numberOnly: true,
              onChanged: (value) {
                if (value == '') {
                  ref
                      .read(nonwovanBagProvider.notifier)
                      .setHomeDeliveryCost('');
                } else {
                  ref
                      .read(nonwovanBagProvider.notifier)
                      .setHomeDeliveryCost(value);
                }
              },
            ),
        ],
      ),
    );
  }
}

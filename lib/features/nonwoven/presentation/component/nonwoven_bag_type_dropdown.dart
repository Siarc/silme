import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:silme/features/nonwoven/provider/nonwovan_bag_type_provider.dart';
import 'package:silme/features/nonwoven/provider/nonwoven_bag_provider.dart';

/// Custom dropdown widget for nonwoven bag type bags
class NonwovenBagTypeDropdown extends ConsumerWidget {
  /// Default Constructor
  NonwovenBagTypeDropdown({super.key});

  final List<String> _nonwovanBagTypeList = [
    'Handle Bag',
    'D Cut Bag',
    'Autobox Handle Bag',
    'Autobox D Cut Bag',
    'Sewing Bag',
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final selectedItem = ref.watch(nonwovanBagTypeProvider);
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Theme.of(context).colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 5,
          ),
        ],
      ),
      width: size.width * 0.8,
      child: PopupMenuButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        offset: const Offset(0, 62),
        onSelected: (value) {
          ref.read(nonwovanBagProvider.notifier).setBagType(value);
          ref.read(nonwovanBagTypeProvider.notifier).setNonwovenType(value);
        },
        itemBuilder: (BuildContext context) {
          return _nonwovanBagTypeList.map((String item) {
            return PopupMenuItem(
              padding: EdgeInsets.zero,
              value: item,
              child: Container(
                width: size.width * 0.8,
                color: selectedItem == item
                    ? Theme.of(context).colorScheme.secondary.withOpacity(0.2)
                    : null,
                child: ListTile(
                  title: Text(item),
                  trailing:
                      selectedItem == item ? const Icon(Icons.check) : null,
                ),
              ),
            );
          }).toList();
        },
        child: ListTile(
          title: Text(
            selectedItem,
            style: TextStyle(
              color: selectedItem == 'Select Bag Type'
                  ? Theme.of(context).colorScheme.onSurface.withOpacity(0.5)
                  : Theme.of(context).colorScheme.onSurface,
            ),
          ),
          trailing: const Icon(Icons.keyboard_arrow_down_sharp),
        ),
      ),
    );
  }
}

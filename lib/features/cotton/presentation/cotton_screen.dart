import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

///
class CottonScreen extends ConsumerWidget {
  /// Default Constructor
  const CottonScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
              title: const Text('Cotton Bag'),
            ),
            body: Container(),
          ),
        ],
      ),
    );
  }
}

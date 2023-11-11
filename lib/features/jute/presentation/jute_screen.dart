import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

///
class JuteScreen extends ConsumerStatefulWidget {
  /// Default Constructor
  const JuteScreen({super.key});

  @override
  ConsumerState<JuteScreen> createState() => _JuteScreenState();
}

class _JuteScreenState extends ConsumerState<JuteScreen> {
  @override
  Widget build(BuildContext context) {
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
            body: Container(),
          ),
        ],
      ),
    );
  }
}

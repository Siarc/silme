import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:silme/common/custom_filled_button.dart';
import 'package:silme/features/dashboard/presentation/component/app_drawer.dart';

/// Landing Page of the application
class DashboardScreen extends ConsumerWidget {
  /// Default Constructor
  const DashboardScreen({super.key});

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
              title: const Text('Silme'),
            ),
            drawer: AppDrawer(),
            body: Container(
              width: size.width,
              padding: const EdgeInsets.only(top: 134),
              child: Column(
                children: <Widget>[
                  welcomeMessage(context),
                  const Gap(32),
                  differentBagTypes(context, size),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  /// Different bag types
  Column differentBagTypes(BuildContext context, Size size) {
    return Column(
      children: [
        SizedBox(
          width: size.width * 0.7,
          child: CustomFilledButton(
            label: 'Non-woven Bag',
            onPressed: () {
              context.go('/dashboard/nonwoven');
            },
          ),
        ),
        const Gap(8),
        SizedBox(
          width: size.width * 0.7,
          child: CustomFilledButton(
            label: 'Jute Bag',
            onPressed: () {
              context.go('/dashboard/jute');
            },
          ),
        ),
        const Gap(8),
        SizedBox(
          width: size.width * 0.7,
          child: CustomFilledButton(
            label: 'Cotton Bag',
            onPressed: () {
              context.go('/dashboard/cotton');
            },
          ),
        ),
      ],
    );
  }

  /// Welcome message
  Column welcomeMessage(BuildContext context) {
    return Column(
      children: [
        Text(
          'Welcome on board!',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const Text(
          'Let’s help you meet up your task',
        ),
      ],
    );
  }
}

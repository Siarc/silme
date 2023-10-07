import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:silme/common/custom_outlined_text_form_field.dart';
import 'package:silme/utils/app_sizes.dart';

///
class LoginScreen extends ConsumerWidget {
  /// Default Constructor
  const LoginScreen({super.key});

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
              title: const Text('Log In'),
            ),
            body: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  CustomOutlinedTextFormField(
                    label: 'User Name',
                  ),
                  gapH12,
                  CustomOutlinedTextFormField(
                    label: 'Password',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

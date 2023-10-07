import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:silme/common/custom_filled_button.dart';
import 'package:silme/common/custom_outlined_text_form_field.dart';
import 'package:silme/utils/app_sizes.dart';

/// Login Page of the application
/// Login with firebase auth
class LoginScreen extends HookConsumerWidget {
  /// Default Constructor
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final formKey = useMemoized(GlobalKey<FormState>.new);
    final usernameController = useTextEditingController();
    final passwordController = useTextEditingController();

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
            body: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomOutlinedTextFormField(
                      controller: usernameController,
                      label: 'Username',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter username';
                        }
                        return null;
                      },
                    ),
                    gapH16,
                    CustomOutlinedTextFormField(
                      controller: passwordController,
                      obscureText: true,
                      label: 'Password',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter password';
                        }
                        return null;
                      },
                    ),
                    gapH32,
                    SizedBox(
                      width: size.width * 0.7,
                      child: CustomFilledButton(
                        label: 'Login',
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            formKey.currentState?.save();
                            // Do something with the form data
                            final username = usernameController.text;
                            final password = passwordController.text;
                            debugPrint('Username: $username');
                            debugPrint('Password: $password');
                            context.pushReplacement('/dashboard');
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

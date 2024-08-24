import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:silme/common/custom_filled_button.dart';
import 'package:silme/common/custom_outlined_text_form_field.dart';
import 'package:silme/features/Authentication/auth/auth.dart';

/// Login Page of the application
/// Login with firebase auth
class LoginScreen extends ConsumerStatefulWidget {
  /// Default Constructor
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  Future<String> signInWithEmailAndPassword() async {
    try {
      await Auth().signInWithEmailAndPassword(
        email: usernameController.text,
        password: passwordController.text,
      );
      return 'Success';
    } on FirebaseAuthException catch (e) {
      return e.toString();
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
              title: const Text('Log In'),
            ),
            body: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
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
                        const Gap(16),
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
                      ],
                    ),
                    const Gap(32),
                    SizedBox(
                      width: size.width * 0.7,
                      child: CustomFilledButton(
                        label: 'Login',
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            formKey.currentState?.save();
                            final result = await signInWithEmailAndPassword();

                            if (!mounted) return;

                            if (result == 'Success') {
                              context.pushReplacement('/dashboard');
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(result),
                                ),
                              );
                            }
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

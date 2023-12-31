import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:silme/common/custom_filled_button.dart';
import 'package:silme/common/custom_outlined_text_form_field.dart';
import 'package:silme/features/Authentication/auth/auth.dart';

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

    String? errorMessage = '';

    /// Sign in with email and password
    /// ignore: unused_element
    Future<String> signInWithEmailAndPassword() async {
      try {
        await Auth().signInWithEmailAndPassword(
          email: usernameController.text,
          password: passwordController.text,
        );
        return 'Success';
      } on FirebaseAuthException catch (e) {
        errorMessage = e.toString();
        debugPrint('Error: $errorMessage');
        return errorMessage!;
      }
    }

    /// Login Button
    SizedBox loginButton(
      Size size,
      GlobalKey<FormState> formKey,
      TextEditingController usernameController,
      TextEditingController passwordController,
      BuildContext context,
    ) {
      return SizedBox(
        width: size.width * 0.7,
        child: CustomFilledButton(
          label: 'Login',
          onPressed: () {
            // if (formKey.currentState!.validate()) {
            //   formKey.currentState?.save();
            //   signInWithEmailAndPassword().then((value) {
            //     if (value == 'Success') {
            //       context.pushReplacement('/dashboard');
            //     } else {
            //       ScaffoldMessenger.of(context).showSnackBar(
            //         SnackBar(
            //           content: Text(value),
            //         ),
            //       );
            //     }
            //   });
            // }
            context.pushReplacement('/dashboard');
          },
        ),
      );
    }

    /// Text Fields for username and password
    Column textFields(
      TextEditingController usernameController,
      TextEditingController passwordController,
    ) {
      return Column(
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
      );
    }

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
                    textFields(
                      usernameController,
                      passwordController,
                    ),
                    const Gap(32),
                    loginButton(
                      size,
                      formKey,
                      usernameController,
                      passwordController,
                      context,
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

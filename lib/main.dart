import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:silme/utils/basic_route.dart';
import 'package:silme/utils/styles/styles.dart';
import 'package:silme/utils/styles/theme_provider.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

///
class MyApp extends ConsumerWidget {
  /// Default Constructor
  MyApp({super.key});

  /// It is important to initialize the [styles] instance
  final Styles styles = Styles();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeNotifer = ref.watch(themeProvider);
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: styles.themeData(themeNotifer.themeIndex, context),
      routerConfig: getGoRouter(),
    );
  }
}

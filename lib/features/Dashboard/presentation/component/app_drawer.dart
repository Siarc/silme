import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:silme/features/Authentication/auth/auth.dart';
import 'package:silme/utils/app_sizes.dart';

/// Application drawer
class AppDrawer extends ConsumerWidget {
  /// Default Constructor
  AppDrawer({
    super.key,
  });

  /// Current logged in user
  final User? user = Auth().currentUser;

  /// Sign out user
  Future<void> _signOut(BuildContext context) async {
    await Auth().signOut();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CircleAvatar(
                  radius: 30,
                  backgroundImage: AssetImage('assets/images/wlop_cat.png'),
                ),
                gapH12,
                Text(
                  'Bag Calculator',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                gapH4,
                Text(
                  'Silme Bag Industries Ltd.',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ],
            ),
          ),
          ListTile(
            title: const Text('Settings'),
            onTap: () {
              context
                ..pop()
                ..go('/dashboard/settings');
            },
          ),
          ListTile(
            title: const Text('Sign out'),
            onTap: () {
              _signOut(context).then((value) {
                context
                  ..pop()
                  ..go('/');
              });
            },
          ),
        ],
      ),
    );
  }
}

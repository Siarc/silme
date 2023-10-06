import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// Application drawer
class AppDrawer extends ConsumerWidget {
  /// Default Constructor
  const AppDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.inversePrimary,
            ),
            child: Text('TODO: Drawer Header'),
          ),
          ListTile(
            title: const Text('Settings'),
            onTap: () {
              context
                ..pop()
                ..go('/settings');
            },
          ),
          ListTile(
            title: const Text('Nothing'),
            onTap: () {
              context.pop();
            },
          ),
        ],
      ),
    );
  }
}

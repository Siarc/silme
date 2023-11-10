import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:silme/utils/styles/theme_provider.dart';

/// Settings Screen will be used to change the theme
class SettingsScreen extends ConsumerWidget {
  /// Default Constructor
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    /// List of images
    /// Used to change theme selection
    final images = <Map<String, String>>[
      {
        'name': 'Light',
        'path': 'assets/images/wlop_plane.png',
      },
      {
        'name': 'Dark',
        'path': 'assets/images/wlop_city.png',
      },
      {
        'name': 'Random',
        'path': 'assets/images/wlop_umbrella.png',
      },
    ];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Gap(4),
            const Text('Theme'),
            const Gap(4),
            SizedBox(
              height: 120,
              child: ListView.separated(
                separatorBuilder: (_, __) {
                  return const Gap(4);
                },
                scrollDirection: Axis.horizontal,
                itemCount: images.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      ref.read(themeProvider.notifier).setTheme(index);
                    },
                    child: Column(
                      children: [
                        Image.asset(
                          images[index]['path']!,
                          height: 100,
                          width: 60,
                          fit: BoxFit.cover,
                        ),
                        Text(
                          images[index]['name']!,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:silme/features/dashboard/presentation/dashboard_screen.dart';
import 'package:silme/features/settings/presentation/settings_screen.dart';

/// The route configuration.
GoRouter getGoRouter() {
  final navigatorKey = GlobalKey<NavigatorState>();

  final router = GoRouter(
    navigatorKey: navigatorKey,
    routes: <RouteBase>[
      GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState state) {
          return DashboardScreen();
        },
        routes: <RouteBase>[
          GoRoute(
            path: 'settings',
            builder: (BuildContext context, GoRouterState state) {
              return SettingsScreen();
            },
          ),
        ],
      ),
    ],
  );
  return router;
}

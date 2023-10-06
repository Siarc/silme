import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:silme/features/Dashboard/presentation/dashboard_page.dart';
import 'package:silme/features/Settings/settings_page.dart';

/// The route configuration.
GoRouter getGoRouter() {
  final navigatorKey = GlobalKey<NavigatorState>();

  final router = GoRouter(
    navigatorKey: navigatorKey,
    routes: <RouteBase>[
      GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState state) {
          return DashboardPage();
        },
        routes: <RouteBase>[
          GoRoute(
            path: 'settings',
            builder: (BuildContext context, GoRouterState state) {
              return SettingsPage();
            },
          ),
          // GoRoute(
          //   path: 'login',
          //   builder: (BuildContext context, GoRouterState state) {
          //     return const LoginPage();
          //   },
          // ),
        ],
      ),
    ],
  );
  return router;
}

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:silme/features/Authentication/presentation/login_screen.dart';
import 'package:silme/features/cotton/presentation/cotton_screen.dart';
import 'package:silme/features/dashboard/presentation/dashboard_screen.dart';
import 'package:silme/features/jute/presentation/jute_screen.dart';
import 'package:silme/features/nonwovan/presentation/nonwovan_screen.dart';
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
          return const LoginScreen();
        },
        routes: <RouteBase>[
          GoRoute(
            path: 'dashboard',
            builder: (BuildContext context, GoRouterState state) {
              return const DashboardScreen();
            },
            routes: [
              GoRoute(
                path: 'settings',
                builder: (BuildContext context, GoRouterState state) {
                  return const SettingsScreen();
                },
              ),
              GoRoute(
                path: 'nonwovan',
                builder: (BuildContext context, GoRouterState state) {
                  return const NonwovanScreen();
                },
              ),
              GoRoute(
                path: 'jute',
                builder: (BuildContext context, GoRouterState state) {
                  return const JuteScreen();
                },
              ),
              GoRoute(
                path: 'cotton',
                builder: (BuildContext context, GoRouterState state) {
                  return const CottonScreen();
                },
              ),
            ],
          ),
        ],
      ),
    ],
  );
  return router;
}

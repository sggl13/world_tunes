
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:world_tunes/core/routing/routes.dart';

import '../../ui/screens/create_account.dart';
import '../../ui/screens/dashboard.dart';
import '../../ui/screens/login.dart';

class AppRouter {
  GoRouter get router => _router;

  final GoRouter _router = GoRouter(
    routes: [
      GoRoute(
        name: 'Login',
        path: Routes.login,
        pageBuilder: (_, state) {
          return CustomSlideTransition(
            key: state.pageKey,
            child: LoginScreen(),
          );
        },
      ),
      GoRoute(
        name: 'Create Account',
        path: Routes.createAccount,
        pageBuilder: (_, state) {
          return CustomSlideTransition(
            key: state.pageKey,
            child: CreateAccountScreen(),
          );
        },
      ),
      GoRoute(
        name: 'Dashboard',
        path: Routes.dashboard,
        pageBuilder: (_, state) {
          return CustomSlideTransition(
            key: state.pageKey,
            child: const Dashboard(),
          );
        },
      ),
    ],
  );
}

class CustomSlideTransition extends CustomTransitionPage<void> {
  CustomSlideTransition({super.key, required super.child})
      : super(
          transitionDuration: const Duration(milliseconds: 450),
          transitionsBuilder: (_, animation, __, child) {
            return SlideTransition(
              position: animation.drive(
                Tween(
                  begin: const Offset(1.5, 0),
                  end: Offset.zero,
                ).chain(
                  CurveTween(curve: Curves.ease),
                ),
              ),
              child: child,
            );
          },
        );
}

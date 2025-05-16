import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:health_cure/config/route/route_name.dart';
import 'package:health_cure/features/authentication/pages/login_screen.dart';
import 'package:health_cure/features/authentication/pages/otp_screen.dart';
import 'package:health_cure/features/home/pages/home_screen.dart';
import 'package:health_cure/features/settings/pages/settings_screen.dart';
import 'package:health_cure/features/treatment/pages/treatment_detail_screen.dart';
import 'package:health_cure/features/treatment/pages/treatments_screen.dart';
import 'package:health_cure/features/welcome/on_boarding_screen.dart';
import 'package:health_cure/features/welcome/splash_screen.dart';
import 'package:health_cure/base_page.dart';

GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();
GlobalKey<NavigatorState> _shellNavigatorKey = GlobalKey<NavigatorState>();

enum Direction { right, left, top, bottom }

Page<dynamic> _customTransitionPage({
  required Widget child,
  Direction direction = Direction.right,
}) {
  return CustomTransitionPage(
    key: ValueKey(child.toString()),
    transitionDuration: const Duration(milliseconds: 250),
    reverseTransitionDuration: const Duration(milliseconds: 100),
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(
        opacity: animation,
        child: SlideTransition(
          position: Tween<Offset>(
            begin:
                direction == Direction.right
                    ? const Offset(1.0, 0.0)
                    : direction == Direction.left
                    ? const Offset(-1.0, 0.0)
                    : direction == Direction.top
                    ? const Offset(0.0, -1.0)
                    : const Offset(0.0, 1.0),
            end: Offset.zero,
          ).animate(animation),
          child: child,
        ),
      );
    },
  );
}

GoRouter router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: RouteName.splash,
  debugLogDiagnostics: true,
  routes: [
    GoRoute(
      path: RouteName.splash,
      name: RouteName.splash,
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: RouteName.login,
      name: RouteName.login,
      pageBuilder:
          (context, state) => _customTransitionPage(
            child: const LoginScreen(),
            direction: Direction.left,
          ),
    ),
    GoRoute(
      path: RouteName.otp,
      name: RouteName.otp,
      pageBuilder:
          (context, state) => _customTransitionPage(
            child: OtpScreen(
              verificationId: (state.extra as Map)['verificationId'] as String,
              phoneNumber: (state.extra as Map)['phoneNumber'] as String,
              password: (state.extra as Map)['password'] as String,
            ),
            direction: Direction.left,
          ),
    ),
    GoRoute(
      path: RouteName.onboarding,
      name: RouteName.onboarding,
      pageBuilder:
          (context, state) => _customTransitionPage(
            child: const OnBoardingScreen(),
            direction: Direction.right,
          ),
    ),

    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) => BasePage(child: child),
      routes: [
        GoRoute(
          name: RouteName.home,
          path: RouteName.home,
          pageBuilder:
              (context, state) => _customTransitionPage(
                child: const HomeScreen(),
                direction: Direction.right,
              ),
        ),
        GoRoute(
          name: RouteName.treatments,
          path: RouteName.treatments,
          pageBuilder:
              (context, state) => _customTransitionPage(
                child: const TreatmentsScreen(),
                direction: Direction.left,
              ),
          routes: [
            GoRoute(
              name: RouteName.treatmentDetails,
              path: RouteName.treatmentDetails,
              parentNavigatorKey: _rootNavigatorKey,
              pageBuilder:
                  (context, state) => _customTransitionPage(
                    child: const TreatmentDetailScreen(),
                    direction: Direction.left,
                  ),
            ),
          ],
        ),
        GoRoute(
          name: RouteName.settings,
          path: RouteName.settings,
          pageBuilder:
              (context, state) => _customTransitionPage(
                child: const SettingsScreen(),
                direction: Direction.left,
              ),
        ),
      ],
    ),
  ],
);

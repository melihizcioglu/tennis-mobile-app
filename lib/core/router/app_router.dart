import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/login_screen.dart';
import '../../features/auth/presentation/register_screen.dart';
import '../../features/coach_session/presentation/coach_session_screen.dart';
import '../../features/coach_session/presentation/coach_start_screen.dart';
import '../../features/home/presentation/home_screen.dart';
import '../../features/plans/presentation/plan_list_screen.dart';
import '../../features/profile/presentation/profile_screen.dart';
import '../../features/qr/presentation/qr_scan_screen.dart';
import '../../features/splash/presentation/mode_select_screen.dart';
import '../../features/splash/presentation/splash_screen.dart';

/// Uygulama rotaları.
class AppRoutes {
  AppRoutes._();

  static const String splash = '/';
  static const String modeSelect = '/mode-select';
  static const String login = '/login';
  static const String register = '/register';
  static const String home = '/home';
  static const String profile = '/profile';
  static const String plans = '/plans';
  static const String qrScan = '/qr-scan';
  static const String coachStart = '/coach/start';
  static const String coachSession = '/coach/session';
}

final GlobalKey<NavigatorState> _rootNavKey = GlobalKey<NavigatorState>();

GoRouter createAppRouter() {
  return GoRouter(
    navigatorKey: _rootNavKey,
    initialLocation: AppRoutes.splash,
    routes: [
      GoRoute(
        path: AppRoutes.splash,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: AppRoutes.modeSelect,
        builder: (context, state) => const ModeSelectScreen(),
      ),
      GoRoute(
        path: AppRoutes.login,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: AppRoutes.register,
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        path: AppRoutes.home,
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: AppRoutes.profile,
        builder: (context, state) => const ProfileScreen(),
      ),
      GoRoute(
        path: AppRoutes.plans,
        builder: (context, state) => const PlanListScreen(),
      ),
      GoRoute(
        path: AppRoutes.qrScan,
        builder: (context, state) => const QrScanScreen(),
      ),
      GoRoute(
        path: AppRoutes.coachStart,
        builder: (context, state) => const CoachStartScreen(),
      ),
      GoRoute(
        path: '${AppRoutes.coachSession}/:sessionId',
        builder: (context, state) {
          final sessionId = state.pathParameters['sessionId']!;
          return CoachSessionScreen(sessionId: sessionId);
        },
      ),
    ],
  );
}

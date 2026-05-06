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
import '../../features/game_modes/presentation/game_modes_screen.dart';
import '../../features/match_mode/presentation/match_mode_screen.dart';
import '../../features/match_mode/presentation/match_setup_screen.dart';
import '../../features/training_mode/presentation/training_mode_screen.dart';
import '../../features/training_mode/presentation/stock_training_screen.dart';
import '../../features/training_mode/presentation/chatbot_training_screen.dart';
import '../../features/training_mode/presentation/live_feedback_screen.dart';
import '../../features/challenge_mode/presentation/challenge_mode_screen.dart';
import '../../features/challenge_mode/presentation/hit_streak_screen.dart';
import '../../features/challenge_mode/presentation/level_challenge_screen.dart';
import '../../shared/presentation/placeholder_screen.dart';

/// Uygulama rotaları.
class AppRoutes {
  AppRoutes._();

  static const String splash = '/';
  static const String modeSelect = '/mode-select';
  static const String gameModes = '/game-modes';
  static const String login = '/login';
  static const String register = '/register';
  static const String home = '/home';
  static const String profile = '/profile';
  static const String plans = '/plans';
  static const String qrScan = '/qr-scan';
  static const String coachStart = '/coach/start';
  static const String coachSession = '/coach/session';

  // Kullanıcı modları
  static const String matchMode = '/match-mode';
  static const String matchSetup = '/match-setup';
  static const String trainingMode = '/training-mode';
  static const String stockTraining = '/training/stock';
  static const String chatbotTraining = '/training/chatbot';
  static const String liveFeedback = '/training/live-feedback';
  static const String challengeMode = '/challenge-mode';
  static const String hitStreak = '/challenge/hit-streak';
  static const String levelChallenge = '/challenge/level';

  /// Ana sayfa kutuları — yeni backend ile doldurulacak geçici rotalar
  static const String aboutDuo = '/about-duo';
  static const String whereIsDuo = '/where-is-duo';
  static const String reservations = '/reservations';
  static const String rent = '/rent';
  static const String settings = '/settings';
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
        path: AppRoutes.gameModes,
        builder: (context, state) => const GameModesScreen(),
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
        path: AppRoutes.aboutDuo,
        builder: (context, state) => const PlaceholderScreen(title: 'About DUO'),
      ),
      GoRoute(
        path: AppRoutes.whereIsDuo,
        builder: (context, state) => const PlaceholderScreen(title: 'Where is DUO?'),
      ),
      GoRoute(
        path: AppRoutes.reservations,
        builder: (context, state) => const PlaceholderScreen(title: 'Rezervasyonlarım'),
      ),
      GoRoute(
        path: AppRoutes.rent,
        builder: (context, state) => const PlaceholderScreen(title: 'Rent Now'),
      ),
      GoRoute(
        path: AppRoutes.settings,
        builder: (context, state) => const PlaceholderScreen(title: 'Ayarlar'),
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
      // Maç / Antrenman / Challenge modları
      GoRoute(
        path: AppRoutes.matchMode,
        builder: (context, state) => const MatchModeScreen(),
      ),
      GoRoute(
        path: AppRoutes.matchSetup,
        builder: (context, state) => const MatchSetupScreen(),
      ),
      GoRoute(
        path: AppRoutes.trainingMode,
        builder: (context, state) => const TrainingModeScreen(),
      ),
      GoRoute(
        path: AppRoutes.stockTraining,
        builder: (context, state) => const StockTrainingScreen(),
      ),
      GoRoute(
        path: AppRoutes.chatbotTraining,
        builder: (context, state) => const ChatbotTrainingScreen(),
      ),
      GoRoute(
        path: AppRoutes.liveFeedback,
        builder: (context, state) => const LiveFeedbackScreen(),
      ),
      GoRoute(
        path: AppRoutes.challengeMode,
        builder: (context, state) => const ChallengeModeScreen(),
      ),
      GoRoute(
        path: AppRoutes.hitStreak,
        builder: (context, state) => const HitStreakScreen(),
      ),
      GoRoute(
        path: AppRoutes.levelChallenge,
        builder: (context, state) => const LevelChallengeScreen(),
      ),
    ],
  );
}

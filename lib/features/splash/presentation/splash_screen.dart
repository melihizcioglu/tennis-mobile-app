import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/app_mode.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/flavor/app_flavor.dart';
import '../../../core/router/app_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 1500), () {
      if (!mounted) return;
      final flavorMode = appFlavorMode;
      if (flavorMode == AppMode.coach) {
        context.go(AppRoutes.coachStart);
      } else if (flavorMode == AppMode.user) {
        context.go(AppRoutes.login);
      } else {
        context.go(AppRoutes.modeSelect);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.sports_tennis,
              size: 80,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(height: 24),
            Text(
              AppConstants.appName,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/app_mode.dart';
import '../../../core/design/app_design.dart';
import '../../../core/flavor/app_flavor.dart';
import '../../../core/router/app_router.dart';

/// Page 1 – DUO Landing (tasarım PNG katmanları).
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  void _onGetStarted(BuildContext context) {
    final flavorMode = appFlavorMode;
    if (flavorMode == AppMode.coach) {
      context.go(AppRoutes.coachStart);
    } else {
      context.go(AppRoutes.login);
    }
  }

  @override
  Widget build(BuildContext context) {
    final pad = MediaQuery.paddingOf(context);
    final maxW = MediaQuery.sizeOf(context).width - AppSpacing.md * 2;
    final buttonW = math.min(maxW, AppSpacing.ctaButtonWidth);
    const buttonH = AppSpacing.ctaButtonHeight;
    // Logo/slogan katmanları bu şeride inmesin; butonla çakışmayı önler.
    final artBottomInset =
        pad.bottom + AppSpacing.xxl + buttonH + AppSpacing.lg;

    Widget getStartedControl() {
      return Semantics(
        button: true,
        label: 'Get started',
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () => _onGetStarted(context),
            borderRadius: BorderRadius.circular(buttonH / 2),
            child: SizedBox(
              width: buttonW,
              height: buttonH,
              child: Image.asset(
                AppAssets.getStartedButton,
                fit: BoxFit.contain,
                filterQuality: FilterQuality.high,
                errorBuilder: (context, error, stackTrace) {
                  return FilledButton(
                    onPressed: () => _onGetStarted(context),
                    style: FilledButton.styleFrom(
                      backgroundColor: AppPalette.ctaButton,
                      foregroundColor: Colors.white,
                      minimumSize: Size(buttonW, buttonH),
                      maximumSize: Size(buttonW, buttonH),
                      padding: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(buttonH / 2),
                      ),
                    ),
                    child: const Text(
                      'GET STARTED',
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.6,
                        fontSize: 14,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: AppPalette.backgroundDark,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            bottom: artBottomInset,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Positioned.fill(
                  child: Image.asset(
                    AppAssets.sharedLayer,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned.fill(
                  child: Image.asset(
                    AppAssets.slogan,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned.fill(
                  child: Image.asset(
                    AppAssets.duoLogo,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            left: AppSpacing.lg,
            right: AppSpacing.lg,
            bottom: pad.bottom + AppSpacing.xxl,
            child: Center(child: getStartedControl()),
          ),
        ],
      ),
    );
  }
}

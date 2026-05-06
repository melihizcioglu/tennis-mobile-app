import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/design/app_design.dart';
import '../../../core/router/app_router.dart';

class GameModesScreen extends StatelessWidget {
  const GameModesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final pad = MediaQuery.paddingOf(context);

    final tiles = <_TileData>[
      _TileData(
        asset: AppAssets.trainingMode,
        onTap: () => context.push(AppRoutes.trainingMode),
      ),
      _TileData(
        asset: AppAssets.matchMode,
        onTap: () => context.push(AppRoutes.matchSetup),
      ),
      _TileData(
        asset: AppAssets.challengeMode,
        onTap: () => context.push(AppRoutes.challengeMode),
      ),
      _TileData(
        asset: AppAssets.chatbotTrainingMode,
        onTap: () => context.push(AppRoutes.chatbotTraining),
      ),
    ];

    return Scaffold(
      backgroundColor: AppPalette.backgroundDark,
      body: Padding(
        padding: EdgeInsets.only(
          top: pad.top + AppSpacing.sm,
          bottom: pad.bottom + AppSpacing.md,
          left: AppSpacing.lg,
          right: AppSpacing.lg,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // ── Header ──────────────────────────────────────────────
            SizedBox(
              height: 40,
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => context.pop(),
                    behavior: HitTestBehavior.opaque,
                    child: Padding(
                      padding: const EdgeInsets.all(6),
                      child: Image.asset(
                        AppAssets.backButton,
                        height: 28,
                        fit: BoxFit.contain,
                        errorBuilder: (_, __, ___) => const Icon(
                          Icons.chevron_left,
                          color: AppPalette.primary,
                          size: 32,
                        ),
                      ),
                    ),
                  ),
                  const Spacer(),
                  Image.asset(
                    AppAssets.gameModesTitle,
                    height: 22,
                    fit: BoxFit.contain,
                    errorBuilder: (_, __, ___) => const Text(
                      'GAMES MODE',
                      style: TextStyle(
                        color: AppPalette.primary,
                        fontSize: 22,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                  const Spacer(),
                  const SizedBox(width: 40),
                ],
              ),
            ),

            const SizedBox(height: AppSpacing.lg),

            // ── Tiles ────────────────────────────────────────────────
            Expanded(
              child: Column(
                children: [
                  for (int i = 0; i < tiles.length; i++) ...[
                    Expanded(
                      child: _GameModeTile(data: tiles[i]),
                    ),
                    if (i < tiles.length - 1) const SizedBox(height: 14),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TileData {
  const _TileData({required this.asset, required this.onTap});
  final String asset;
  final VoidCallback onTap;
}

class _GameModeTile extends StatelessWidget {
  const _GameModeTile({required this.data});
  final _TileData data;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: data.onTap,
      child: Image.asset(
        data.asset,
        fit: BoxFit.contain,
        width: double.infinity,
        errorBuilder: (_, __, ___) => Container(
          decoration: BoxDecoration(
            color: AppPalette.primary,
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [
              BoxShadow(
                color: Color(0xFF8F92FD),
                offset: Offset(0, 6),
                blurRadius: 0,
              ),
            ],
          ),
          child: const Center(
            child: Text(
              'MODE',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w900,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

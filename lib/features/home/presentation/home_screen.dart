import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/design/app_design.dart';
import '../../../core/router/app_router.dart';
import '../../auth/providers/auth_provider.dart';
import '../../profile/providers/user_profile_provider.dart';

/// Page 3 – Dashboard (Figma PAGE 3: ~492×874 referans, 2×3 grid).
class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  String _displayName(WidgetRef ref) {
    final user = ref.watch(currentUserProvider);
    final uid = user?.uid;
    if (uid == null) return 'Oyuncu';

    String fb() =>
        user?.displayName ?? user?.email?.split('@').first ?? 'Oyuncu';

    final profileAsync = ref.watch(userProfileProvider(uid));
    return profileAsync.when(
      data: (p) {
        final dn = p?.displayName?.trim();
        if (dn != null && dn.isNotEmpty) return dn;
        return fb();
      },
      loading: fb,
      error: (_, _) => fb(),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final name = _displayName(ref);
    const horizontalInset = 22.0;
    const gridGap = 14.0;

    return Scaffold(
      backgroundColor: AppPalette.backgroundDark,
      body: SafeArea(
        bottom: true,
        child: LayoutBuilder(
              builder: (context, constraints) {
                final maxW = constraints.maxWidth;
                final frameW = maxW < AppSpacing.homeFigmaFrameWidth
                    ? maxW
                    : AppSpacing.homeFigmaFrameWidth;
                final innerW = frameW - horizontalInset * 2;
                // 2 sütunlu kare butonlar: hücre genişliği + hücre yüksekliği aynı.
                final cellW = (innerW - gridGap) / 2;
                final cellH = cellW;

                return SingleChildScrollView(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: SizedBox(
                      width: frameW,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: horizontalInset,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const SizedBox(height: 8),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'WELCOME',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineSmall
                                            ?.copyWith(
                                              color: AppPalette.primary,
                                              fontWeight: FontWeight.w900,
                                              letterSpacing: 0.8,
                                              fontSize: 28,
                                              height: 1.05,
                                            ),
                                      ),
                                      const SizedBox(height: 6),
                                      Text(
                                        name,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium
                                            ?.copyWith(
                                              color: AppPalette.textOnDark,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 17,
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 8),
                                _HeaderActionStrip(
                                  width: 124,
                                  onInfo: () => context.push(AppRoutes.aboutDuo),
                                  onSettings: () =>
                                      context.push(AppRoutes.settings),
                                  onProfile: () => context.push(AppRoutes.profile),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: SizedBox(
                                        height: cellH,
                                        child: _HomeTile(
                                          asset: AppAssets.homeRentNow,
                                          onTap: () =>
                                              context.push(AppRoutes.rent),
                                          fallbackTitle: 'RENT NOW',
                                          fallbackIcon:
                                              Icons.sports_tennis_outlined,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: gridGap),
                                    Expanded(
                                      child: SizedBox(
                                        height: cellH,
                                        child: _HomeTile(
                                          asset: AppAssets.homeGameModes,
                                          onTap: () =>
                                              context.push(AppRoutes.gameModes),
                                          fallbackTitle: 'GAME MODES',
                                          fallbackIcon:
                                              Icons.emoji_events_outlined,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: gridGap),
                                Row(
                                  children: [
                                    const Spacer(),
                                    Expanded(
                                      child: SizedBox(
                                        height: cellH,
                                        child: _HomeTile(
                                          asset: AppAssets.homeFindDuo,
                                          onTap: () => context
                                              .push(AppRoutes.whereIsDuo),
                                          fallbackTitle: 'FIND DUO',
                                          fallbackIcon: Icons.place_outlined,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: gridGap),
                                Row(
                                  children: [
                                    Expanded(
                                      child: SizedBox(
                                        height: cellH,
                                        child: _HomeTile(
                                          asset: AppAssets.homeReservations,
                                          onTap: () => context
                                              .push(AppRoutes.reservations),
                                          fallbackTitle: 'MY RESERVATIONS',
                                          fallbackIcon: Icons
                                              .event_available_outlined,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: gridGap),
                                    Expanded(
                                      child: SizedBox(
                                        height: cellH,
                                        child: _HomeTile(
                                          asset: AppAssets.homeSelectPlan,
                                          onTap: () =>
                                              context.push(AppRoutes.plans),
                                          fallbackTitle: 'SELECT A PLAN',
                                          fallbackIcon:
                                              Icons.request_quote_outlined,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 26),
                            Center(
                              child: GestureDetector(
                                onTap: () => context.push(AppRoutes.rent),
                                child: Image.asset(
                                  AppAssets.homeStartPlayingButton,
                                  width: innerW,
                                  fit: BoxFit.fitWidth,
                                  errorBuilder: (_, _, _) => FilledButton(
                                    onPressed: () => context.push(AppRoutes.rent),
                                    child: const Text('START PLAYING'),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 18),
                            Center(
                              child: GestureDetector(
                                onTap: () =>
                                    context.push(AppRoutes.chatbotTraining),
                                child: Image.asset(
                                  AppAssets.homeFooterBot,
                                  height: 64,
                                  fit: BoxFit.contain,
                                  errorBuilder: (_, _, _) => Icon(
                                    Icons.smart_toy_outlined,
                                    size: 48,
                                    color: AppPalette.primary,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
    );
  }
}

/// Üç bölgeli dokunma: bilgi / ayarlar / profil (PNG üstünde).
class _HeaderActionStrip extends StatelessWidget {
  const _HeaderActionStrip({
    required this.width,
    required this.onInfo,
    required this.onSettings,
    required this.onProfile,
  });

  final double width;
  final VoidCallback onInfo;
  final VoidCallback onSettings;
  final VoidCallback onProfile;

  @override
  Widget build(BuildContext context) {
    final h = (width * 0.38).clamp(46.0, 54.0);
    return SizedBox(
      width: width,
      height: h,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Row(
            children: [
              Expanded(
                child: _HeaderActionIcon(
                  asset: AppAssets.homeInfoButton,
                  onTap: onInfo,
                  fallbackIcon: Icons.info_outline,
                ),
              ),
              const SizedBox(width: 6),
              Expanded(
                child: _HeaderActionIcon(
                  asset: AppAssets.homeSettingsButton,
                  onTap: onSettings,
                  fallbackIcon: Icons.settings_outlined,
                ),
              ),
              const SizedBox(width: 6),
              Expanded(
                child: _HeaderActionIcon(
                  asset: AppAssets.homeProfileButton,
                  onTap: onProfile,
                  fallbackIcon: Icons.person_outline,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _HeaderActionIcon extends StatelessWidget {
  const _HeaderActionIcon({
    required this.asset,
    required this.onTap,
    required this.fallbackIcon,
  });

  final String asset;
  final VoidCallback onTap;
  final IconData fallbackIcon;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(999),
        child: Padding(
          padding: const EdgeInsets.all(2),
          child: Image.asset(
            asset,
            fit: BoxFit.contain,
            filterQuality: FilterQuality.high,
            errorBuilder: (_, _, _) => Icon(
              fallbackIcon,
              color: AppPalette.primary,
            ),
          ),
        ),
      ),
    );
  }
}

/// PNG yoksa veya web’de asset yüklenmezse (boş klasör, yanlış yol) görünür yedek.
class _HomeTileFallback extends StatelessWidget {
  const _HomeTileFallback({
    required this.width,
    required this.height,
    required this.title,
    required this.icon,
  });

  final double width;
  final double height;
  final String title;
  final IconData icon;

  static const Color _lavender = Color(0xFFC8C8EC);

  @override
  Widget build(BuildContext context) {
    final iconSize = (width < height ? width : height) * 0.32;
    return ClipRRect(
      borderRadius: BorderRadius.circular(AppRadius.lg),
      child: ColoredBox(
        color: _lavender,
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: Icon(
                  icon,
                  size: iconSize.clamp(22.0, 40.0),
                  color: AppPalette.textOnLight,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(4, 0, 4, 4),
              child: Text(
                title,
                textAlign: TextAlign.center,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: AppPalette.textOnDark,
                  fontSize: 9,
                  fontWeight: FontWeight.w800,
                  height: 1.15,
                  letterSpacing: 0.2,
                ),
              ),
            ),
            const SizedBox(
              height: 3,
              width: double.infinity,
              child: ColoredBox(color: AppPalette.primary),
            ),
          ],
        ),
      ),
    );
  }
}

class _HomeTile extends StatelessWidget {
  const _HomeTile({
    required this.asset,
    required this.onTap,
    required this.fallbackTitle,
    required this.fallbackIcon,
  });

  final String asset;
  final VoidCallback onTap;
  final String fallbackTitle;
  final IconData fallbackIcon;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        child: Ink(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final cw = constraints.maxWidth;
              final ch = constraints.maxHeight;
              return ClipRRect(
                borderRadius: BorderRadius.circular(AppRadius.lg),
                clipBehavior: Clip.antiAlias,
                child: SizedBox(
                  width: cw,
                  height: ch,
                  child: Padding(
                    padding: const EdgeInsets.all(2),
                    child: SizedBox(
                      width: cw - 4,
                      height: ch - 4,
                      child: Image.asset(
                        asset,
                        fit: BoxFit.contain,
                        alignment: Alignment.center,
                        filterQuality: FilterQuality.high,
                        errorBuilder: (_, _, _) => _HomeTileFallback(
                          width: cw - 4,
                          height: ch - 4,
                          title: fallbackTitle,
                          icon: fallbackIcon,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

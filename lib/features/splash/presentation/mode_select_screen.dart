import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/app_mode.dart';
import '../../../core/router/app_router.dart';
import '../../auth/providers/auth_provider.dart';
import '../providers/app_mode_provider.dart';

class ModeSelectScreen extends ConsumerWidget {
  const ModeSelectScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mod Seçin')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Uygulamayı nasıl kullanacaksınız?',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 32),
            ElevatedButton.icon(
              onPressed: () {
                ref.read(appModeStateProvider.notifier).setMode(AppMode.user);
                final user = ref.read(currentUserProvider);
                if (user != null) {
                  context.go(AppRoutes.home);
                } else {
                  context.go(AppRoutes.login);
                }
              },
              icon: const Icon(Icons.person),
              label: const Text('Kullanıcı'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

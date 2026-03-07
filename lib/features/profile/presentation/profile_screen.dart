import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/app_router.dart';
import '../../../shared/models/user_profile.dart';
import '../../auth/providers/auth_provider.dart';
import '../providers/user_profile_provider.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(currentUserProvider);
    final profileAsync = ref.watch(userProfileProvider(user?.uid));

    return Scaffold(
      appBar: AppBar(title: const Text('Profilim')),
      body: user == null
          ? const Center(child: Text('Giriş yapılmadı'))
          : profileAsync.when(
              data: (UserProfile? profile) {
                return SingleChildScrollView(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const CircleAvatar(
                        radius: 48,
                        child: Icon(Icons.person, size: 48),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        profile?.displayName ?? user.displayName ?? 'İsimsiz',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        user.email ?? '',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      if (profile?.planId != null) ...[
                        const SizedBox(height: 16),
                        Card(
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Text('Plan: ${profile!.planId}'),
                          ),
                        ),
                      ],
                      const SizedBox(height: 32),
                      OutlinedButton.icon(
                        onPressed: () async {
                          await ref.read(authRepositoryProvider).signOut();
                          if (context.mounted) {
                            context.go(AppRoutes.modeSelect);
                          }
                        },
                        icon: const Icon(Icons.logout),
                        label: const Text('Çıkış Yap'),
                      ),
                    ],
                  ),
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => Center(child: Text('Hata: $e')),
            ),
    );
  }
}

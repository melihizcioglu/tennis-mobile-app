import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/app_router.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ana Sayfa'),
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () => context.push(AppRoutes.profile),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: ListTile(
              leading: const Icon(Icons.qr_code_scanner, size: 32),
              title: const Text('QR Okut'),
              subtitle: const Text('Antrenmana katılmak için QR kodu okutun'),
              onTap: () => context.push(AppRoutes.qrScan),
            ),
          ),
          Card(
            child: ListTile(
              leading: const Icon(Icons.card_membership, size: 32),
              title: const Text('Planlar'),
              subtitle: const Text('Plan seçin ve satın alın'),
              onTap: () => context.push(AppRoutes.plans),
            ),
          ),
          Card(
            child: ListTile(
              leading: const Icon(Icons.person, size: 32),
              title: const Text('Profilim'),
              subtitle: const Text('Kullanıcı bilgilerinizi görüntüleyin'),
              onTap: () => context.push(AppRoutes.profile),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/app_router.dart';

/// Challenge modu giriş: isabet serisi ve seviye challenge.
class ChallengeModeScreen extends StatelessWidget {
  const ChallengeModeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Challenge Modu'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: ListTile(
              leading: const CircleAvatar(
                child: Icon(Icons.gps_fixed),
              ),
              title: const Text('İsabet Serisi'),
              subtitle: const Text(
                'Topu nereye atmanız gerektiği arayüzde yanıp sönen hedef olarak gösterilir.',
              ),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () => context.push(AppRoutes.hitStreak),
            ),
          ),
          Card(
            child: ListTile(
              leading: const CircleAvatar(
                child: Icon(Icons.timer),
              ),
              title: const Text('Seviye Challenge'),
              subtitle: const Text(
                'Örn: 30 saniyede 10 isabetli atış gibi süre-hedef challenge\'ları.',
              ),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () => context.push(AppRoutes.levelChallenge),
            ),
          ),
        ],
      ),
    );
  }
}

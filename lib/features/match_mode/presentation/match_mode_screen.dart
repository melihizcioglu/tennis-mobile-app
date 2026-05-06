import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/app_router.dart';

/// Maç modu giriş ekranı. Kullanıcı buradan maç kurulumuna gider.
class MatchModeScreen extends StatelessWidget {
  const MatchModeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Maç Modu'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Maç simülasyonu',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Skor senaryosu, seviye ve rakip stili seçerek maçı özelleştirin. '
                    'İsteğe bağlı süre limiti koyabilirsiniz.',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          FilledButton.icon(
            onPressed: () => context.push(AppRoutes.matchSetup),
            icon: const Icon(Icons.play_arrow),
            label: const Text('Maça Başla'),
            style: FilledButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              minimumSize: const Size(double.infinity, 0),
            ),
          ),
        ],
      ),
    );
  }
}

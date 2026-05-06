import 'package:flutter/material.dart';

/// Anlık geri bildirim: kullanıcıya nelere dikkat etmesi, hareket doğruluğu, nasıl yapması gerektiği.
class LiveFeedbackScreen extends StatelessWidget {
  const LiveFeedbackScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Anlık Geri Bildirim'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            color: Theme.of(context).colorScheme.primaryContainer.withValues(
                  alpha: 0.3,
                ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.info_outline,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Bu modda',
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  const Text('• Nelere dikkat etmeniz gerektiği'),
                  const Text('• Yaptığınız hareketlerin doğruluğu'),
                  const Text('• Nasıl yapmanız gerektiği'),
                  const SizedBox(height: 8),
                  Text(
                    'Antrenman sırasında ses veya ekran üzerinden anlık rehberlik alacaksınız.',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          FilledButton.icon(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    'Anlık geri bildirim modu (cihaz/kamera entegrasyonu) yakında.',
                  ),
                ),
              );
            },
            icon: const Icon(Icons.play_arrow),
            label: const Text('Anlık Geri Bildirimle Başla'),
            style: FilledButton.styleFrom(
              minimumSize: const Size(double.infinity, 0),
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
          ),
        ],
      ),
    );
  }
}

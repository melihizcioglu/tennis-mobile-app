import 'package:flutter/material.dart';

/// Kişiye özel chatbot ile antrenman oluşturma ve simülasyon.
class ChatbotTrainingScreen extends StatelessWidget {
  const ChatbotTrainingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chatbot ile Antrenman'),
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
                    'Antrenmanınızı tarif edin',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Örn: "Forehand cross-court 10 dakika, sonra backhand slice çalış" '
                    'yazın; chatbot programı oluşturup simüle edebilir.',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            maxLines: 4,
            decoration: InputDecoration(
              hintText: 'Antrenman isteğinizi yazın...',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          const SizedBox(height: 16),
          FilledButton.icon(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Chatbot entegrasyonu yakında eklenecek.'),
                ),
              );
            },
            icon: const Icon(Icons.send),
            label: const Text('Gönder'),
            style: FilledButton.styleFrom(
              minimumSize: const Size(double.infinity, 0),
              padding: const EdgeInsets.symmetric(vertical: 14),
            ),
          ),
        ],
      ),
    );
  }
}

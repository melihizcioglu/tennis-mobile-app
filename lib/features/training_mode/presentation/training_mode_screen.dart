import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/app_router.dart';

/// Antrenman modu giriş ekranı: stok antrenmanlar, chatbot, anlık geri bildirim.
class TrainingModeScreen extends StatelessWidget {
  const TrainingModeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Antrenman Modu'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: ListTile(
              leading: const CircleAvatar(
                child: Icon(Icons.list_alt),
              ),
              title: const Text('Stok Antrenmanlar'),
              subtitle: const Text(
                'Temel ve teknik uzmanlık antrenmanları; hazır programlarla çalışın.',
              ),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () => context.push(AppRoutes.stockTraining),
            ),
          ),
          Card(
            child: ListTile(
              leading: const CircleAvatar(
                child: Icon(Icons.smart_toy),
              ),
              title: const Text('Kişiye Özel Chatbot'),
              subtitle: const Text(
                'Chatbot ile kendi antrenmanınızı oluşturup simüle edin.',
              ),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () => context.push(AppRoutes.chatbotTraining),
            ),
          ),
          Card(
            child: ListTile(
              leading: const CircleAvatar(
                child: Icon(Icons.feedback),
              ),
              title: const Text('Anlık Geri Bildirim'),
              subtitle: const Text(
                'Nelere dikkat etmeli, hareket doğruluğu ve nasıl yapılacağı hakkında anlık rehberlik.',
              ),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () => context.push(AppRoutes.liveFeedback),
            ),
          ),
        ],
      ),
    );
  }
}

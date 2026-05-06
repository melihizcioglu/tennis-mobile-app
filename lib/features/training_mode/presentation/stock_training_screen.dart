import 'package:flutter/material.dart';

/// Stok antrenmanlar: temel ve teknik uzmanlık kategorileri.
class StockTrainingScreen extends StatelessWidget {
  const StockTrainingScreen({super.key});

  static const _categories = [
    ('basic', 'Temel', 'Forehand, backhand, servis temelleri'),
    ('technical', 'Teknik Uzmanlık', 'Slice, topspin, vole, smaç'),
    ('tactical', 'Taktik', 'Açılar, pozisyon, oyun okuma'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stok Antrenmanlar'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _categories.length,
        itemBuilder: (context, index) {
          final (id, title, subtitle) = _categories[index];
          return Card(
            child: ListTile(
              title: Text(title),
              subtitle: Text(subtitle),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                // TODO: Kategoriye göre antrenman listesi
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('$title antrenmanları (yakında)')),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

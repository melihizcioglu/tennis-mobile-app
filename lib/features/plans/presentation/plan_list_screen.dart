import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/plans_provider.dart';

class PlanListScreen extends ConsumerWidget {
  const PlanListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final plansAsync = ref.watch(plansListProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Planlar')),
      body: plansAsync.when(
        data: (plans) {
          if (plans.isEmpty) {
            return const Center(child: Text('Henüz plan yok'));
          }
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: plans.length,
            itemBuilder: (_, i) {
              final plan = plans[i];
              return Card(
                child: ListTile(
                  title: Text(plan.name),
                  subtitle: Text(
                    '${plan.price} ₺ / ${plan.durationDays} gün',
                  ),
                  trailing: FilledButton(
                    onPressed: () =>
                        ref.read(planPurchaseProvider).purchase(plan.id),
                    child: const Text('Seç'),
                  ),
                ),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Hata: $e')),
      ),
    );
  }
}

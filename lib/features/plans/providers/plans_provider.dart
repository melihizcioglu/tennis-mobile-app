import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/plans_repository.dart';
import '../../auth/providers/auth_provider.dart';
import '../../profile/providers/user_profile_provider.dart';

final plansRepositoryProvider = Provider<PlansRepository>((ref) {
  return PlansRepository();
});

final plansListProvider = FutureProvider((ref) async {
  return ref.read(plansRepositoryProvider).getPlans();
});

final planPurchaseProvider = Provider<PlanPurchase>((ref) {
  return PlanPurchase(ref);
});

class PlanPurchase {
  PlanPurchase(this._ref);

  final Ref _ref;

  Future<void> purchase(String planId) async {
    final uid = _ref.read(currentUserProvider)?.uid;
    if (uid == null) return;
    await _ref.read(plansRepositoryProvider).assignPlanToUser(uid, planId);
    _ref.invalidate(userProfileProvider(uid));
  }
}

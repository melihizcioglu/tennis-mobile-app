import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../shared/models/plan.dart';
import '../../profile/data/user_profile_repository.dart';

class PlansRepository {
  PlansRepository()
      : _firestore = FirebaseFirestore.instance,
        _userRepo = UserProfileRepository();

  final FirebaseFirestore _firestore;
  final UserProfileRepository _userRepo;

  static const String _collection = 'plans';

  Future<List<Plan>> getPlans() async {
    final snap = await _firestore.collection(_collection).get();
    return snap.docs
        .map((d) => Plan.fromMap(d.data()..['id'] = d.id))
        .toList();
  }

  Future<void> assignPlanToUser(String uid, String planId) async {
    await _userRepo.updatePlanId(uid, planId);
  }
}

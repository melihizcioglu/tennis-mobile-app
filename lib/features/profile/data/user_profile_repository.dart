import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../shared/models/user_profile.dart';

class UserProfileRepository {
  UserProfileRepository() : _firestore = FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  static const String _collection = 'users';

  Future<UserProfile?> getProfile(String uid) async {
    final doc = await _firestore.collection(_collection).doc(uid).get();
    if (!doc.exists) return null;
    final data = doc.data()!;
    data['uid'] = doc.id;
    return UserProfile.fromMap(data);
  }

  Future<void> setProfile(String uid, UserProfile profile) async {
    await _firestore.collection(_collection).doc(uid).set(profile.toMap());
  }

  Future<void> updatePlanId(String uid, String? planId) async {
    await _firestore.collection(_collection).doc(uid).update({'planId': planId});
  }

  Future<void> createProfile(UserProfile profile) async {
    await _firestore.collection(_collection).doc(profile.uid).set(profile.toMap());
  }
}

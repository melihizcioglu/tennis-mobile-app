import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../shared/models/training_session.dart';

class CoachSessionRepository {
  CoachSessionRepository() : _firestore = FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  static const String _collection = 'sessions';

  Future<String> createSession() async {
    final ref = _firestore.collection(_collection).doc();
    await ref.set({
      'userId': null,
      'programId': null,
      'programSteps': null,
      'startTime': FieldValue.serverTimestamp(),
      'endTime': null,
      'joinedAt': null,
    });
    return ref.id;
  }

  Stream<TrainingSession?> watchSession(String sessionId) {
    return _firestore.collection(_collection).doc(sessionId).snapshots().map(
          (doc) {
            if (!doc.exists) return null;
            final data = Map<String, dynamic>.from(doc.data()!);
            data['id'] = doc.id;
            return TrainingSession.fromMap(data);
          },
        );
  }
}

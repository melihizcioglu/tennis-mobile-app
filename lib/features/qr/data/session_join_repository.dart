import 'package:cloud_firestore/cloud_firestore.dart';

class SessionJoinRepository {
  SessionJoinRepository() : _firestore = FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  static const String _collection = 'sessions';

  Future<void> joinSession(String sessionId, String userId) async {
    final ref = _firestore.collection(_collection).doc(sessionId);
    final doc = await ref.get();
    if (!doc.exists) {
      throw Exception('Oturum bulunamadı');
    }
    final data = doc.data()!;
    if (data['userId'] != null && data['userId'] != '') {
      throw Exception('Bu oturum zaten bir kullanıcıya atanmış');
    }
    await ref.update({
      'userId': userId,
      'joinedAt': FieldValue.serverTimestamp(),
    });
  }
}

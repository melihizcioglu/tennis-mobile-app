import 'package:cloud_firestore/cloud_firestore.dart';

class UserProfile {
  const UserProfile({
    required this.uid,
    this.displayName,
    this.email,
    this.planId,
    this.createdAt,
  });

  final String uid;
  final String? displayName;
  final String? email;
  final String? planId;
  final DateTime? createdAt;

  factory UserProfile.fromMap(Map<String, dynamic> map) {
    return UserProfile(
      uid: map['uid'] as String,
      displayName: map['displayName'] as String?,
      email: map['email'] as String?,
      planId: map['planId'] as String?,
      createdAt: map['createdAt'] is Timestamp
          ? (map['createdAt'] as Timestamp).toDate()
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'displayName': displayName,
      'email': email,
      'planId': planId,
      'createdAt': createdAt,
    };
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';

class TrainingSession {
  const TrainingSession({
    required this.id,
    this.userId,
    this.programId,
    this.programSteps,
    this.startTime,
    this.endTime,
    this.joinedAt,
  });

  final String id;
  final String? userId;
  final String? programId;
  final List<String>? programSteps;
  final DateTime? startTime;
  final DateTime? endTime;
  final DateTime? joinedAt;

  factory TrainingSession.fromMap(Map<String, dynamic> map) {
    return TrainingSession(
      id: map['id'] as String? ?? '',
      userId: map['userId'] as String?,
      programId: map['programId'] as String?,
      programSteps: map['programSteps'] != null
          ? List<String>.from(map['programSteps'] as List)
          : null,
      startTime: map['startTime'] is Timestamp
          ? (map['startTime'] as Timestamp).toDate()
          : null,
      endTime: map['endTime'] is Timestamp
          ? (map['endTime'] as Timestamp).toDate()
          : null,
      joinedAt: map['joinedAt'] is Timestamp
          ? (map['joinedAt'] as Timestamp).toDate()
          : null,
    );
  }
}

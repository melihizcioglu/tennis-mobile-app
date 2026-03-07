import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/coach_session_repository.dart';
import '../../../shared/models/training_session.dart';

final coachSessionRepositoryProvider = Provider<CoachSessionRepository>((ref) {
  return CoachSessionRepository();
});

final sessionStreamProvider =
    StreamProvider.family<TrainingSession?, String>((ref, sessionId) {
  return ref
      .read(coachSessionRepositoryProvider)
      .watchSession(sessionId);
});

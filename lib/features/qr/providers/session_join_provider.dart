import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/session_join_repository.dart';

final sessionJoinRepositoryProvider = Provider<SessionJoinRepository>((ref) {
  return SessionJoinRepository();
});

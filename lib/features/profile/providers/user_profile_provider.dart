import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/models/user_profile.dart';
import '../data/user_profile_repository.dart';

final userProfileRepositoryProvider = Provider<UserProfileRepository>((ref) {
  return UserProfileRepository();
});

final userProfileProvider = FutureProvider.family<UserProfile?, String?>((ref, uid) async {
  if (uid == null) return null;
  return ref.read(userProfileRepositoryProvider).getProfile(uid);
});

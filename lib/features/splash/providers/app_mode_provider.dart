import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/app_mode.dart';

/// Uygulama modu (kullanıcı / antrenör) state'i.
final appModeProvider = StateProvider<AppMode?>((ref) => null);

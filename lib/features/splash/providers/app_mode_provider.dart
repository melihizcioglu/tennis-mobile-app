import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../core/app_mode.dart';

part 'app_mode_provider.g.dart';

/// Uygulama modu (kullanıcı / antrenör) state'i.
@riverpod
class AppModeState extends _$AppModeState {
  @override
  AppMode? build() => null;

  void setMode(AppMode? mode) {
    state = mode;
  }
}

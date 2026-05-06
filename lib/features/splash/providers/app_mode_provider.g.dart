// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_mode_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Uygulama modu (kullanıcı / antrenör) state'i.

@ProviderFor(AppModeState)
final appModeStateProvider = AppModeStateProvider._();

/// Uygulama modu (kullanıcı / antrenör) state'i.
final class AppModeStateProvider
    extends $NotifierProvider<AppModeState, AppMode?> {
  /// Uygulama modu (kullanıcı / antrenör) state'i.
  AppModeStateProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appModeStateProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appModeStateHash();

  @$internal
  @override
  AppModeState create() => AppModeState();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AppMode? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AppMode?>(value),
    );
  }
}

String _$appModeStateHash() => r'e6cfc1fabe308606fec4c57f8e5ec1596a1dccd4';

/// Uygulama modu (kullanıcı / antrenör) state'i.

abstract class _$AppModeState extends $Notifier<AppMode?> {
  AppMode? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AppMode?, AppMode?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AppMode?, AppMode?>,
              AppMode?,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

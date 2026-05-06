// ignore_for_file: lines_longer_than_80_chars
//
// FlutterFire / Firebase CLI ile senkron tutun:
// - Web: firebase apps:sdkconfig WEB <appId> --project tennis-app-bb5da
// - Tüm platformlar: dart pub global activate flutterfire_cli && flutterfire configure

import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// [Firebase.initializeApp] için platform seçimi.
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'Bu platform için firebase_options tanımlı değil.',
        );
      case TargetPlatform.windows:
      case TargetPlatform.linux:
      case TargetPlatform.fuchsia:
        throw UnsupportedError(
          'Bu platform için firebase_options tanımlı değil.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyAz3Bt1xCU-WvvlDl66RRO9zJOq5_5n6zU',
    appId: '1:671000896212:web:fef20f04e2373311d65141',
    messagingSenderId: '671000896212',
    projectId: 'tennis-app-bb5da',
    authDomain: 'tennis-app-bb5da.firebaseapp.com',
    storageBucket: 'tennis-app-bb5da.firebasestorage.app',
    measurementId: 'G-FH0JMK6HF3',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDx5mAs0AKyc7_jjrxVmxCE-_d6NtBZ6TQ',
    appId: '1:671000896212:android:9af7decd6e6620c5d65141',
    messagingSenderId: '671000896212',
    projectId: 'tennis-app-bb5da',
    storageBucket: 'tennis-app-bb5da.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBMdUroTOw9bqGxFcI20L71SJXiT3HwYT0',
    appId: '1:671000896212:ios:b06840066a7a0604d65141',
    messagingSenderId: '671000896212',
    projectId: 'tennis-app-bb5da',
    storageBucket: 'tennis-app-bb5da.firebasestorage.app',
    iosBundleId: 'com.tenniscoach.tennisMobileApp',
  );
}

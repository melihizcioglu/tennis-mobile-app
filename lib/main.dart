import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';
import 'core/web/web_mobile_shell.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    const ProviderScope(
      child: TennisCoachApp(),
    ),
  );
}

class TennisCoachApp extends StatelessWidget {
  const TennisCoachApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Tenis Antrenör',
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.light,
      builder: (context, child) => WebMobileShell(
        child: child ??
            const Center(
              child: CircularProgressIndicator(),
            ),
      ),
      routerConfig: createAppRouter(),
    );
  }
}

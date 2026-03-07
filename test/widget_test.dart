import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:tennis_mobile_app/main.dart';

void main() {
  group('TennisCoachApp', () {
    setUpAll(() async {
      TestWidgetsFlutterBinding.ensureInitialized();
      await Firebase.initializeApp(
        options: const FirebaseOptions(
          apiKey: 'test-key',
          appId: 'test-app-id',
          messagingSenderId: 'test-sender',
          projectId: 'test-project',
        ),
      );
    });

    testWidgets('splash screen shows app name', (WidgetTester tester) async {
      await tester.pumpWidget(
        const ProviderScope(child: TennisCoachApp()),
      );
      await tester.pump();
      expect(find.text('Tenis Antrenör'), findsOneWidget);
    });
  });
}

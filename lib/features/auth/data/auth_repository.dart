import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class AuthRepository {
  AuthRepository(this._auth);

  final FirebaseAuth? _auth;

  bool get isFirebaseReady => _auth != null;

  /// Varsayılan Firebase uygulaması yoksa (ör. web’de init atlandıysa) [null] auth ile oluşturur.
  factory AuthRepository.fromDefaultApp() {
    if (Firebase.apps.isEmpty) {
      return AuthRepository(null);
    }
    return AuthRepository(FirebaseAuth.instance);
  }

  Stream<User?> get authStateChanges =>
      _auth?.authStateChanges() ?? Stream<User?>.value(null);

  User? get currentUser => _auth?.currentUser;

  Never _notConfigured() {
    throw FirebaseAuthException(
      code: 'firebase-not-configured',
      message:
          'Firebase web henüz yapılandırılmadı. Projede flutterfire configure ile web ekleyin veya mobil uygulamayı kullanın.',
    );
  }

  Future<void> signIn(String email, String password) async {
    final auth = _auth;
    if (auth == null) _notConfigured();
    await auth.signInWithEmailAndPassword(email: email, password: password);
  }

  Future<void> signUp({
    required String email,
    required String password,
    String? displayName,
  }) async {
    final auth = _auth;
    if (auth == null) _notConfigured();
    final cred = await auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    if (displayName != null && displayName.isNotEmpty && cred.user != null) {
      await cred.user!.updateDisplayName(displayName);
    }
  }

  Future<void> signOut() async {
    final auth = _auth;
    if (auth == null) return;
    await auth.signOut();
  }
}

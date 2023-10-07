import 'package:firebase_auth/firebase_auth.dart';

/// Authentication class for firebase
/// This class is used to sign in and sign out
class Auth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  /// Get current user
  User? get currentUser => _firebaseAuth.currentUser;

  /// Get auth state changes
  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  /// Sign in with email and password
  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  /// Sign out
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}

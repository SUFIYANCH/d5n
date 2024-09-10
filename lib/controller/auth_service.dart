import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthService {
  final FirebaseAuth auth = FirebaseAuth.instance;

  Stream<User?> get authStateChange => auth.authStateChanges();

  Future<UserCredential> signUp(String email, String password) {
    return auth.createUserWithEmailAndPassword(
        email: email, password: password);
  }

  Future<UserCredential> login(String email, String password) {
    return auth.signInWithEmailAndPassword(email: email, password: password);
  }

  Future<void> forgotPassword(String email) {
    return auth.sendPasswordResetEmail(email: email);
  }

  Future<void> logout() {
    return auth.signOut();
  }
}

final authServiceProvider = Provider<AuthService>((ref) {
  return AuthService();
});
final authStateProvider = StreamProvider((ref) {
  return ref.read(authServiceProvider).authStateChange;
});

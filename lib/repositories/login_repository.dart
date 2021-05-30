import 'package:firebase_auth/firebase_auth.dart';

class LoginRepository {
  /// Local sign in
  Future<UserCredential> localSignIn(String email, String password) async {
    return await FirebaseAuth.instance
        .signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  /// Google sign in
  Future<UserCredential> signInWithGoogle() async {
    /// Create a new provider
    GoogleAuthProvider googleProvider = GoogleAuthProvider();

    googleProvider.setCustomParameters({
      'login_hint': 'user@example.com'
    });

    /// Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithPopup(googleProvider);

    /// Or use signInWithRedirect
    // return await FirebaseAuth.instance.signInWithRedirect(googleProvider);
  }

  /// Reset password
  Future<void> sendPasswordResetEmail(String email) async {
    return FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }

  /// Sign out
  Future<void> signOut() async {await FirebaseAuth.instance.signOut();}
}
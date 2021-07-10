import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginRepository {
  /// Authenticate user
  Future<bool> userAuthenticated() async {
    bool authenticated = false;
    await FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        authenticated = false;
        print('User is currently signed out!');
      } else {
        authenticated = true;
        print('User is signed in!');
      }
    });
    return authenticated;
  }

  /// Local sign in
  Future<UserCredential> localSignIn(String email, String password) async {
    return await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  /// Google sign in
  Future<UserCredential> signInWithGoogle() async {
    /// Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    /// Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;

    /// Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    /// Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  // Future<UserCredential> signInWithFacebook() async {
  //   /// Trigger the sign-in flow
  //   final LoginResult result = await FacebookAuth.instance.login();
  //
  //   /// Create a credential from the access token
  //   final facebookAuthCredential = FacebookAuthProvider.credential(result.accessToken!.token);
  //
  //   /// Once signed in, return the UserCredential
  //   return await FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
  // }

  /// Sign out
  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}

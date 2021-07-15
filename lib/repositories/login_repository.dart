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
      } else if (user.uid.isNotEmpty) {
        print('uid exist ' + user.uid);
        authenticated = true;
        print('User is signed in!');
      }
    });
    return authenticated;
  }

  /// Local sign in
  Future<String> localSignIn(String email, String password) async {
    String message = '';
    UserCredential userCredential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(
          email: email,
          password: password,
        )
        .whenComplete(() => message = 'success')
        .catchError((error, stackTrace) {
      print(error);
      message = 'There was some problem signing in, please retry';
    });
    if (userCredential == null) message = 'Incorrect details';
    return message;
  }

  /// Google sign in
  Future<String> signInWithGoogle() async {
    String message = '';

    /// Trigger the authentication flow
    final GoogleSignInAccount? googleUser =
        await GoogleSignIn().signIn().onError((error, stackTrace) {
      message = 'error';
      print(error);
    });

    /// Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;

    /// Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    /// Once signed in, return the UserCredential
    await FirebaseAuth.instance
        .signInWithCredential(credential)
        .whenComplete(() => message = 'success')
        .catchError((error, stackTrace) {
      print(error);
      message = 'There was some problem signing in, please retry';
    });
    return message;
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
    await FirebaseAuth.instance
        .signOut()
        .whenComplete(() => print('Signed Out'));
  }
}

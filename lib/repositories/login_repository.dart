import 'package:firebase_auth/firebase_auth.dart';

class LoginRepository {
  /// Authenticate user
  Future<bool> userAuthenticated() async {
    return FirebaseAuth.instance.currentUser == null ? false : true;
  }

  /// Get user email
  String get getEmail => FirebaseAuth.instance.currentUser!.email.toString();

  /// Create firebase account for driver
  Future<String> createUserProfile(String email, String password) async {
    String message = '';
    try {
      // UserCredential userCredential =
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: email.replaceAll(' ', ''), password: password)
          .whenComplete(() => message = 'success');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        message = 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        message = 'The account already exists for that email.';
      }
    } catch (e) {
      message = 'There was some problem during registration, please retry';
    }
    return message;
  }

  /// Local sign in
  Future<String> localSignIn(String email, String password) async {
    String message = '';
    try {
      UserCredential user = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
            email: email,
            password: password,
          );
      if(user.user!.email != '')
        message = 'success';
      else
        message = 'Incorrect details';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') message = 'User not found';
      print(e.code);
    } catch (e) {
      message = 'There was some problem during registration, please retry';
    }
    return message;
  }

  /// Sign out
  Future<void> signOut() async {
    await FirebaseAuth.instance
        .signOut()
        .whenComplete(() => print('Signed Out'));
  }

// /// Google sign in
// Future<String> signInWithGoogle() async {
//   String message = '';
//
//   /// Trigger the authentication flow
//   final GoogleSignInAccount? googleUser = await GoogleSignIn()
//       .signIn().onError((error, stackTrace) {
//         message = 'error';
//         print('Google user error $error');
//       });
//
//   /// Obtain the auth details from the request
//   final GoogleSignInAuthentication googleAuth =
//       await googleUser!.authentication;
//
//   /// Create a new credential
//   final credential = GoogleAuthProvider.credential(
//     accessToken: googleAuth.accessToken,
//     idToken: googleAuth.idToken,
//   );
//
//   /// Once signed in, return the UserCredential
//   await FirebaseAuth.instance
//       .signInWithCredential(credential)
//       .whenComplete(() => message = 'success')
//       .catchError((error, stackTrace) {
//     print('Firebase Auth error $error');
//     message = 'There was some problem signing in, please retry';
//   });
//   return message;
// }

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

}

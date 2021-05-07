import 'package:firebase_auth/firebase_auth.dart';

class LoginRepository {
  Future<UserCredential> getUserCredentials(String email, String password) async{
    return await FirebaseAuth.instance
        .signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> signOut() async{
    await FirebaseAuth.instance.signOut();
  }
}
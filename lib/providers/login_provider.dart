import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:goa_bus/repositories/login_repository.dart';

class LoginProvider with ChangeNotifier {
  List<String> greetings = ['Good Morning', 'Good Afternoon', 'Good Evening', 'Welcome'];
  List<String> allowedLogins = ['vishnair001@gmail.com', 'patildeepak188@gmail.com', 'goabusadmin@gmail.com'];
  String email = '';
  String password = '';
  String authenticationMessage = '';
  bool loading = false;
  bool showAuthenciationAlert = false;
  bool authenticated = false;
  bool googleAuthentication = false;

  String setGreeting() {
    String greet = '';
    var hour = DateTime.now().hour;
    if (hour <= 12)
      greet = greetings[0];
    else if (hour <= 17 && hour > 12)
      greet = greetings[1];
    else if (hour > 17 && hour < 20)
      greet = greetings[2];
    else
      greet = greetings[3];
    return greet;
  }

  void setEmail(String _email) {
    email = _email;
    showAuthenciationAlert = false;
    notifyListeners();
  }

  void setPassword(String _password) {
    password = _password;
    showAuthenciationAlert = false;
    notifyListeners();
  }

  Future<void> login() async {
    showAuthenciationAlert = false;
    loading = true;
    notifyListeners();

    if (!googleAuthentication) {
      if (email == "") {
        loading = false;
        showAuthenciationAlert = true;
        authenticationMessage = "Enter your email";
      } else if (!email.contains("@") ||
          (!email.contains(".com") && !email.contains(".in"))) {
        loading = false;
        showAuthenciationAlert = true;
        authenticationMessage = "Incorrect email format";
      } else if (password == "") {
        loading = false;
        showAuthenciationAlert = true;
        authenticationMessage = "Enter your password";
      }
      notifyListeners();
    }

    if(!showAuthenciationAlert) {
      try {
        UserCredential userCredential = googleAuthentication ?
          await LoginRepository().signInWithGoogle()
          : await LoginRepository().localSignIn(email, password);

        if (userCredential == null) {
          loading = false;
          authenticated = false;
          showAuthenciationAlert = true;
          authenticationMessage = "Couldn't sign in";
          print('User is currently signed out!');
          notifyListeners();
        } else {
          if(allowedLogins.contains(userCredential.user.email)) {
            loading = false;
            authenticated = true;
            showAuthenciationAlert = true;
            authenticationMessage = "Signed in";
            print('User is signed in!');
            notifyListeners();
          } else {
            loading = false;
            authenticated = false;
            showAuthenciationAlert = true;
            authenticationMessage = "Only admins are allowed to login";
            notifyListeners();
          }
        }
      } on FirebaseAuthException catch (e) {
        loading = false;
        authenticated = false;
        if (e.code == 'user-not-found') {
          showAuthenciationAlert = true;
          authenticationMessage = "User not found!";
          print('No user found for that email.');
        } else if (e.code == 'wrong-password') {
          showAuthenciationAlert = true;
          authenticationMessage = "Incorrect password";
          print('Wrong password provided for that user.');
        } else {
          showAuthenciationAlert = true;
          authenticationMessage = "Incorrect details";
          print('Incorrect details');
        }
        notifyListeners();
      }
    }
  }

  Future<void> forgotPassword() async {
    loading = true;
    notifyListeners();
    if(email.isEmpty) {
      loading = false;
      showAuthenciationAlert = true;
      authenticationMessage = "Enter your email";
      notifyListeners();
    } else {
      await LoginRepository().sendPasswordResetEmail(email);
      loading = false;
      showAuthenciationAlert = true;
      authenticationMessage =
        "Reset password link sent to email address";
      notifyListeners();
    }
  }

  Future<void> logout() async {
    await LoginRepository().signOut();
    print('User is signed out!');
  }

}
import 'package:flutter/material.dart';
import 'package:goabus_users/providers/login_provider.dart';
import 'package:goabus_users/screens/loginPage.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(PassengerApp());
}

class PassengerApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => LoginProvider()),
      ],
      child: MaterialApp(
        title: 'PassengerApp',
        home: LoginPage(),
      ),
    );
  }
}

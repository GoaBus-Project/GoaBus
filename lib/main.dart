import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:goabus_users/providers/home_provider.dart';
import 'package:goabus_users/providers/login_provider.dart';
import 'package:goabus_users/screens/login_page.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(PassengerApp());
}

class PassengerApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => LoginProvider()),
        ChangeNotifierProvider(create: (context) => HomeProvider()),
      ],
      child: MaterialApp(
        title: 'PassengerApp',
        home: LoginPage(),
      ),
    );
  }
}

import 'package:drivers_app/providers/homepage_provider.dart';
import 'package:drivers_app/providers/loginpage_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/login_page.dart';

void main() {
  runApp(DriverApp());
}

class DriverApp extends StatefulWidget {
  @override
  _DriverAppState createState() => _DriverAppState();
}

class _DriverAppState extends State<DriverApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => HomePageProvider()),
          ChangeNotifierProvider(create: (context) => LoginPageProvider()),
        ],
      child: MaterialApp(
          title: "DRIVER APP",
          home: LoginPage()
      ),
    );
  }
}


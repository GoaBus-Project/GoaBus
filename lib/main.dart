import 'package:flutter/material.dart';
import 'package:goa_bus/providers/home_provider.dart';
import 'package:provider/provider.dart';

import 'package:goa_bus/screens/login_screen.dart';

import 'package:goa_bus/providers/login_provider.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => LoginProvider()),
        ChangeNotifierProvider(create: (context) => HomeProvider()),
      ],
      child: MaterialApp(
          home: LoginScreen()
      ),
    );
  }

}

import 'package:provider/provider.dart';

import 'package:flutter/material.dart';

import 'package:goa_bus/providers/navbar_provider.dart';
import 'package:goa_bus/providers/sidebar_provider.dart';
import 'package:goa_bus/providers/home_provider.dart';
import 'package:goa_bus/providers/login_provider.dart';
import 'package:goa_bus/screens/login_screen.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(GoaBusApp());
}

class GoaBusApp extends StatefulWidget {
  @override
  _GoaBusAppState createState() => _GoaBusAppState();
}

class _GoaBusAppState extends State<GoaBusApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => LoginProvider()),
        ChangeNotifierProvider(create: (context) => NavBarProvider()),
        ChangeNotifierProvider(create: (context) => SideBarProvider.init()),
        ChangeNotifierProvider(create: (context) => HomeProvider()),
      ],
      child: MaterialApp(
          home: LoginScreen()
      ),
    );
  }

}

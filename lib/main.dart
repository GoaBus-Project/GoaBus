import 'package:goa_bus/providers/sidebar_providers/bus_stop_provider.dart';
import 'package:goa_bus/providers/sidebar_providers/buses_provider.dart';
import 'package:goa_bus/providers/sidebar_providers/drivers_provider.dart';
import 'package:goa_bus/screens/login_screen.dart';

import 'package:provider/provider.dart';

import 'package:flutter/material.dart';

import 'package:goa_bus/providers/navbar_provider.dart';
import 'package:goa_bus/providers/sidebar_provider.dart';
import 'package:goa_bus/providers/home_provider.dart';
import 'package:goa_bus/providers/login_provider.dart';


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
        ChangeNotifierProvider(create: (context) => SideBarProvider()),
        ChangeNotifierProvider(create: (context) => HomeProvider()),
        ChangeNotifierProvider(create: (context) => BusesProvider()),
        ChangeNotifierProvider(create: (context) => DriversProvider()),
        ChangeNotifierProvider(create: (context) => BusStopProvider()),
      ],
      child: MaterialApp(
          home: LoginScreen()
      ),
    );
  }

}

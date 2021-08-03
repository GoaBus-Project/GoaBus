import 'package:android_intent/android_intent.dart';
import 'package:drivers_app/repositories/location_repository.dart';
import 'package:drivers_app/repositories/login_repository.dart';
import 'package:drivers_app/services/location_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';

class HomePageProvider with ChangeNotifier {
  bool start = false, loading = false;

  Future<void> startStopSendingLocation(BuildContext context) async {
    start = !start;
    notifyListeners();

    /// Check if started location
    if (start) {
      print('location Started');
      if (await Services().checkPermission()) {
        Location location = Location();
        print('location permission is given');
        // location.enableBackgroundMode(enable: true);
        location.onLocationChanged.listen((LocationData currentLocation) async {
          print(currentLocation.latitude.toString() +
              " " +
              currentLocation.longitude.toString());
          if (start) {
            await LocationRepository()
                .syncLocation(currentLocation)
                .onError((error, stackTrace) {
              start = false;
              notifyListeners();
              print(error);
              return Future.error('There was some problem');
            });
          }
        });
      } else {
        start = !start;
        notifyListeners();
        if (!await Services().getLocationPermission()) {
          if (Theme.of(context).platform == TargetPlatform.android) {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text("Can't get current location"),
                    content: const Text(
                        'Please make sure you enable GPS and try again'),
                    actions: <Widget>[
                      MaterialButton(
                          child: Text('Go to settings'),
                          onPressed: () {
                            final AndroidIntent intent = AndroidIntent(
                                action:
                                    'android.settings.LOCATION_SOURCE_SETTINGS');
                            intent.launch();
                            Navigator.of(context, rootNavigator: true).pop();
                          })
                    ],
                  );
                });
          }
        }
      }
    }
  }

  Future<String> changePassword(
      String newPassword, String confirmPassword) async {
    String message = '';

    if (newPassword.isEmpty) {
      loading = false;
      notifyListeners();
      return 'New password cannot be empty';
    } else if (confirmPassword.isEmpty) {
      loading = false;
      notifyListeners();
      return 'Please confirm password';
    } else if (newPassword != confirmPassword) {
      loading = false;
      notifyListeners();
      return 'Password mismatch';
    } else if (newPassword.length < 8) {
      loading = false;
      notifyListeners();
      return 'Password length cannot be less than 8';
    } else {
      loading = true;
      notifyListeners();
      message =
          await LoginRepository().changePassword(newPassword).whenComplete(() {
        loading = false;
        notifyListeners();
      });
    }
    return message;
  }
}

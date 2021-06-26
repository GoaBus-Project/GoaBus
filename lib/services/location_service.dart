import 'package:location/location.dart';

class Services {
  Future<bool> getLocationPermission() async {
    bool _serviceEnabled = false;
    Location location = Location();

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return _serviceEnabled;
      }
    }
    return _serviceEnabled;
  }

  Future<bool> checkPermission() async {
    bool _serviceEnabled = false;
    PermissionStatus _permissionGranted;
    Location location = Location();

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted == PermissionStatus.granted ||
          _permissionGranted == PermissionStatus.grantedLimited) {
        _serviceEnabled = true;
        return true;
      }
    } else if (_permissionGranted == PermissionStatus.granted) {
      _serviceEnabled = true;
      return true;
    }
    return _serviceEnabled;
  }
}

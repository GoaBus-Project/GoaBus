import 'package:goa_bus/models/routes_model.dart';
import 'package:firebase_database/firebase_database.dart';

class RoutesRepository {
  /// save data to firestore dbm
  Future<bool> saveRoutes(RoutesModel routesData) async {
    bool success = false;
    final databaseReference = FirebaseDatabase.instance.reference();
    routesData.trips.forEach((element) {
      databaseReference.child("Routes").child("${element.route}").set({
        'busNo': '${routesData.busNo}'
      }).whenComplete(() => success = true)
        .onError((error, stackTrace) {
          print('$error: Stacktrace => $stackTrace');
          return false;
        });
    });
    return success;
  }

  /// fetch data
  Future<List<RoutesModel>> fetchRoutes() async {
    List<RoutesModel> routesData = [];
    //TODO do be implemented
    return routesData;
  }
}
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drivers_app/common/constants.dart';
import 'package:location_platform_interface/location_platform_interface.dart';

class LocationRepository {
  Future<void> syncLocation(LocationData locationData) async {
    /// Create reference that references the firestore collection
    DocumentReference bus = FirebaseFirestore.instance
        .collection(Constants.BUSES_COLLECTION)
        .doc("GA-05-GG12");
    await bus.update({
      'lat': locationData.longitude,
      'lng': locationData.latitude
    });
  }
}
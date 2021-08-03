import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drivers_app/common/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:location_platform_interface/location_platform_interface.dart';

class LocationRepository {
  Future<String> getBusNumber(String email) async {
    String busNo = '';
    // print(email);
    await FirebaseFirestore.instance
        .collection(Constants.BUSES_COLLECTION)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        if (doc['driverEmail'] == email) {
          busNo = doc.id.toString();
          return;
        }
      });
    });
    return busNo;
  }

  Future<void> syncLocation(LocationData locationData) async {
    String busNumber =
        await getBusNumber(FirebaseAuth.instance.currentUser!.email.toString());
    print(busNumber);

    /// Create reference that references the firestore collection
    DocumentReference bus = FirebaseFirestore.instance
        .collection(Constants.BUSES_COLLECTION)
        .doc(busNumber);
    await bus
        .update({'lat': locationData.latitude, 'lng': locationData.longitude});
  }
}

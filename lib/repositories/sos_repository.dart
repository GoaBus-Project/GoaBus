import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drivers_app/common/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'location_repository.dart';

class SOSRepository {
  Future<String> postSOS(String sosMessage) async {
    String message = '',
        email = FirebaseAuth.instance.currentUser!.email.toString(),
        busNo = await LocationRepository().getBusNumber(email);

    /// Create a CollectionReference called 'SOS' that references the firestore collection
    CollectionReference sos =
        FirebaseFirestore.instance.collection(Constants.SOS_COLLECTION);
    await sos.doc(email).set({
      'read': false,
      'busNo': busNo,
      'message': sosMessage,
    }).whenComplete(() {
      print("SOS posted");
      message = 'success';
    }).onError((error, stackTrace) {
      print("Failed to post sos: $error");
      message = 'Failed to post sos, please retry';
    });
    return message;
  }
}

import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:goa_bus/constants/constants.dart';
import 'package:goa_bus/models/drivers_model.dart';
import 'package:http/http.dart' as http;

class DriversRepository {
  Future<String> uploadImage(Uint8List image, String name) async {
    String firebaseImagePath = '';
    FirebaseStorage storage = FirebaseStorage.instance;

    /// Create a reference to the location you want to upload to in firebase
    Reference ref = storage.ref().child(name);

    /// Upload the file to firebase
    UploadTask uploadTask = ref.putData(image);

    /// Waits till the file is uploaded then stores the download url
    await uploadTask.then((res) async {
      firebaseImagePath = await res.ref.getDownloadURL();
    });

    return firebaseImagePath;
  }

  Future<bool> save(Driver driver) async {
    bool success = false;
    String imagePath = '';

    if(driver.image.isNotEmpty)
      imagePath = await uploadImage(driver.image, driver.name);

    if((imagePath != '' && imagePath != null)
        || driver.image == null) {
      /// Create a CollectionReference called Drivers that references the firestore collection
      DocumentReference busStops =
        FirebaseFirestore.instance
            .collection(Constants.DRIVERS_COLLECTION)
            .doc(driver.name + " - " + driver.contact);
      await busStops.set({
        'profilePath': imagePath,
        'name': driver.name.toString(),
        'contact': driver.contact.toString(),
        'address': driver.address.toString(),
      })
          .whenComplete(() {
        print("Driver added");
        success = true;
      })
          .onError((error, stackTrace) {
        print("Failed to add stop: $error");
      });
    } else print("Failed to upload image");
    return success;
  }

  Future<DriversModel> fetchDrivers() async {
    DriversModel driversModel = DriversModel();
    driversModel.drivers = [];

    await FirebaseFirestore.instance
        .collection(Constants.DRIVERS_COLLECTION)
        .get()
        .then((QuerySnapshot querySnapshot) async {
      await querySnapshot.docs.forEach((doc) async {
        Driver driver = Driver();

        driver.name = doc['name'];
        driver.contact = doc['contact'];
        driver.address = doc['address'];

        http.Response response = await http.get(doc['profilePath'] as Uri);
        driver.image = response.bodyBytes;
        print(driver.image.toString());
        driversModel.drivers.add(driver);
      });
    });
    return driversModel;
  }
}
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:goa_bus/constants/constants.dart';
import 'package:goa_bus/models/drivers_model.dart';

class DriversRepository {
  Future<String> uploadImage(Image image) async {
    String firebaseImagePath = '';
    FirebaseStorage storage = FirebaseStorage.instance;

    /// Create a reference to the location you want to upload to in firebase
    Reference ref = storage.ref().child("DriverImages");

    /// Upload the file to firebase
    UploadTask uploadTask = ref.putBlob(image.image).onError((error, stackTrace) {
      print('Image upload error: ' + error);
      return null;
    });

    /// Waits till the file is uploaded then stores the download url
    uploadTask.then((res) async {
      firebaseImagePath = await res.ref.getDownloadURL();
    });
    return firebaseImagePath;
  }

  Future<bool> save(Driver driver) async {
    bool success = false;
    String imagePath = '';

    if(driver.image != null)
      imagePath = await uploadImage(driver.image);

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
    return driversModel;
  }
}
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:goa_bus/constants/constants.dart';
import 'package:goa_bus/models/buses_model.dart';
import 'package:goa_bus/models/drivers_model.dart';
import 'package:goa_bus/repositories/buses_repository.dart';

class DriversRepository {
  /// Create firebase account for driver
  Future<bool> createDriverProfile(String email, String password) async {
    bool success = false;
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email.replaceAll(' ', ''), password: password)
        .whenComplete(() => success = true)
        .onError((error, stackTrace) {
      success = false;
      print(error);
      return;
    });
    return success;
  }

  /// Upload drivers photo
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

  /// Save driver data
  Future<bool> save(Driver driver) async {
    bool success = false;
    String imagePath = '';

    /// Check if there is image selected
    if (driver.image != null)
      imagePath = await uploadImage(driver.image, driver.name);

    /// Create driver's profile with username "Name-Contact" & password as "Bus no"
    /// Check if drivers profile is created
    String email = driver.name.toLowerCase() + '.' + driver.contact + '@goabus.com';
    if (await createDriverProfile(email, driver.contact)) {
      if ((imagePath != '' && imagePath != null) || driver.image == null) {
        /// Create a CollectionReference called Drivers that references the firestore collection
        DocumentReference busStops = FirebaseFirestore.instance
            .collection(Constants.DRIVERS_COLLECTION)
            .doc(driver.name + " - " + driver.contact);
        await busStops.set({
          'profilePath': imagePath,
          'name': driver.name.toString(),
          'email': email,
          'contact': driver.contact.toString(),
          'address': driver.address.toString(),
        }).whenComplete(() {
          print("Driver added");
          success = true;
        }).onError((error, stackTrace) {
          print("Failed to add stop: $error");
        });
      } else
        print("Failed to upload image");
    } else {
      success = false;
      return false;
    }
    return success;
  }

  /// Fetch drivers data
  Future<DriversModel> fetchDrivers() async {
    DriversModel driversModel = DriversModel();
    driversModel.drivers = [];
    await FirebaseFirestore.instance
        .collection(Constants.DRIVERS_COLLECTION)
        .get()
        .then((QuerySnapshot querySnapshot) async {
      querySnapshot.docs.forEach((doc) async {
        Driver driver = Driver();
        driver.image = null;

        driver.name = doc['name'];
        driver.contact = doc['contact'];
        driver.address = doc['address'];
        driver.imagePath = doc['profilePath'];
        // driver.image = (await NetworkAssetBundle(
        //     Uri.parse(driver.imagePath))
        //     .load(driver.imagePath))
        //     .buffer
        //     .asUint8List();
        // print('profile path' + driver.image.toString());
        // http.Response response = await http.get(doc['profilePath'] as Uri);
        // driver.image = await http.readBytes(Uri.parse(doc['profilePath']));
        // print('success' + driver.image.toString());
        driversModel.drivers.add(driver);
      });
    });
    return driversModel;
  }

  /// Delete driver
  Future<bool> deleteDriver(String driverName) async {
    bool success = false;

    /// Delete from buses
    BusesModel busesModel = BusesModel();
    busesModel = await BusesRepository().fetchBuses();
    String busNo = "";

    busesModel.buses.forEach((element) {
      if (element.driver.trim() == driverName.trim())
        busNo = element.busNo.toString();
    });
    if (busNo != "") {
      await FirebaseFirestore.instance
          .collection(Constants.BUSES_COLLECTION)
          .doc(busNo)
          .update({"driver": "No Driver"})
          .whenComplete(() => success = true)
          .onError((error, stackTrace) {
            success = false;
            print(error);
          });
    }

    /// Delete driver data from drivers collection
    await FirebaseFirestore.instance
        .collection(Constants.DRIVERS_COLLECTION)
        .doc(driverName)
        .delete()
        .whenComplete(() => success = true)
        .onError((error, stackTrace) => print(error));
    return success;
  }
}

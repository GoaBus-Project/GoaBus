import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:goa_bus/common/alert_dialog_screen.dart';
import 'package:goa_bus/constants/color_palette.dart';
import 'package:goa_bus/providers/sidebar_providers/driver_providers/drivers_form_provider.dart';
import 'package:goa_bus/providers/sidebar_providers/driver_providers/drivers_provider.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:provider/provider.dart';

class DriverForm extends StatefulWidget {
  @override
  _DriverFormState createState() => _DriverFormState();
}

class _DriverFormState extends State<DriverForm> {
  @override
  Widget build(BuildContext context) {
    return Consumer<DriversFormProvider>(
      builder: (context, driverProv, _) {
        return Column(
          children: [
            driverProv.driver.image == null
                ? FloatingActionButton(
                    child: Icon(Icons.open_in_browser),
                    onPressed: () async {
                      Uint8List _image = await ImagePickerWeb.getImage(
                          outputType: ImageType.bytes);
                      driverProv.setProfile(_image);
                    })
                : ClipOval(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: CircleAvatar(
                      radius: 100,
                      backgroundColor: Colors.transparent,
                      child: Image.memory(driverProv.driver.image),
                    ),
                  ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 15),
                  TextFormField(
                    decoration: InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: "Driver's Name",
                    ),
                    onChanged: (name) {
                      driverProv.driver.name = name;
                    },
                  ),
                  SizedBox(height: 30),
                  TextFormField(
                    decoration: InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: "Contact Number",
                    ),
                    keyboardType: TextInputType.number,
                    maxLength: 10,
                    onChanged: (number) {
                      driverProv.driver.contact = number;
                    },
                  ),
                  SizedBox(height: 30),
                  TextFormField(
                    decoration: InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: "Address",
                    ),
                    onChanged: (address) {
                      driverProv.driver.address = address;
                    },
                  ),
                  SizedBox(height: 50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Palette.secondary),
                        ),
                        onPressed: () async {
                          String checkData = driverProv.checkData();
                          if (checkData == '' || checkData == 'success') {
                            if (await driverProv.saveDrivers()) {
                              await Provider.of<DriversProvider>(context,
                                      listen: false)
                                  .getData();
                              driverProv.loading = false;
                              Navigator.pop(context);
                            } else {
                              driverProv.loading = false;
                              return showAlertDialog(
                                  context: context,
                                  title: 'Please try again',
                                  message:
                                      'There was some problem while saving data');
                            }
                          } else {
                            return showAlertDialog(
                                context: context,
                                title: 'Missing Data',
                                message: checkData);
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 11),
                          child: Text(
                            "Save".toUpperCase(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Palette.fontColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 40),
                      driverProv.loading
                          ? CircularProgressIndicator(color: Palette.secondary)
                          : Container(),
                    ],
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

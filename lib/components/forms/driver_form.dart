import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:goa_bus/common/alert_dialog_screen.dart';
import 'package:goa_bus/constants/color_palette.dart';
import 'package:goa_bus/providers/sidebar_providers/drivers_provider.dart';
import 'package:provider/provider.dart';

class DriverForm extends StatefulWidget {
  @override
  _DriverFormState createState() => _DriverFormState();
}

class _DriverFormState extends State<DriverForm> {
  @override
  Widget build(BuildContext context) {
    return Consumer<DriversProvider>(
      builder: (context, driverProv, _) {
        return Column(
          children: [
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
                    onChanged: (number) {

                    },
                  ),
                  SizedBox(height: 30),
                  TextFormField(
                    decoration: InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: "Contact Number",
                    ),
                    onChanged: (number) {

                    },
                  ),
                  SizedBox(height: 30),
                  TextFormField(
                    decoration: InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: "Address",
                    ),
                    onChanged: (number) {

                    },
                  ),
                  SizedBox(height: 50),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Palette.secondary),
                    ),
                    onPressed: () async {
                      // String checkData = driverProv.checkData();
                      // if(checkData == '') {
                      //   if (await driverProv.saveRoutesData()) {
                      //     driverProv.loading = false;
                      //     Navigator.pop(context);
                      //     return SnackBar(
                      //       content: Text('Data saved'),
                      //       backgroundColor: Palette.secondary,
                      //     );
                      //   } else {
                      //     driverProv.loading = false;
                      //     return showAlertDialog(
                      //         context: context,
                      //         title: 'Please try again',
                      //         message: 'There was some problem while saving data'
                      //     );
                      //   }
                      // } else {
                      //   return showAlertDialog(
                      //       context: context,
                      //       title: 'Missing Data',
                      //       message: checkData
                      //   );
                      // }
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 11),
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

                  // SizedBox(height: 10),
                  // driverProv.loading?
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     SizedBox(
                  //         height: 15,
                  //         width: 15,
                  //         child: CircularProgressIndicator(backgroundColor: Palette.secondary)
                  //     ),
                  //     SizedBox(width: 10),
                  //     Text(
                  //       'Saving data..',
                  //       style: TextStyle(
                  //           color: Colors.green
                  //       ),
                  //     ),
                  //   ],
                  // ):Container(),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:goa_bus/constants/color_palette.dart';

showAlertDialog({BuildContext context, String title, String message}) {
  /// set up the button
  Widget okButton = MaterialButton(
      child: Text(
        'OK'.toUpperCase(),
        style: TextStyle(color: Colors.white),
      ),
      splashColor: Palette.primary,
      color: Palette.secondary,
      onPressed: () {
        Navigator.pop(context);
      });

  /// set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text(title),
    content: Text(message),
    actions: [
      okButton,
    ],
  );

  /// show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

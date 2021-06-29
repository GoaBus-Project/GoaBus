import 'package:flutter/material.dart';
import 'package:goa_bus/common/alert_dialog_screen.dart';
import 'package:goa_bus/constants/color_palette.dart';
import 'package:goa_bus/providers/sidebar_providers/bus_providers/buses_form_provider.dart';
import 'package:goa_bus/providers/sidebar_providers/bus_providers/buses_provider.dart';
import 'package:provider/provider.dart';

class AddTripsForm extends StatefulWidget {
  final int index;

  const AddTripsForm({Key key, @required this.index}) : assert(index != null);

  @override
  _AddTripsFormState createState() => _AddTripsFormState();
}

class _AddTripsFormState extends State<AddTripsForm> {
  Future<void> _selectTime(bool startTime, BusesFormProvider prov) async {
    final TimeOfDay newTime = await showTimePicker(
      context: context,
      initialTime: startTime ? prov.trip.startTime : prov.trip.endTime,
    );
    if (newTime != null) {
      startTime ? prov.setStartTime(newTime) : prov.setEndTime(newTime);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BusesFormProvider>(
      builder: (context, busesProv, _) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            DropdownButton<String>(
              hint: Text("Select Route"),
              value: busesProv.trip.routeName,
              onChanged: (String value) {
                busesProv.setRoute(value);
              },
              items: busesProv.routes.map((String route) {
                return DropdownMenuItem<String>(
                  value: route,
                  child: Row(
                    children: <Widget>[
                      SizedBox(width: 10),
                      Text(
                        route,
                        style: TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
            // SizedBox(width: 100.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Start Time: '
                          '${busesProv.trip.startTime.format(context)}'
                      .toUpperCase(),
                  style: TextStyle(fontSize: 15.0),
                ),
                SizedBox(width: 8),
                IconButton(
                  padding: new EdgeInsets.all(0.0),
                  icon: Icon(Icons.access_time),
                  onPressed: () async {
                    await _selectTime(true, busesProv);
                  },
                ),
              ],
            ),
            // SizedBox(width: 100.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'End Time: '
                          '${busesProv.trip.endTime.format(context)}'
                      .toUpperCase(),
                  style: TextStyle(fontSize: 15.0),
                ),
                SizedBox(width: 8),
                IconButton(
                  padding: new EdgeInsets.all(0.0),
                  icon: Icon(Icons.access_time),
                  onPressed: () async {
                    await _selectTime(false, busesProv);
                  },
                ),
              ],
            ),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(Palette.secondary),
              ),
              onPressed: () async {
                if (!await busesProv.addTrip(context, widget.index)) {
                  showAlertDialog(
                    context: context,
                    title: "Error",
                    message: "Failed to add trip",
                  );
                } else {
                  await Provider.of<BusesProvider>(context, listen: false)
                      .init();
                  Navigator.pop(context);
                }
              },
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 11),
                child: Text(
                  "Add".toUpperCase(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Palette.fontColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

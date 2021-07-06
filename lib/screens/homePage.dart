import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:goabus_users/components/sideDrawer.dart';
import 'package:goabus_users/constants/color_palette.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 10,
              ),
              Text("GoaBus"),
              SizedBox(
                width: 50,
              ),
            ],
          ),
          backgroundColor: Palette.secondary,
        ),
        drawer: Drawer(
          child: SideDrawer(),
        ),
        body:Stack(
          children: <Widget>[
            SizedBox.expand(
              child: Container(
                color: Colors.red,
              ),
            ),
            DraggableScrollableSheet(
              initialChildSize: 0.2,
              minChildSize: 0.2,
              maxChildSize: 0.8,
              builder: (BuildContext context, ScrollController scrollController) {
                return Container(
                  decoration: const BoxDecoration(
                    color: Colors.blue,
                    // border: Border.all(color: Colors.blue, width: 2),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8),
                    ),
                  ),
                  child: Scrollbar(
                    child: ListView.builder(
                      controller: scrollController,
                      itemCount: 25,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          leading: const Icon(Icons.ac_unit),
                          title: Text('Item $index'),
                        );
                      },
                    ),
                  ),
                );
              },
            ),
          ],
        ),
    );
  }
}


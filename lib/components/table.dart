import 'package:flutter/material.dart';
import 'package:goa_bus/constants/color_palette.dart';

class TableHeaderTile extends StatelessWidget {
  final String first;
  final String second;
  final String third;

  const TableHeaderTile({
    this.first,
    this.second,
    this.third,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 50.0),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.blue[200],
            borderRadius: BorderRadius.all(Radius.circular(10))
        ),
        child:  Card(
          elevation: 5.0,
          child: Table(
            children: [
              TableRow(
                  decoration: BoxDecoration(
                      color: Colors.blue[200],
                  ),
                  children: [
                    TableCell(child: HeaderTileData(title: first)),
                    TableCell(child: HeaderTileData(title: second)),
                    TableCell(child: HeaderTileData(title: third)),
                    TableCell(child: Text('')),
                  ]
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HeaderTileData extends StatelessWidget{
  final String title;

  const HeaderTileData({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
          title,
          style: TextStyle(
              color: Colors.black,
              fontSize: 30.0
          )
      ),
    );
  }
}

class TableBodyTile extends StatelessWidget {
  final String first;
  final String second;
  final String third;

  const TableBodyTile({
    Key key,
    this.first,
    this.second,
    this.third,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.0,
      child: Card(
          color: Palette.listTileColor,
          child: Table(
            children: [
              TableRow(
                  children: [
                    TileData(title: first),
                    TileData(title: second),
                    TileData(title: third),
                    Center(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 5.0),
                          child: IconButton(
                              icon: Icon(Icons.more_outlined),
                              onPressed: (){

                              }
                          ),
                        )
                    )
                  ]
              )
            ],
          )
      ),
    );
  }
}

class TileData extends StatelessWidget {
  final String title;

  const TileData({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: SizedBox(
          width: 400,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Text(title,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Palette.fontColor,
                    fontSize: 20.0
                )
            ),
          ),
        )
    );
  }
}


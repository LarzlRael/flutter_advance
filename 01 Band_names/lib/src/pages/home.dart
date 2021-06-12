import 'dart:io';

import 'package:brand_names/src/models/band.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Band> bands = [
    Band(id: '1', name: 'metallica', votes: 5),
    Band(id: '2', name: 'Queen ', votes: 10),
    Band(id: '3', name: 'Blondie', votes: 55),
    Band(id: '4', name: 'Link Park', votes: 20),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: Text(
          'BandNames',
          style: TextStyle(color: Colors.black87),
        ),
        backgroundColor: Colors.white,
      ),
      body: ListView.builder(
        itemCount: bands.length,
        itemBuilder: (BuildContext context, int index) =>
            _bandTile(bands[index]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNewBand,
        elevation: 1,
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _bandTile(Band band) {
    return Dismissible(
      background: Container(
        padding: EdgeInsets.only(left: 10),
        color: Colors.red,
        child: Align(
          child: Text('Delete Band', style: TextStyle(color: Colors.white)),
          alignment: Alignment.centerLeft,
        ),
      ),
      key: Key(band.id),
      onDismissed: (direction) {
        print('direction $direction');
        print('direction ${band.id}');
        //TODO: call the delete on the server
      },
      direction: DismissDirection.startToEnd,
      child: ListTile(
        title: Text(band.name),
        leading: CircleAvatar(
          backgroundColor: Colors.blue[100],
          child: Text(band.name.substring(0, 2)),
        ),
        trailing: Text('${band.votes}', style: TextStyle(fontSize: 20)),
        onTap: () {
          print(band.name);
        },
      ),
    );
  }

  _addNewBand() {
    final textEditingController = TextEditingController();
    if (Platform.isAndroid) {
      return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('New band Name'),
            content: TextField(
              controller: textEditingController,
            ),
            actions: [
              MaterialButton(
                child: Text('Add'),
                elevation: 5,
                textColor: Colors.blue,
                onPressed: () {
                  _addBandToList(textEditingController.text);
                },
              )
            ],
          );
        },
      );
    }
    showCupertinoDialog(
        context: context,
        builder: (_) {
          return CupertinoAlertDialog(
            title: Text('New Band Name'),
            content: CupertinoTextField(
              controller: textEditingController,
            ),
            actions: [
              CupertinoDialogAction(
                child: Text('add'),
                isDefaultAction: true,
                onPressed: () {
                  _addBandToList(textEditingController.text);
                },
              ),
              CupertinoDialogAction(
                isDestructiveAction: true,
                child: Text('Dissmisable'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }

  void _addBandToList(String name) {
    if (name.length > 1) {
      this.bands.add(Band(id: DateTime.now().toString(), name: name, votes: 2));
      setState(() {});
    }
    Navigator.pop(context);
  }
}

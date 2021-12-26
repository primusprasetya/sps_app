// uji coba CRUD FIREBASE
// Read  Examples

import 'dart:async';
import 'dart:ffi';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class ReadExamples extends StatefulWidget {
  const ReadExamples({ Key? key }) : super(key: key);

  @override
  _ReadExamplesState createState() => _ReadExamplesState();
} 

class _ReadExamplesState extends State<ReadExamples> {
  String _displayText = 'Results go here';
  final _database = FirebaseDatabase.instance.reference();
  late StreamSubscription _dailySpecialStream;

  @override
  void initState(){
    super.initState();
    _activateListeners();
  }

  void _activateListeners(){
    _dailySpecialStream =
    _database.child('dailySpecial').onValue.listen((event) {
      // final Object? data = event.snapshot.value;
      // final data = new Map<String, dynamic>.from(event.snapshot.value);
      // final description = data['description'] as String;
      // final price = data['price'] as double;

      setState(() {
        // _displayText = 'Today\'s Special: $description For Just  $price';
        // print(mydata.runtimeType);
        _displayText = "set fjnewnfufe";
      });
    });
  }

  @override
  Widget build( BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Read Examples'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 15.0
          ),
          child: Column(
            children: [
              Text(_displayText),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void deactivate(){
    _dailySpecialStream.cancel();
    super.deactivate();
  }

}

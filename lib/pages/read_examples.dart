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
  String _displayText = 'Results go herex';
  final _database = FirebaseDatabase.instance.reference();
  late StreamSubscription _dailySpecialStream;

  @override
  void initState(){
    super.initState();
    _activateListeners();
  }

  void _activateListeners(){
    _dailySpecialStream =
    // _database.child('dailySpecial').onValue.listen((event) {
    _database.child('serverSatu/slotParkir').onValue.listen((event) {
      // final Object? data = event.snapshot.value;
      final data = Map<String, dynamic>.from(event.snapshot.value);
      // final description = data['description'] as String;
      // final price = data['price'] as double;
      final status = data['A1'] as String;
      final status2 = data['A2'] as String;

      setState(() {
        // _displayText = 'Today\'s Special: $description For Just  $price';
        _displayText = 'Slot Parkir A1 : $status \n Slot Parkir A2 : $status2';
        // _displayText = 'Satatus Parkiran: $status2';
        print(data);
        // print(mydata.runtimeType);
        // _displayText = "set fj";
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
              // Text(_displayText),
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

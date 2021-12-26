// uji coba CRUD FIREBASE
// Write Examples

import 'dart:math';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class WriteExamples extends StatefulWidget {
  const WriteExamples({Key? key}) : super(key: key);

  @override
  _WriteExamplesState createState() => _WriteExamplesState();
}

class _WriteExamplesState extends State<WriteExamples> {
  final database = FirebaseDatabase.instance.reference();
  @override
  Widget build(BuildContext context) {
    final dailySepcialRef = database.child('dailySpecial/');
    return Scaffold(
      appBar: AppBar(
        title: Text('Write Examples'),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.only(top: 15.0
          ),
          child: Column(
            children: [
              ElevatedButton(
                onPressed: () async{
                  try {
                    await dailySepcialRef
                      .set({'description': 'Vanilla latte','price':4.99});
                    // await dailySepcialRef.child('price').set(2.99);
                    // await dailySepcialRef.update({'price' : 1.99, 'invetory' : 99});
                    // await database.update({
                    //   'dailySpecial/price' :3.99,
                    //   'someOtherDailySpecial/price' : 3.99,
                    // });
                    print("Special of the day has been written");  
                  } catch (error) {
                    print('You got an error! $error');
                  }
                }, 
              child: Text('Simple Set'),
              ),
              ElevatedButton(
                onPressed: (){
                  final nextOrder = <String, dynamic>{
                    'description': getRandomDrink(),
                    'price' : Random().nextInt(800) / 100.0,
                    'customer' : getRandomName(),
                    'time' : DateTime.now().millisecondsSinceEpoch
                  };
                  database
                  .child('orders')
                  .push()
                  .set(nextOrder)
                  .then((_) => print('Drink has been written!'))
                  .catchError( 
                      (error) => print('You got an error $error'));
                },
                child: Text('Append a drink order')),
            ],
          ),
        ),
      ),
    );
  }
}

String getRandomDrink(){
  final drinklist = [
    'Latte',
    'Cappuccino',
    'Macchiato',
    'Cortado',
    'Mocha',
    'Drip coffee',
    'Cold brew',
    'Espresso',
    'Vanilla latte',
    'Unicorn frappe'
  ];
  return drinklist[Random().nextInt(drinklist.length)];
}

String getRandomName() {
  final customerNames = [
    'Sam',
    'Arthur',
    'Jessica',
    'Rachel',
    'Vivian',
    'Todd',
    'Morgan',
    'Peter',
    'David',
    'Sumit'
  ];
  return customerNames[Random().nextInt(customerNames.length)];
}
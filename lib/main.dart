import 'package:flutter/material.dart';
// import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:sps_app/pages/read_examples.dart';
import 'package:sps_app/pages/home_page2.dart';
import 'package:sps_app/pages/splash_page.dart';
import 'pages/write_examples.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  runApp(  const MyApp());
}
  

class MyApp extends StatefulWidget {
  const MyApp({ Key? key }) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
   final Future<FirebaseApp> _fbApp = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Poppins',
        backgroundColor: Colors.white,
      ),
      routes: {
        '/': (context) => const MyHomePage(title: '',),
        // '/home_page': (context) => const HomePage2(),
      },
    //  home: const HomePage(),
      
    );
  }
}

class MyHomePage extends StatelessWidget {
  final String title;
  const MyHomePage({ Key? key, required this.title }) : super(key: key);
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Check Out our examples!'),
            SizedBox(
              height: 6,
              width: MediaQuery.of(context).size.width,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ReadExamples(),
                  ),
                );
              },
              child: Text('Read Examples')
            ),
             ElevatedButton(
              onPressed: () {
                 Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => WriteExamples(),
                  ),
                );
              },
              child: Text('Write Examples')
            ),
          ],
        ),
      ),
      
    );
  }
}
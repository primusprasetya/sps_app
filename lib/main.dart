import 'package:flutter/material.dart';
import 'package:sps_app/pages/home_page.dart';
import 'package:sps_app/pages/home_page2.dart';
import 'package:sps_app/pages/splash_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({ Key? key }) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Poppins',
        backgroundColor: Colors.white,
      ),
      routes: {
        '/': (context) => const SplashPage(),
        '/home_page': (context) => const HomePage2(),
      },
    //  home: const HomePage(),
      
    );
  }
}
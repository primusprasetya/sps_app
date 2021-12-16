import 'dart:async';


import 'package:flutter/material.dart';
import 'package:sps_app/theme.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({ Key? key }) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  void initState(){
    Timer(Duration(seconds: 3), () => Navigator.pushNamed(context, '/home_page'),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondaryColor,
      body: Center(
        child: Container(
          width: 130,
          height: 150,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/icon_btnb7.png')),
          ),

        ),
      ),
      
    );
  }
}
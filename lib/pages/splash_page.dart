import 'dart:async';
// ignore: import_of_legacy_library_into_null_safe
import 'package:animated_splash_screen/animated_splash_screen.dart';
// ignore: import_of_legacy_library_into_null_safe
// import 'package:page_transition/page_transition.dart';

import 'package:flutter/material.dart';
import 'package:sps_app/pages/home_page2.dart';
import 'package:sps_app/theme.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({ Key? key }) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  // void initState(){
  //   Timer(Duration(seconds: 3), () => Navigator.pushNamed(context, '/home_page2'),
  //   );
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash:  Center(
        child: Container(
          width: 300,
          // height: 150,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/full_logo.png')
              
              ),
          ),

        ),
      ),
      nextScreen: HomePage2(),
      splashTransition: SplashTransition.fadeTransition,
      // pageTransitionType: PageTransitionType.fade,

    ); // return Scaffold(
    //   backgroundColor: secondaryColor,
    //   body: Center(
    //     child: Container(
    //       width: 300,
    //       // height: 150,
    //       decoration: const BoxDecoration(
    //         image: DecorationImage(
    //           image: AssetImage('assets/images/full_logo.png')
              
    //           ),
    //       ),

    //     ),
    //   ),
      
    // );
  }
}
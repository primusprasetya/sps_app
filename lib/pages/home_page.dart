

// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:sps_app/pages/scan_page.dart';
// import 'package:sps_app/theme.dart';
// // import 'package:sps_app/theme.dart';

// class HomePage extends StatelessWidget {
//   const HomePage({ Key? key }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // floatingActionButton: SizedBox(
//       //   // height: 40.0,
//       //   // width: 40.0,
//       //   child: FloatingActionButton.extended(
//       //     onPressed: (){
            
//       //     },
//       //     label: SvgPicture.asset(
//       //       'assets/images/scan_btn.svg',
//       //       height: 180.0,
//       //       width: 267.0,
//       //     ),
//       //   ),
//       // ),
//       // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
//       body: SafeArea(
//         child: Stack(
//           children: [
//             Container(
//               width: 396,
//               height: 899,
//               decoration: const BoxDecoration(
//                 image: DecorationImage(
//                   image: AssetImage(
//                     'assets/images/background.png',
//                   ),
//                   fit: BoxFit.cover,
//                 ),
//               ),
//             ),
//             Column(
//               // crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const SizedBox(
//                   height: 26,
//                 ),
//                  Row(
//                    children: [
//                      const SizedBox(
//                        width: 58,
//                      ),
//                       Image.asset(
//                         'assets/images/icon_btnb1.png',
//                         width: 62, 
//                       ),
//                       Image.asset(
//                         'assets/images/icon_btnb2.png',
//                         width: 62, 
//                       ),
//                       Image.asset(
//                         'assets/images/icon_btnb3.png',
//                         width: 62, 
//                       ),
//                       Image.asset(
//                         'assets/images/icon_btnb4.png',
//                         width: 62, 
//                       ),
//                   ],
//                  ),
//                  const SizedBox(
//                    height: 116,
//                  ),
//                 Row(
//                    children: [
//                      const SizedBox(
//                        width: 94,
//                      ),
//                       Image.asset(
//                         'assets/images/icon_btnb7.png',
//                         width: 62, 
//                       ),
//                       Image.asset(
//                         'assets/images/icon_btnb6.png',
//                         width: 62, 
//                       ),
//                       Image.asset(
//                         'assets/images/icon_btnb5.png',
//                         width: 62, 
//                       ),  
//                  ],
//                 ),
//                 const SizedBox(
//                   height: 477,
//                 ),
//                 InkWell(
//                   onTap: (){
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(builder: (context) => const ScanPage()),
//                     );
//                   },
//                   child: Container(
//                     child: SvgPicture.asset(
//                       'assets/images/scan_btn.svg',
//                       width: 100,
//                     ),
//                     decoration: BoxDecoration(
//                       boxShadow: [
//                         BoxShadow(
//                           color: Color(0xff083033).withOpacity(0.4), 
//                           spreadRadius: 0,
//                           blurRadius: 46,
//                           offset: Offset(0, 24), // changes position of shadow
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ],
          
//         ),
//       ),
//     );
//   }
// }

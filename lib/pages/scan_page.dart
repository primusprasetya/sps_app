import 'dart:async';

import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:sps_app/theme.dart';
import 'package:firebase_database/firebase_database.dart';

class ScanPage extends StatefulWidget {
  const ScanPage({Key? key}) : super(key: key);

  @override
  _ScanPageState createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  TextEditingController platnomorController = TextEditingController (text: '');


  Barcode? qr;
  QRViewController? qrController;
  final _database = FirebaseDatabase.instance.reference();
  late StreamSubscription _dailySpecialStream;

  void updateData() {
    var cek = true;
    _dailySpecialStream = _database.child('server').onValue.listen((event) {
      final data = Map<String, dynamic>.from(event.snapshot.value);

      print(data);

      print("SERVER");
      data.forEach((indexServer, valueServer) {
        valueServer['slotParkir'].forEach((indexSlot, valueSlot) {
          if (valueSlot == 0 && cek) {
            _database
                .child('server/' + indexServer + '/slotParkir')
                .update({indexSlot: 2});
            cek = false;
          }
        });
      });
    });
  }

  final qrKey = GlobalKey(debugLabel: 'QR');

  @override
  void dispose() {
    qrController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Future<void> formPlat() {
    //   return showDialog(
    //      context: context,
    //       builder: (BuildContext context) => Container(
    //             // margin: EdgeInsets.zero,
    //             width: MediaQuery.of(context).size.width - (2 * 3.0),
    //             child: AlertDialog(
    //               backgroundColor: Color(0xff16727A),
    //               shape: RoundedRectangleBorder(
    //                 borderRadius: BorderRadius.circular(12),
    //               ),
    //               content: SingleChildScrollView(
    //                 child: Column(
    //                   // mainAxisAlignment: MainAxisAlignment.center,
    //                   children: [
    //                     Align(
    //                       alignment: Alignment.centerLeft,
    //                       child: InkWell(
    //                         onTap: () {
    //                           Navigator.pop(context);
    //                         },
    //                         child: Icon(
    //                           Icons.close,
    //                           color: Color(0xff7EBABF),
    //                         ),
    //                       ),
    //                     ),
    //                     const SizedBox(height: 20),
    //                     // const SizedBox(height: 12),
    //                     Container(
    //                       // width: 66.0,
    //                       height: 50.0,
    //                       decoration: BoxDecoration(
    //                         color: Color(0xff1A8993),
    //                         borderRadius: BorderRadius.circular(12),
    //                       ),
    //                       child: Center(
    //                           child: Row(
    //                         children: [
    //                           SizedBox(
    //                             width: 16,
    //                           ),
    //                           Expanded(
    //                             child: TextFormField(
    //                               style: subtitleStyle.copyWith(
    //                                 fontSize: 12,
    //                                 fontWeight: FontWeight.w500,
    //                               ),
    //                               controller: platnomorController,
    //                               decoration: InputDecoration.collapsed(
    //                                 hintText: 'Plat Nomor',
    //                                 hintStyle: subtitleStyle.copyWith(
    //                                   color: Color(0XFF296C72),
    //                                   fontSize: 12,
    //                                   fontWeight: FontWeight.w500,
    //                                 ),
    //                               ),
    //                             ),
    //                           )
    //                         ],
    //                       )),
    //                     ),
    //                     const SizedBox(height: 12),
    //                     Text(
    //                       'silahkan masukan nomor plat anda',
    //                       style: subtitleStyle.copyWith(
    //                         fontSize: 12,
    //                         letterSpacing: 1.5,
    //                         color: Color(0xffffffff),
    //                         fontWeight: FontWeight.w400,
    //                       ),
    //                     ),
    //                     const SizedBox(height: 24),
    //                     Container(
    //                       width: 150,
    //                       height: 40,
    //                       margin: EdgeInsets.zero,
    //                       child: TextButton(
    //                         onPressed: () async{
    //                          final logRef = <String, dynamic>{
    //                            'Plat Kendaraan': platnomorController,
    //                            'time': DateTime.now().millisecondsSinceEpoch 
    //                          };
    //                          print(platnomorController.text);
    //                          _database
    //                          .child('log')
    //                          .push()
    //                          .set(logRef)
    //                          .then((_) => print('berhasil menginput plat nomor'))
    //                          .catchError((error)=> print('terjadi error $error'));
    //                           Navigator.pop(context);
    //                           Navigator.push(
    //                             context,
    //                             MaterialPageRoute(
    //                                 builder: (context) => const ScanPage()),
    //                           );
    //                         },
    //                         style: TextButton.styleFrom(
    //                           backgroundColor: Color(0xff1FA2AD),
    //                           shape: RoundedRectangleBorder(
    //                             borderRadius: BorderRadius.circular(12),
    //                           ),
    //                         ),
    //                         child: Text('Input', style: subtitleStyle),
    //                       ),
    //                     ),
    //                   ],
    //                 ),
    //               ),
    //             ),
    //           ));
    // }

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            Navigator.pop(context);
          },
          color: primaryColor,
        ),
        elevation: 0,
      ),
      body: Stack(alignment: Alignment.center, children: <Widget>[
        qrCodeView(context),
        Positioned(
          bottom: 30,
          child: resultQr(),
        ),
      ]),
    );
  }

  Widget resultQr() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white24,
      ),
      child: Text(
        qr != null ? "Result: ${qr!.code}" : "Scan a code!",
        maxLines: 3,
      ),
    );
  }

  Widget qrCodeView(BuildContext context) => QRView(
        key: qrKey,
        onQRViewCreated: qrCodeViewCreated,
        overlay: QrScannerOverlayShape(
          borderWidth: 10,
          borderLength: 20,
          borderRadius: 12,
          borderColor: primaryColor,
          cutOutSize: MediaQuery.of(context).size.width * 0.8,
        ),
      );

  void qrCodeViewCreated(QRViewController qrController) {
    setState(() {
      this.qrController = qrController;
    });
    qrController.scannedDataStream.listen((qr) {
      setState(() {
        // print();
        this.qr = qr;
        qrController.stopCamera();
      });
      if (qr != null) {
        updateData();
      }
    });
  }
}

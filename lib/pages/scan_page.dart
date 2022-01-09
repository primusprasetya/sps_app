import 'dart:async';

import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:sps_app/theme.dart';
import 'package:firebase_database/firebase_database.dart';


class ScanPage extends StatefulWidget {
  const ScanPage({ Key? key }) : super(key: key);

  @override
  _ScanPageState createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  
  Barcode? qr;
  QRViewController? qrController;
  final _database = FirebaseDatabase.instance.reference();
  late StreamSubscription _dailySpecialStream;

  void updateData(){
   _dailySpecialStream =
    _database.child('serverSatu/slotParkir').onValue.listen((event) {
      final data = Map<String, dynamic>.from(event.snapshot.value);

      print(data);
     
     late var cek = true;
      data.forEach((index, value){
        if(cek){
          if(value == 0){
            data[index] = 2;
            cek = false;
          }
        }
      });
      print(data);
      print(cek);
    _database
    .child('serverSatu/slotParkir')
    // .child('serverDua/slotParkir')
    // .push()
    .update(data);
    });

    /* for (initial value; termination_condition; step){
      statements
    }
     */
    
  }

  final qrKey = GlobalKey(debugLabel: 'QR');

  @override
  void dispose() {
    qrController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          qrCodeView(context),
          Positioned(
            bottom: 30,
            child: resultQr(),
          ),
        ]
      ),
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
      if(qr != null){
        updateData();
      }
    });

  }

}
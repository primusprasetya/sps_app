import 'dart:async';

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:sps_app/pages/home_page2.dart';
import 'package:sps_app/theme.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScanPage extends StatefulWidget {
  const ScanPage({Key? key}) : super(key: key);

  @override
  _ScanPageState createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  TextEditingController platnomorController = TextEditingController(text: '');

  Barcode? qr;
  QRViewController? qrController;
  final _database = FirebaseDatabase.instance.reference();
  late StreamSubscription _dailySpecialStream;

  late var status = 0;
  // String? _indexSlot= '';

  @override
  void initState() {
    super.initState();
  }
// void _getData() async {

  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   // await prefs.clear();
  //   setState(() {
  //     _indexSlot = prefs.getString('_indexSlot');
  //   });
  // }

  void mobilMasukBro() {

    _dailySpecialStream = _database.child('server').onValue.listen((event) async {

      final data = Map<String, dynamic>.from(event.snapshot.value);

      for (var i = 1; i <= 8; i++) {
        // LANTAI 1 TOD
        if (i>=1 || i<=4) {
          final random = 'A' + namaFungsi().toString();
          if (data['server1']['slotParkir'][random] == 0) {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            _database.child('server/server1/slotParkir').update({random: 2});
            prefs.setString('_indexSlot', random);
            break;
          }
        // LANTAI 2 TOD
        } else {
          final random = 'B' + namaFungsi().toString();
          if (data['server2']['slotParkir'][random] == 0) {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            _database.child('server/server2/slotParkir').update({random: 2});
            prefs.setString('_indexSlot', random);
            break;
          }
        }
      }
      // print("Ini yang z print TOD $data");
      Future.delayed(const Duration(milliseconds: 2000), () {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const HomePage2()));
      });

    });

  }

  void mobilMasuk() {
    bool cek = true;
    // int i = 0;
    _dailySpecialStream = _database.child('server').onValue.listen((event) async {
      final data = Map<String, dynamic>.from(event.snapshot.value);
      // print("nilai sebelumnya");
      // print(data['server1']['slotParkir']['A2']);
      // print(data);
      do {

        final random = 'A' + namaFungsi().toString();
        print("Nilai Random : $random");
        if (data['server1']['slotParkir'][random] == 0) {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          _database
          .child('server/server1/slotParkir')
          .update({random: 2});
          setState(() {
            cek = false;         
          });     
          // _indexSlot = indexSlot;
          prefs.setString('_indexSlot', random);

        }
        // i++;
        // if(i > 40){
        //   setState(() {
        //     print("False Bro");
        //     cek = false;         
        //   });
        // }
        // print(random);
        // print("bawahnya random");
        // print(i);
      } while (cek);

      int i = 1;
      do {
        print("Prime & Ratno");
        i++;
      } while (i<=10);

      Future.delayed(const Duration(milliseconds: 2000), () {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const HomePage2()));
      });


      // data.forEach((indexServer, valueServer) async{
      //   SharedPreferences prefs =
      //   await SharedPreferences.getInstance();
      //   valueServer['slotParkir'].forEach((indexSlot, valueSlot) {
      //     if (valueSlot == 0 && cek) {
      //       _database
      //           .child('server/' + indexServer + '/slotParkir')
      //           .update({indexSlot: 2});
      //       cek = false;
      //       // _indexSlot = indexSlot;
      //        prefs.setString('_indexSlot', indexSlot);

      //       Future.delayed(const Duration(milliseconds: 2000), (){
      //         Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomePage2()));
      //       });

      //     }
      //   });
      // });
    });
  }

  int namaFungsi() {
    var x = 0;
    var a = 1;
    var rn = 1;
    var no = new Random();
    // print('fungsi pengacakan');
    for (var i = 0; i < no.nextInt(100); i++) {
      x = (1 * rn + i) % 4;
      rn = x;
      if (x == 0) x = rn;
    }

    return x + 1;
  }

  void openPortal() {
    var cek = true;
    print('da masukjikah?');
    _dailySpecialStream =
        _database.child('portalParkiran').onValue.listen((event) {
      final data = Map<String, dynamic>.from(event.snapshot.value);
      print(data);
      print("=====================");
      final status = data['status'] as int;
      print(status);
      if (status == 0 && cek) {
        _database.child('portalParkiran').update({'status': 2});
        cek = false;
      }
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
        qr?.code == '45ee449a2a3d32ed72eee8578a0d1cdd'
            ? "sukses"
            : "Scan VALID QRcode!",
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
    qrController.scannedDataStream.listen((qr) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      setState(() {
        // print();
        this.qr = qr;
        print('disini');
        print(prefs.getString('_noPlat'));
        qrController.stopCamera();
      });
      if (qr != null) {
        if (qr.code == '45ee449a2a3d32ed72eee8578a0d1cdd') {
          openPortal();
          // mobilMasuk();
          mobilMasukBro();
        } else {
          Future.delayed(const Duration(milliseconds: 1000), () {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => super.widget));
          });
        }
      }
    });
  }
}

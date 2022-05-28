import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sps_app/pages/scan_page.dart';
import 'package:sps_app/theme.dart';

class HomePage2 extends StatefulWidget {
  const HomePage2({Key? key}) : super(key: key);

  @override
  State<HomePage2> createState() => _HomePage2State();
}

class _HomePage2State extends State<HomePage2> {
  TextEditingController platnomorController = TextEditingController(text: '');
  // get children => null;
  final _database = FirebaseDatabase.instance.reference();
  // String _displayText = 'Results go herex';
  late StreamSubscription _dailySpecialStream;
  final _formKey = GlobalKey<FormState>();
  String _noPlat = '';
  // String? _indexSlot= '';

  // slot parkir lantai 1
  late var statusA1 = 0;
  late var statusA2 = 0;
  late var statusA3 = 0;
  late var statusA4 = 0;
  late var statusA5 = 0;

  // slot parkir lantai 2
  late var statusB1 = 0;
  late var statusB2 = 0;
  late var statusB3 = 0;
  late var statusB4 = 0;
  late var statusB5 = 0;
  late var statusB6 = 0;
  late var statusB7 = 0;

  @override
  void initState() {
    print('123');
    super.initState();
    _getData();
    _activateListeners();
  }

  void _getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // untuk Mengclear cache secara manual
    await prefs.clear();
    setState(() {
      _noPlat = prefs.getString('_noPlat')!;
      //  _indexSlot = prefs.getString('_indexSlot');
    });
  }

  void _activateListeners() {
    _dailySpecialStream = _database.child('server').onValue.listen((event) {
      final data = Map<String, dynamic>.from(event.snapshot.value);
      setState(() {
        // slot parkir lantai 1
        statusA1 = data['server1']['slotParkir']['A1'] as int;
        statusA2 = data['server1']['slotParkir']['A2'] as int;
        statusA3 = data['server1']['slotParkir']['A3'] as int;
        statusA4 = data['server1']['slotParkir']['A4'] as int;
        statusA5 = data['server1']['slotParkir']['A5'] as int;

        // slot parkir lantai 2
        statusB1 = data['server2']['slotParkir']['B2'] as int;
        statusB2 = data['server2']['slotParkir']['B3'] as int;
        statusB3 = data['server2']['slotParkir']['B4'] as int;
        statusB4 = data['server2']['slotParkir']['B5'] as int;
        statusB5 = data['server2']['slotParkir']['B6'] as int;
        statusB6 = data['server2']['slotParkir']['B7'] as int;
        statusB7 = data['server2']['slotParkir']['B8'] as int;

        // _displayText = 'Slot Parkir A1 : $statusA1 \n Slot Parkir A2 : $statusA2';
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // Future<void> showConfirmDialog() async {
    //   return showDialog(
    //       context: context,
    //       builder: (BuildContext context) => Container(
    //             margin: EdgeInsets.zero,
    //             width: MediaQuery.of(context).size.width - (2 * defaultMargin),
    //             child: AlertDialog(
    //               backgroundColor: primaryColor,
    //               shape: RoundedRectangleBorder(
    //                 borderRadius: BorderRadius.circular(30),
    //               ),
    //               content: SingleChildScrollView(
    //                 child: Column(
    //                   children: [
    //                     Align(
    //                       alignment: Alignment.centerLeft,
    //                       child: InkWell(
    //                         onTap: () {
    //                           Navigator.pop(context);
    //                         },
    //                         child: Icon(
    //                           Icons.close,
    //                           color: primarybtnColor,
    //                         ),
    //                       ),
    //                     ),
    //                     Icon(
    //                       Icons.error_outline_rounded,
    //                       color: primaryColor,
    //                       size: 100,
    //                     ),
    //                     const SizedBox(height: 12),
    //                     Text('Pesanan Ini Dibatalkan?', style: subtitleStyle),
    //                     const SizedBox(height: 12),
    //                     Text('Pesanan ini akan di Batalkan',
    //                         style: subtitleStyle),
    //                     Text('secara permanen', style: subtitleStyle),
    //                     const SizedBox(height: 20),
    //                     Container(
    //                       width: 150,
    //                       height: 40,
    //                       margin: EdgeInsets.zero,
    //                       child: TextButton(
    //                         onPressed: () {
    //                           Navigator.pop(context);
    //                           // onSubmitCancel();
    //                         },
    //                         style: TextButton.styleFrom(
    //                           backgroundColor: Colors.grey,
    //                           shape: RoundedRectangleBorder(
    //                             borderRadius: BorderRadius.circular(12),
    //                           ),
    //                         ),
    //                         child: Text('Ya, Batalkan', style: subtitleStyle),
    //                       ),
    //                     ),
    //                   ],
    //                 ),
    //               ),
    //             ),
    //           ));
    // }

    Future<void> _myAlertDialog() async {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Peringatan'),
            content: SingleChildScrollView(
              child: ListBody(
                children: const <Widget>[
                  Text('Anda tidak dapat melakukan scan dikarenakan slot parkir telah penuh'),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Mengerti'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }

    Future<void> qrcodePOP() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? _indexSlot = prefs.getString('_indexSlot');
      return showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) => Container(
                // margin: EdgeInsets.zero,
                width: MediaQuery.of(context).size.width - (2 * 3.0),
                child: AlertDialog(
                  backgroundColor: Color(0xff16727A),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  content: SingleChildScrollView(
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: InkWell(
                            onTap: () async {
                              print('close');
                              SharedPreferences prefs =
                                  await SharedPreferences.getInstance();
                              await prefs.clear();
                              setState(() {
                                _noPlat = '';
                              });
                              Navigator.pop(context);
                            },
                            child: Icon(
                              Icons.close,
                              color: Color(0xff7EBABF),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Container(
                          width: 250.0,
                          height: 250.0,
                          child: QrImage(
                            data: platnomorController.text + '-' + _indexSlot!,
                            size: 200,
                            backgroundColor: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Silahkan arahkan QR Code ke mesin scan untuk membuka portal',
                          style: subtitleStyle.copyWith(
                            fontSize: 12,
                            letterSpacing: 1.5,
                            color: Color(0xffffffff),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(height: 24),
                      ],
                    ),
                  ),
                ),
              ));
    }

    Future<void> petunjukParkiran() {
      return showDialog(
          context: context,
          builder: (BuildContext context) => Container(
                // margin: EdgeInsets.zero,
                width: MediaQuery.of(context).size.width - (2 * 3.0),
                child: AlertDialog(
                  backgroundColor: Color(0xff16727A),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  content: SingleChildScrollView(
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Icon(
                              Icons.close,
                              color: Color(0xff7EBABF),
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Petunjuk Parkiran',
                          style: subtitleStyle.copyWith(
                              fontSize: 18,
                              letterSpacing: 1.5,
                              color: Color(0xffffffff)
                              // fontWeight: FontWeight.w300,
                              ),
                        ),
                        const SizedBox(height: 24),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(right: 15.0),
                              height: 28,
                              width: 20,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                color: Color(0xff1EAC2C),
                                border: Border.all(
                                  color: secondaryColor,
                                  width: 1,
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  'B1',
                                  style: btntextStyle.copyWith(
                                    fontSize: 10,
                                  ),
                                ),
                              ),
                            ),
                            Text(
                              'Rekomendasi Lokasi Parkir',
                              style: subtitleStyle,
                            )
                          ],
                        ),
                        const SizedBox(height: 12),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(right: 15.0),
                              height: 28,
                              width: 20,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                color: Color(0xffE84E4E),
                                border: Border.all(
                                  color: secondaryColor,
                                  width: 1,
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  'B1',
                                  style: btntextStyle.copyWith(
                                    fontSize: 10,
                                  ),
                                ),
                              ),
                            ),
                            Text(
                              'Lokasi Parkir Telah Terisi',
                              style: subtitleStyle,
                            )
                          ],
                        ),
                        const SizedBox(height: 12),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(right: 15.0),
                              height: 28,
                              width: 20,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                color: Color(0xff1A8993),
                                border: Border.all(
                                  color: secondaryColor,
                                  width: 1,
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  'B1',
                                  style: btntextStyle.copyWith(
                                    fontSize: 10,
                                  ),
                                ),
                              ),
                            ),
                            Text(
                              'Lokasi Parkir Belum Terisi',
                              style: subtitleStyle,
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ));
    }

    Future<void> formPlat() {
      return showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) => Container(
                // margin: EdgeInsets.zero,
                width: MediaQuery.of(context).size.width - (2 * 3.0),
                child: AlertDialog(
                  backgroundColor: Color(0xff16727A),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  content: SingleChildScrollView(
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Icon(
                              Icons.close,
                              color: Color(0xff7EBABF),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        // const SizedBox(height: 12),
                        Container(
                          // width: 66.0,
                          height: 50.0,

                          decoration: BoxDecoration(
                            color: Color(0xff1A8993),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Center(
                              child: Row(
                            children: [
                              SizedBox(
                                width: 16,
                              ),
                              Form(
                                key: _formKey,
                                child: Expanded(
                                  child: TextFormField(
                                    style: subtitleStyle.copyWith(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    controller: platnomorController,
                                    decoration: InputDecoration.collapsed(
                                      hintText: 'Plat Nomor',
                                      hintStyle: subtitleStyle.copyWith(
                                        color: Color(0XFF296C72),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    validator: (String? value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Membutuhkan Plat Nomor';
                                      }
                                      return null;
                                    },
                                    onSaved: (value) async {
                                      SharedPreferences prefs =
                                          await SharedPreferences.getInstance();
                                      await prefs.clear();
                                      _noPlat = value!;
                                      prefs.setString('_noPlat', _noPlat);
                                    },
                                  ),
                                ),
                              )
                            ],
                          )),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'silahkan masukan nomor plat anda',
                          style: subtitleStyle.copyWith(
                            fontSize: 12,
                            letterSpacing: 1.5,
                            color: Color(0xffffffff),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(height: 24),
                        Container(
                          width: 150,
                          height: 40,
                          margin: EdgeInsets.zero,
                          child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState != null &&
                                  _formKey.currentState!.validate()) {
                                print("validated");
                                final logRef = <String, dynamic>{
                                  'platKendaraan': platnomorController.text,
                                  //  'time': DateTime.now().millisecondsSinceEpoch

                                  'time': DateTime.now().toString()
                                };
                                print(platnomorController.text);
                                _database
                                    .child('logs')
                                    .push()
                                    .set(logRef)
                                    .then((_) =>
                                        print('berhasil menginput plat nomor'))
                                    .catchError((error) =>
                                        print('terjadi error $error'));
                                Navigator.pop(context);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const ScanPage()),
                                );
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text('Processing Data')));
                              } else
                                print("not validated");
                              _formKey.currentState!.save();
                              // print(_noPlat);
                            },
                            style: TextButton.styleFrom(
                              backgroundColor: Color(0xff1FA2AD),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: Text('Input', style: subtitleStyle),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ));
    }

    var himpunanData = [
      statusA1,
      statusA2,
      statusA3,
      statusA4,
      statusA5,
      statusB1,
      statusB2,
      statusB3,
      statusB4,
      statusB5,
      statusB6,
      statusB7
    ];
    var tidakPenuh = himpunanData.contains(0);
    Widget btnEnable() {
      return InkWell(
        onTap: () {
          formPlat();
        },
        child: Container(
          child: SvgPicture.asset(
            'assets/images/scan_btn.svg',
            width: 120,
          ),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Color(0xff083033).withOpacity(0.2),
                spreadRadius: 0,
                blurRadius: 26,
                offset: Offset(0, 24), // changes position of shadow
              ),
            ],
          ),
        ),
      );
    }

    Widget btnDisable() {
      return InkWell(
        onTap: () {
          _myAlertDialog();
        },
        child: Container(
          child: SvgPicture.asset(
            'assets/images/scan_btn_disable.svg',
            width: 120,
          ),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Color(0xff083033).withOpacity(0.2),
                spreadRadius: 0,
                blurRadius: 26,
                offset: Offset(0, 24), // changes position of shadow
              ),
            ],
          ),
        ),
      );
    }

    Widget buttonScan() {
      if (tidakPenuh) {
        return btnEnable();
      } else {
        return btnDisable();
      }
    }

    Widget buttonQR() {
      return InkWell(
        onTap: () {
          qrcodePOP();
        },
        child: Container(
          child: SvgPicture.asset(
            'assets/images/btn_qrcode.svg',
            width: 120,
          ),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Color(0xff083033).withOpacity(0.2),
                spreadRadius: 0,
                blurRadius: 26,
                offset: Offset(0, 24), // changes position of shadow
              ),
            ],
          ),
        ),
      );
    }

    Widget slotParkir(String kode, int status) {
      return InkWell(
        onTap: () {
          // showConfirmDialog();
          // qrcodePOP();
          petunjukParkiran();
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(builder: (context) => const ScanPage()),
          // );
        },
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 15.0),
          height: 72,
          width: 56,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: status == 1
                ? Color(0xffE84E4E)
                : status == 2
                    ? Color(0xff1EAC2C)
                    : Color(0xff1A8993),
            border: Border.all(
              color: secondaryColor,
              width: 2,
            ),
            boxShadow: [
              BoxShadow(
                color: Color(0xff10555B).withOpacity(0.6),
                spreadRadius: 6,
                blurRadius: 14,
                offset: Offset(4.0, 8.0),
              ),
            ],
          ),
          child: Center(
            child: Text(
              kode,
              style: btntextStyle,
            ),
          ),
        ),
      );
    }

    Widget _customBtn() {
      // setState(() {
      if (_noPlat != '') {
        return buttonQR();
      }
      return buttonScan();
    }

    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width / 1,
        height: MediaQuery.of(context).size.height / 1,
        decoration: BoxDecoration(color: primaryColor, boxShadow: const [
          BoxShadow(
            color: Color(0xff11575D),
          ),
        ]),
        padding: EdgeInsets.only(
          left: defaultMargin,
          right: defaultMargin,
          top: 64,
          bottom: 20,
        ),
        child: Stack(
          children: <Widget>[
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      slotParkir('B1', statusB1),
                      slotParkir('B2', statusB2),
                      slotParkir('B3', statusB3),
                      slotParkir('B4', statusB4),
                    ],
                  ),
                  Center(
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 40.0),
                      child: Text(
                        'LANTAI 2',
                        style: titleStyle,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      slotParkir('B5', statusB5),
                      slotParkir('B6', statusB6),
                      slotParkir('B7', statusB7),
                    ],
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Container(
                    width: 66.0,
                    height: 46.0,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image:
                                AssetImage('assets/images/icon_stairsup.png'))),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 1,
                    height: 1,
                    decoration: BoxDecoration(
                      color: secondaryColor,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        width: 66.0,
                        height: 46.0,
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(
                                    'assets/images/icon_stairsdown.png'))),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      slotParkir('A1', statusA1),
                      slotParkir('A2', statusA2),
                      slotParkir('A3', statusA3),
                    ],
                  ),
                  Center(
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 40.0),
                      child: Text(
                        'LANTAI 1',
                        style: titleStyle,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      slotParkir('A4', statusA4),
                      slotParkir('A5', statusA5),
                    ],
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width / 1.5,
                            height: 1,
                            decoration: BoxDecoration(
                              color: secondaryColor,
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Row(
                            //  mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Image.asset('assets/images/arrow.png'),
                              const SizedBox(
                                width: 8.0,
                              ),
                              Text(
                                'Pintu Masuk/Keluar',
                                style: subtitleStyle.copyWith(
                                  letterSpacing: 1,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width / 1.12,
                            height: 1,
                            decoration: BoxDecoration(
                              color: secondaryColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment(0.0, 1),
              child: _customBtn(),
            )
          ],
        ),
      ),
    );
  }

  //   @override
  // void deactivate(){
  //   _dailySpecialStream.cancel();
  //   super.deactivate();
  // }

}

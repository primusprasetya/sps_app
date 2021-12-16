import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sps_app/pages/scan_page.dart';
import 'package:sps_app/theme.dart';

class HomePage2 extends StatelessWidget {
  const HomePage2({Key? key}) : super(key: key);

  get children => null;
  @override
  Widget build(BuildContext context) {
    Widget slotParkir(String kode) {
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 15.0),
        height: 72,
        width: 56,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Color(0xff1A8993),
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
      );
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
                      slotParkir('B1'),
                      slotParkir('B2'),
                      slotParkir('B3'),
                      slotParkir('B4'),
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
                      slotParkir('B5'),
                      slotParkir('B6'),
                      slotParkir('B7'),
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
                      slotParkir('A1'),
                      slotParkir('A2'),
                      slotParkir('A3'),
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
                      slotParkir('A4'),
                      slotParkir('A5'),
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
               alignment: Alignment(0.0 , 1),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ScanPage()),
                  );
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}

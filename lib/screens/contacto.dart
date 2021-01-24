import 'package:flutter/material.dart';
import 'package:la_red/widgets/background.dart';
import 'package:la_red/widgets/background_template.dart';
import 'package:la_red/widgets/leagues_tab.dart';
import 'package:la_red/widgets/screen_banner.dart';
import 'package:la_red/widgets/screen_title.dart';

import '../constants.dart';

class Contacto extends StatefulWidget {
  @override
  _contactoState createState() => _contactoState();
}

class _contactoState extends State<Contacto> {
  double getHeight(double percent) =>
      MediaQuery.of(context).size.height * percent;
  double getWidth(double percent) =>
      MediaQuery.of(context).size.width * percent;

  @override
  Widget build(BuildContext context) {
    Leagues _leagues = Leagues.libre;

    return Scaffold(
      body: BackgroundTemplate(
          height: getHeight(1),
          width: getWidth(1),
          title: 'contacto',
          child: Expanded(
            child: Center(
              child: Container(
                height: getHeight(0.98),  //
                width: getWidth(0.85),   //
                margin: EdgeInsets.only(
                    left: getWidth(0.056),  //
                    right: getWidth(0.056),  //
                    top: getHeight(0.029),  //
                    bottom: getHeight(0.08)),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: <Widget>[
                    Container(
                      height: getHeight(0.11),
                      width: getHeight(0.79),
                      margin: EdgeInsets.only(
                          left: getWidth(0.026),
                          right: getWidth(0.026),
                          top: getHeight(0.025),
                          bottom: 0),
                      decoration: BoxDecoration(
                        color: kBordo,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: getWidth(0.046),
                              vertical: getHeight(0.0098),
                            ),
                            child: Container(
                              width: getWidth(0.13),
                              height: getWidth(0.13),
//
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Image.asset("assets/images/Instagram.png"),

                            ),
                          ),
                          SizedBox(
                            width: getWidth(0.04),
                          ),
                          Text(
                            "laredligadefutbol",
                            style: kTextStyle.copyWith(fontSize: getHeight(0.02)),
                          ),
                        ],
                      ),
                      ),
                    Container(
                      height: getHeight(0.11),  //  verrrrrrrrrrrrrrrrrrrrrrrr
                      width: getHeight(0.79),    //  verrrrrrrrrrrrrrrrrrrrrrrr
                      margin: EdgeInsets.only(
                          left: getWidth(0.026),  //  verrrrrrrrrrrrrrrrrrrrrrrr
                          right: getWidth(0.026),  //  verrrrrrrrrrrrrrrrrrrrrrrr
                          top: getHeight(0.025),  //  verrrrrrrrrrrrrrrrrrrrrrrr
                          bottom: 0),
                      decoration: BoxDecoration(
                        color: kBordo,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: getWidth(0.046),
                              vertical: getHeight(0.0098),

                            ),
                            child: Container(
                              width: getWidth(0.13),
                              height: getWidth(0.13),
//
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                              child: Image.asset("assets/images/whatsapp.png"),

                            ),
                          ),
                          SizedBox(
                            width: getWidth(0.06),
                          ),
                          Text(
                            "0343 502-2323",
                            style: kTextStyle.copyWith(fontSize: getHeight(0.02) ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: getHeight(0.11),
                      width: getHeight(0.79),
                      margin: EdgeInsets.only(
                          left: getWidth(0.026),
                          right: getWidth(0.026),
                          top: getHeight(0.025),
                          bottom: 0),
                      decoration: BoxDecoration(
                        color: kBordo,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: getWidth(0.046),
                              vertical: getHeight(0.0098),
                            ),
                            child: Container(
                              width: getWidth(0.13),
                              //height: getWidth(0.13),
//
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(13),
                              ),
                              child: Image.asset("assets/images/facebook.png"),

                            ),
                          ),
                          SizedBox(
                            width: getWidth(0.01),
                          ),
                          Text(
                            "La Red - Liga de Fútbol",
                            style: kTextStyle.copyWith(fontSize: getHeight(0.02)),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: getHeight(0.11),
                      width: getHeight(0.79),
                      margin: EdgeInsets.only(
                          left: getWidth(0.026),
                          right: getWidth(0.026),
                          top: getHeight(0.025),
                          bottom: 0),
                      decoration: BoxDecoration(
                        color: kBordo,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: getWidth(0.046),
                              vertical: getHeight(0.0098),
                            ),
                            child: Container(
                              width: getWidth(0.13),
                              //height: getWidth(0.12),
//
                              decoration: BoxDecoration(
                                color: Colors.white,
                               borderRadius: BorderRadius.circular(13),
                              ),
                              child: Image.asset("assets/images/mail.png"),

                            ),
                          ),
                          SizedBox(
                            width: getWidth(0.009),
                          ),
                          Text(
                            "laredcrespo@gmail.com",
                            style: kTextStyle.copyWith(fontSize: getHeight(0.02)),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          ),
    );
  }
}

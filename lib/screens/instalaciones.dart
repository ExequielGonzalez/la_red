import 'package:flutter/material.dart';
import 'package:la_red/widgets/background.dart';
import 'package:la_red/widgets/background_template.dart';
import 'package:la_red/widgets/leagues_tab.dart';
import 'package:la_red/widgets/screen_banner.dart';
import 'package:la_red/widgets/screen_title.dart';

import '../constants.dart';

class Instalaciones extends StatefulWidget {
  @override
  _instalacionesState createState() => _instalacionesState();
}

class _instalacionesState extends State<Instalaciones> {
  get onTap => null;

  double getHeight(double percent) =>
      MediaQuery.of(context).size.height * percent;
  double getWidth(double percent) =>
      MediaQuery.of(context).size.width * percent;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundTemplate(
        height: getHeight(1),
        width: getWidth(1),
        title: 'instalaciones',
        child: Expanded(
          child: Center(
            child:Container(
              child: Column(

                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [ Container(
                  height: getHeight(0.50),  //
                  width: getWidth(0.85),   //
                  decoration: BoxDecoration(
                    color: kBordo,

                    border: Border.all(color: Colors.white,
                      width: getWidth(0.015),
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  alignment: AlignmentDirectional.bottomEnd,


                  child: Column (
                    children: [
                      Text('Ubicación de las canchas',
                        style: kTextStyleBold.copyWith(fontSize: kFontSize),
                      ),
                      Padding(padding: EdgeInsets.all(getHeight(0.01)),
                        child: Image.asset(
                          "assets/images/Canchas.png",
                          height: getWidth(0.55),
                        ),
                      ),
                      Text( 'Ruta camino a Gral. Racedo',
                          style: kTextStyleBold.copyWith(fontSize: kFontSize,)),
                      Text( ' a 1000 m de Crespo',
                          style: kTextStyleBold.copyWith(fontSize: kFontSize,)),
                      Padding(
                        padding: const EdgeInsets.all(0.1),
                        child: Container(
                          height: getHeight(0.05),
                          width: getHeight(0.79),
                          margin: EdgeInsets.only(
                            left: getWidth(0.026),
                            right: getWidth(0.026),
                            top: getHeight(0.025),
                            bottom: (0.025),
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  width: getWidth(0.10),
                                  height: getWidth(0.5),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: Image.asset("assets/images/maps.jpeg"),

                                ),
                              ),
                              SizedBox(
                                width: getWidth(0.08),
                              ),
                              Text(
                                "Ir a Google Maps",
                                style: kTextStyle.copyWith(fontSize: getHeight(0.02),color: kBordo),
                              ),
                            ],
                          ),
                        ),
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
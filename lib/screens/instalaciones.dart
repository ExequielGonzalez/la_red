import 'package:flutter/material.dart';
import 'package:la_red/widgets/background.dart';
import 'package:la_red/widgets/background_template.dart';
import 'package:la_red/widgets/leagues_tab.dart';
import 'package:la_red/widgets/screen_banner.dart';
import 'package:la_red/widgets/screen_title.dart';
import '../constants.dart';

import 'package:url_launcher/url_launcher.dart';
import 'package:simple_url_preview/simple_url_preview.dart';

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

  openURL() async {
    if (await canLaunch("https://maps.app.goo.gl/i64E62aotR1S3W4o9")) {
      await launch("https://maps.app.goo.gl/i64E62aotR1S3W4o9");
    } else {
      throw 'Could Not Launch URL';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundTemplate(
        height: getHeight(1),
        width: getWidth(1),
        title: 'instalaciones',
        child: Expanded(
          child: Center(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: getHeight(0.55), //
                    width: getWidth(0.85), //
                    decoration: BoxDecoration(
                      color: kBordo,
                      border: Border.all(
                        color: Colors.white,
                        width: getWidth(0.015),
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    alignment: AlignmentDirectional.bottomEnd,

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Ubicación de las canchas',
                          style: kTextStyleBold.copyWith(fontSize: kFontSize),
                        ),
                        Flexible(
                          child: Padding(
                            padding: EdgeInsets.all(getHeight(0.01)),
                            child: Center(
                              child: Image.asset(
                                "assets/images/Canchas.png",
                                height: getWidth(0.55),
                              ),
                            ),
                          ),
                        ),
                        Text('Ruta camino a Gral. Racedo ',
                            style: kTextStyleBold.copyWith(
                              fontSize: kFontSize,
                            )),
                        Text(' a 1000 m de Crespo ',
                            style: kTextStyleBold.copyWith(
                              fontSize: kFontSize,
                            )),
                        SizedBox(
                          height: getHeight(0.001),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: RaisedButton(
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(getWidth(0.10)),
                              // side: BorderSide(color: Colors.red)
                            ),
                            onPressed: () {
                              openURL();
                            },
                            color: Colors.white,
                            child: Text(
                              "Ver en Google Maps",
                              style: kTextStyle.copyWith(
                                  fontSize: getHeight(0.02), color: kBordo),
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

import 'package:flutter/material.dart';

import 'package:la_red/widgets/background_template.dart';

import '../constants.dart';

class Instalaciones extends StatefulWidget {
  @override
  _InstalacionesState createState() => _InstalacionesState();
}

class _InstalacionesState extends State<Instalaciones> {
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
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: kBordo,
                      border: Border.all(
                        color: Colors.white,
                        width: 7,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    height: 330.0,
                    width: 330.0,
                    alignment: AlignmentDirectional.bottomEnd,
                    child: Column(children: [
                      Text(
                        'Ubicación de las canchas',
                        style: kTextStyleBold.copyWith(fontSize: kFontSize),
                      ),
                      Padding(
                        padding: EdgeInsets.all(getHeight(0.01)),
                        child: Image.asset(
                          "assets/images/Canchas.png",
                          height: getWidth(0.55),
                        ),
                      ),
                      Expanded(
                        child: Text('Ruta camino a Gral. Racedo',
                            style: kTextStyleBold.copyWith(
                              fontSize: kFontSize,
                            )),
                      ),
                      Expanded(
                        child: Text(' a 1000 m de Crespo',
                            style: kTextStyleBold.copyWith(
                              fontSize: kFontSize,
                            )),
                      ),
                    ]),
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

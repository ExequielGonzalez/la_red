import 'package:flutter/material.dart';
import 'package:la_red/widgets/background.dart';

import '../constants.dart';

class Equipos extends StatefulWidget {
  @override
  _EquiposState createState() => _EquiposState();
}

class _EquiposState extends State<Equipos> {
  double getHeight(double percent) =>
      MediaQuery.of(context).size.height * percent;
  double getWidth(double percent) =>
      MediaQuery.of(context).size.width * percent;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Background(),
          Align(
            alignment: Alignment.center,
            child: Column(
              children: [
                SizedBox(
                  height: getHeight(0.056),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/images/logo_principal.png",
                      width: getWidth(0.322),
                      height: getWidth(0.322),
                    ),
                    Padding(
                      padding: EdgeInsets.all(getWidth(0.05)),
                      child: Column(
                        children: [
                          Text(
                            'LA RED',
                            style: kTextStyleBold.copyWith(
                                fontSize: 51, height: 1),
                          ),
                          Text(
                            'Liga de fútbol',
                            style: kTextStyle.copyWith(fontSize: 23, height: 1),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          SizedBox(
                            height: 5,
                            width: getWidth(0.305),
                            child: Container(
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: getHeight(0.02),
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: kBordo,
                    ),
                    child: Container(
                      height: getHeight(0.081),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            flex: 1,
                            child: Icon(
                              Icons.menu,
                              color: Colors.white,
                              size: getHeight(0.042),
                            ),
                          ),
                          Flexible(
                            flex: 5,
                            child: Text(
                              'EQUIPOS',
                              style: kTextStyleBold.copyWith(
                                  fontSize: 51, height: 1),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

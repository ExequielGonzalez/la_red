import 'package:flutter/material.dart';
import 'package:la_red/widgets/background.dart';
import 'package:la_red/widgets/leagues_tab.dart';
import 'package:la_red/widgets/screen_banner.dart';
import 'package:la_red/widgets/screen_title.dart';

import '../constants.dart';

class Instalaciones extends StatefulWidget {
  @override
  _instalacionesState createState() => _instalacionesState();
}

class _instalacionesState extends State<Instalaciones> {
  double getHeight(double percent) =>
      MediaQuery.of(context).size.height * percent;
  double getWidth(double percent) =>
      MediaQuery.of(context).size.width * percent;

  @override
  Widget build(BuildContext context) {
    Leagues _leagues = Leagues.libre;

    return Scaffold(
      body: Stack(
        children: [
          Background(),
          Align(
            alignment: Alignment.center,
            child: Column(
              children: [
                ScreenBanner(
                  height: getHeight(1),
                  width: getWidth(1),
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: kBordo,
                      border: Border.all(color: Colors.blueGrey),
                    ),
                    child: Column(
                      children: [
                        ScreenTitle(
                          width: getWidth(1),
                          height: getHeight(1),
                          title: 'instalaciones',
                        ),
                        SizedBox(
                          height: 1,
                          child: Container(
                            color: Colors.blueGrey,
                          ),
                        ),
//
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
    ;
  }
}

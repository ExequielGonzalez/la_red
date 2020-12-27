import 'package:flutter/material.dart';
import 'package:la_red/widgets/background.dart';
import 'package:la_red/widgets/background_template.dart';
import 'package:la_red/widgets/goleadores_list_item.dart';
import 'package:la_red/widgets/leagues_tab.dart';
import 'package:la_red/widgets/screen_banner.dart';
import 'package:la_red/widgets/screen_title.dart';

import '../constants.dart';

class Goleadores extends StatefulWidget {
  @override
  _GoleadoresState createState() => _GoleadoresState();
}

class _GoleadoresState extends State<Goleadores> {
  double getHeight(double percent) =>
      MediaQuery.of(context).size.height * percent;
  double getWidth(double percent) =>
      MediaQuery.of(context).size.width * percent;
  Leagues _leagues = Leagues.libre;

  double scale = 0.045;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundTemplate(
        height: getHeight(1),
        width: getWidth(1),
        title: 'goleadores',
        child: Expanded(
          child: Column(
            children: [
              Container(
                height: getHeight(0.067),
                child: Row(
                  children: [
                    LeaguesTab(
                        text: 'libre',
                        width: getWidth(1),
                        selected: _leagues == Leagues.libre,
                        onTap: () {
                          setState(() {
                            _leagues = Leagues.libre;
                          });
                        }),
                    LeaguesTab(
                      text: 'm30',
                      width: getWidth(1),
                      selected: _leagues == Leagues.m30,
                      onTap: () {
                        setState(() {
                          _leagues = Leagues.m30;
                        });
                      },
                    ),
                    LeaguesTab(
                      text: 'm40',
                      width: getWidth(1),
                      selected: _leagues == Leagues.m40,
                      onTap: () {
                        setState(() {
                          _leagues = Leagues.m40;
                        });
                      },
                    ),
                    LeaguesTab(
                      text: 'femenino',
                      width: getWidth(1),
                      selected: _leagues == Leagues.femenino,
                      onTap: () {
                        setState(() {
                          _leagues = Leagues.femenino;
                        });
                      },
                    ),
                  ],
                ),
              ),
              Flexible(
                fit: FlexFit.loose,
                child: Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(top: getHeight(0.005)),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      topLeft: Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: getWidth(0.015)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            //nombre y goles
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: getWidth(0.11)),
                              child: Container(
                                child: Center(
                                  child: Text(
                                    'NOMBRE',
                                    style: kTextStyleBold.copyWith(
                                        color: kBordo,
                                        fontSize: getWidth(scale)),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: getWidth(0.05)),
                              child: Container(
                                child: Center(
                                  child: Text(
                                    'GOLES',
                                    style: kTextStyleBold.copyWith(
                                        color: kBordo,
                                        fontSize: getWidth(scale)),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: ListView(
                          padding: EdgeInsets.only(bottom: getHeight(0.01)),
                          children: [
                            //goleadores
                            GoleadoresListItem(
                              posicion: 1,
                              name: 'Cristiano Ronaldo',
                              width: getWidth(1),
                              height: getHeight(1),
                              goles: 27,
                            ),
                            GoleadoresListItem(
                              posicion: 2,
                              name: 'Lionel Messi',
                              width: getWidth(1),
                              height: getHeight(1),
                              goles: 24,
                            ),
                            GoleadoresListItem(
                              posicion: 30,
                              name: 'Robert Lewandowski',
                              width: getWidth(1),
                              height: getHeight(1),
                              goles: 23,
                            ),
                            GoleadoresListItem(
                              posicion: 30,
                              name: 'Robert Lewandowski',
                              width: getWidth(1),
                              height: getHeight(1),
                              goles: 23,
                            ),
                            GoleadoresListItem(
                              posicion: 30,
                              name: 'Robert Lewandowski',
                              width: getWidth(1),
                              height: getHeight(1),
                              goles: 23,
                            ),
                            GoleadoresListItem(
                              posicion: 30,
                              name: 'Robert Lewandowski',
                              width: getWidth(1),
                              height: getHeight(1),
                              goles: 23,
                            ),
                            GoleadoresListItem(
                              posicion: 30,
                              name: 'Robert Lewandowski',
                              width: getWidth(1),
                              height: getHeight(1),
                              goles: 23,
                            ),
                            GoleadoresListItem(
                              posicion: 30,
                              name: 'Robert Lewandowski',
                              width: getWidth(1),
                              height: getHeight(1),
                              goles: 23,
                            ),
                            GoleadoresListItem(
                              posicion: 30,
                              name: 'Robert Lewandowski',
                              width: getWidth(1),
                              height: getHeight(1),
                              goles: 23,
                            ),
                            GoleadoresListItem(
                              posicion: 30,
                              name: 'Robert Lewandowski',
                              width: getWidth(1),
                              height: getHeight(1),
                              goles: 23,
                            ),
                            GoleadoresListItem(
                              posicion: 30,
                              name: 'Robert Lewandowski',
                              width: getWidth(1),
                              height: getHeight(1),
                              goles: 23,
                            ),
                            GoleadoresListItem(
                              posicion: 30,
                              name: 'Robert Lewandowski',
                              width: getWidth(1),
                              height: getHeight(1),
                              goles: 23,
                            ),
                            GoleadoresListItem(
                              posicion: 30,
                              name: 'Robert Lewandowski',
                              width: getWidth(1),
                              height: getHeight(1),
                              goles: 23,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
    ;
  }
}

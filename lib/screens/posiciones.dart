import 'package:flutter/material.dart';
import 'package:la_red/size_config.dart';
import 'package:la_red/widgets/background_template.dart';
import 'package:la_red/widgets/leagues_tab.dart';
import 'package:la_red/widgets/position_list_item.dart';

import '../constants.dart';

class Posiciones extends StatefulWidget {
  @override
  _FixtureState createState() => _FixtureState();
}

class _FixtureState extends State<Posiciones> {
  double getHeight(double percent) =>
      MediaQuery.of(context).size.height * percent;
  double getWidth(double percent) =>
      MediaQuery.of(context).size.width * percent;
  Leagues _leagues = Leagues.libre;

  double scale = 0.045;
  double gridPadding = 1;
  double gridWidth = 0.05;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: BackgroundTemplate(
        height: getHeight(1),
        width: getWidth(1),
        title: 'posiciones',
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
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding:
                                  EdgeInsets.symmetric(horizontal: gridPadding),
                              child: Container(
                                width: getWidth(2 * gridWidth),
                                child: Center(
                                  child: Text(
                                    'PTS',
                                    style: kTextStyleBold.copyWith(
                                        color: kBordo,
                                        fontSize: getWidth(scale)),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsets.symmetric(horizontal: gridPadding),
                              child: Container(
                                width: getWidth(gridWidth),
                                child: Center(
                                  child: Text(
                                    'J',
                                    style: kTextStyleBold.copyWith(
                                        color: kBordo,
                                        fontSize: getWidth(scale)),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsets.symmetric(horizontal: gridPadding),
                              child: Container(
                                width: getWidth(gridWidth),
                                child: Center(
                                  child: Text(
                                    'G',
                                    style: kTextStyleBold.copyWith(
                                        color: kBordo,
                                        fontSize: getWidth(scale)),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsets.symmetric(horizontal: gridPadding),
                              child: Container(
                                width: getWidth(gridWidth),
                                child: Center(
                                  child: Text(
                                    'E',
                                    style: kTextStyleBold.copyWith(
                                        color: kBordo,
                                        fontSize: getWidth(scale)),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsets.symmetric(horizontal: gridPadding),
                              child: Container(
                                width: getWidth(gridWidth),
                                child: Center(
                                  child: Text(
                                    'P',
                                    style: kTextStyleBold.copyWith(
                                        color: kBordo,
                                        fontSize: getWidth(scale)),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsets.symmetric(horizontal: gridPadding),
                              child: Container(
                                width: getWidth(1.4 * gridWidth),
                                child: Center(
                                  child: Text(
                                    'GF',
                                    style: kTextStyleBold.copyWith(
                                        color: kBordo,
                                        fontSize: getWidth(scale)),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsets.symmetric(horizontal: gridPadding),
                              child: Container(
                                width: getWidth(1.4 * gridWidth),
                                child: Center(
                                  child: Text(
                                    'GE',
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
                            PositionListItem(
                              width: getWidth(1),
                              height: getHeight(1),
                              posicion: 1,
                              name: 'Real Madrid C.F',
                              puntos: 16,
                              partidosJugados: 7,
                              partidosGanados: 5,
                              partidosPerdidos: 1,
                              partidosEmpates: 1,
                              golesFavor: 28,
                              golesContra: 25,
                            ),
                            PositionListItem(
                              width: getWidth(1),
                              height: getHeight(1),
                              posicion: 10,
                              name: 'Paris Saint Germain',
                              puntos: 16,
                              partidosJugados: 7,
                              partidosGanados: 5,
                              partidosPerdidos: 1,
                              partidosEmpates: 1,
                              golesFavor: 28,
                              golesContra: 25,
                            ),
                            PositionListItem(
                              width: getWidth(1),
                              height: getHeight(1),
                              posicion: 23,
                              name: 'Real Madrid C.F',
                              puntos: 16,
                              partidosJugados: 7,
                              partidosGanados: 5,
                              partidosPerdidos: 1,
                              partidosEmpates: 1,
                              golesFavor: 28,
                              golesContra: 25,
                            ),
                            PositionListItem(
                              width: getWidth(1),
                              height: getHeight(1),
                              posicion: 1,
                              name: 'Real Madrid C.F',
                              puntos: 16,
                              partidosJugados: 7,
                              partidosGanados: 5,
                              partidosPerdidos: 1,
                              partidosEmpates: 1,
                              golesFavor: 28,
                              golesContra: 25,
                            ),
                            PositionListItem(
                              width: getWidth(1),
                              height: getHeight(1),
                              posicion: 1,
                              name: 'Real Madrid C.F',
                              puntos: 16,
                              partidosJugados: 7,
                              partidosGanados: 5,
                              partidosPerdidos: 1,
                              partidosEmpates: 1,
                              golesFavor: 28,
                              golesContra: 25,
                            ),
                            PositionListItem(
                              width: getWidth(1),
                              height: getHeight(1),
                              posicion: 1,
                              name: 'Real Madrid C.F',
                              puntos: 16,
                              partidosJugados: 7,
                              partidosGanados: 5,
                              partidosPerdidos: 1,
                              partidosEmpates: 1,
                              golesFavor: 28,
                              golesContra: 25,
                            ),
                            PositionListItem(
                              width: getWidth(1),
                              height: getHeight(1),
                              posicion: 1,
                              name: 'Real Madrid C.F',
                              puntos: 16,
                              partidosJugados: 7,
                              partidosGanados: 5,
                              partidosPerdidos: 1,
                              partidosEmpates: 1,
                              golesFavor: 28,
                              golesContra: 25,
                            ),
                            PositionListItem(
                              width: getWidth(1),
                              height: getHeight(1),
                              posicion: 1,
                              name: 'Real Madrid C.F',
                              puntos: 16,
                              partidosJugados: 7,
                              partidosGanados: 5,
                              partidosPerdidos: 1,
                              partidosEmpates: 1,
                              golesFavor: 28,
                              golesContra: 25,
                            ),
                            PositionListItem(
                              width: getWidth(1),
                              height: getHeight(1),
                              posicion: 1,
                              name: 'Real Madrid C.F',
                              puntos: 16,
                              partidosJugados: 7,
                              partidosGanados: 5,
                              partidosPerdidos: 1,
                              partidosEmpates: 1,
                              golesFavor: 28,
                              golesContra: 25,
                            ),
                            PositionListItem(
                              width: getWidth(1),
                              height: getHeight(1),
                              posicion: 1,
                              name: 'Real Madrid C.F',
                              puntos: 16,
                              partidosJugados: 7,
                              partidosGanados: 5,
                              partidosPerdidos: 1,
                              partidosEmpates: 1,
                              golesFavor: 28,
                              golesContra: 25,
                            ),
                            PositionListItem(
                              width: getWidth(1),
                              height: getHeight(1),
                              posicion: 1,
                              name: 'Real Madrid C.F',
                              puntos: 16,
                              partidosJugados: 7,
                              partidosGanados: 5,
                              partidosPerdidos: 1,
                              partidosEmpates: 1,
                              golesFavor: 28,
                              golesContra: 25,
                            ),
                            PositionListItem(
                              width: getWidth(1),
                              height: getHeight(1),
                              posicion: 1,
                              name: 'Real Madrid C.F',
                              puntos: 16,
                              partidosJugados: 7,
                              partidosGanados: 5,
                              partidosPerdidos: 1,
                              partidosEmpates: 1,
                              golesFavor: 28,
                              golesContra: 25,
                            ),
                            PositionListItem(
                              width: getWidth(1),
                              height: getHeight(1),
                              posicion: 1,
                              name: 'Real Madrid C.F',
                              puntos: 16,
                              partidosJugados: 7,
                              partidosGanados: 5,
                              partidosPerdidos: 1,
                              partidosEmpates: 1,
                              golesFavor: 28,
                              golesContra: 25,
                            ),
                            PositionListItem(
                              width: getWidth(1),
                              height: getHeight(1),
                              posicion: 1,
                              name: 'Real Madrid C.F',
                              puntos: 16,
                              partidosJugados: 7,
                              partidosGanados: 5,
                              partidosPerdidos: 1,
                              partidosEmpates: 1,
                              golesFavor: 28,
                              golesContra: 25,
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
  }
}

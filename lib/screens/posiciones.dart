import 'package:flutter/material.dart';
import 'package:la_red/provider/equipo_data.dart';
import 'package:la_red/provider/leagues_provider.dart';
import 'package:la_red/size_config.dart';
import 'package:la_red/widgets/background_template.dart';
import 'package:la_red/widgets/leagues_tab.dart';
import 'package:la_red/widgets/position_list_item.dart';
import 'package:provider/provider.dart';

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

  List<PositionListItem> _positionList = [];

  double scale = 0.045;
  double gridPadding = 1;
  double gridWidth = 0.05;

  List<Widget> createPositionList(Leagues league) {
    _positionList = [];
    final equipos = Provider.of<EquipoData>(context, listen: false).getEquipos;

    PositionListItem _listItem;

    print(equipos.length);
    equipos.forEach((element) {
      if (element.liga == league.toString()) {
        print(
            'creando un nuevo listItem con ${element.nombre} y ${element.id}');
        _listItem = PositionListItem(
          equipo: element,
        );

        _positionList.add(_listItem);
      }
    });
    return _positionList;
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    LeaguesProvider league = Provider.of<LeaguesProvider>(context);
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
                        selected: league.currentLeague == Leagues.libre,
                        onTap: () {
                          league.setLeague(Leagues.libre);
                        }),
                    LeaguesTab(
                      text: 'm30',
                      width: getWidth(1),
                      selected: league.currentLeague == Leagues.m30,
                      onTap: () {
                        league.setLeague(Leagues.m30);
                      },
                    ),
                    LeaguesTab(
                      text: 'm40',
                      width: getWidth(1),
                      selected: league.currentLeague == Leagues.m40,
                      onTap: () {
                        league.setLeague(Leagues.m40);
                      },
                    ),
                    LeaguesTab(
                      text: 'femenino',
                      width: getWidth(1),
                      selected: league.currentLeague == Leagues.femenino,
                      onTap: () {
                        league.setLeague(Leagues.femenino);
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
                                width: getWidth(1.2 * gridWidth),
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
                                width: getWidth(1.2 * gridWidth),
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
                                width: getWidth(1.2 * gridWidth),
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
                                width: getWidth(1.2 * gridWidth),
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
                                width: getWidth(1.2 * gridWidth),
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
                                width: getWidth(1.2 * gridWidth),
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
                          children: createPositionList(league.currentLeague) ??
                              [Center(child: CircularProgressIndicator())],
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

import 'package:flutter/material.dart';
import 'package:la_red/widgets/background.dart';
import 'package:la_red/widgets/background_template.dart';
import 'package:la_red/widgets/equiposListItem.dart';
import 'package:la_red/widgets/fixtureListItem.dart';
import 'package:la_red/widgets/leagues_tab.dart';
import 'package:la_red/widgets/screen_banner.dart';
import 'package:la_red/widgets/screen_title.dart';

import '../constants.dart';

class Fixture extends StatefulWidget {
  @override
  _FixtureState createState() => _FixtureState();
}

class _FixtureState extends State<Fixture> {
  double getHeight(double percent) =>
      MediaQuery.of(context).size.height * percent;
  double getWidth(double percent) =>
      MediaQuery.of(context).size.width * percent;
  Leagues _leagues = Leagues.libre;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundTemplate(
        height: getHeight(1),
        width: getWidth(1),
        title: 'fixture',
        child: Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
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
                        padding:  EdgeInsets.symmetric(
                             horizontal: getWidth(0.05)),
                        child: Text(
                          'PARTIDOS',
                          style: kTextStyleBold.copyWith(
                              color: kBordo, fontSize: 30),
                        ),
                      ),
                      Expanded(
                        child: ListView(
                          padding: EdgeInsets.only(bottom: getHeight(0.01)),
                          children: [
                            FixtureListItem(
                              height: getHeight(1),
                              width: getWidth(1),
                              equipo1: 'Barcelona',
                              equipo2: 'Real Madrid',
                              fecha: 'SABADO 28/11',
                              hora: '17:30',
                              numCancha: 1,
                            ),
                            FixtureListItem(
                              height: getHeight(1),
                              width: getWidth(1),
                              equipo1: 'Chelsea',
                              equipo2: 'Arsenal',
                              fecha: 'SABADO 28/11',
                              hora: '17:30',
                              numCancha: 2,
                            ),
                            FixtureListItem(
                              height: getHeight(1),
                              width: getWidth(1),
                              equipo1: 'Manchester United',
                              equipo2: 'Liverpool',
                              fecha: 'SABADO 28/11',
                              hora: '17:30',
                              numCancha: 3,
                            ),
                            FixtureListItem(
                              height: getHeight(1),
                              width: getWidth(1),
                              equipo1: 'Paris Saint Germain',
                              equipo2: 'Real Madrid',
                              fecha: 'SABADO 28/11',
                              hora: '17:30',
                              numCancha: 4,
                            ),
                            FixtureListItem(
                              height: getHeight(1),
                              width: getWidth(1),
                              equipo1: 'Barcelona',
                              equipo2: 'Real Madrid',
                              fecha: 'SABADO 28/11',
                              hora: '17:30',
                              numCancha: 1,
                            ),
                            FixtureListItem(
                              height: getHeight(1),
                              width: getWidth(1),
                              equipo1: 'Barcelona',
                              equipo2: 'Real Madrid',
                              fecha: 'SABADO 28/11',
                              hora: '17:30',
                              numCancha: 1,
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

import 'package:flutter/material.dart';
import 'package:la_red/widgets/background.dart';
import 'package:la_red/widgets/leagues_tab.dart';
import 'package:la_red/widgets/screen_banner.dart';
import 'package:la_red/widgets/screen_title.dart';

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
                          title: 'posiciones',
                        ),
                        SizedBox(
                          height: 1,
                          child: Container(
                            color: Colors.blueGrey,
                          ),
                        ),
                        Container(
                          height: getHeight(0.067),
                          child: Row(
                            children: [
                              LeaguesTab(
                                  text: 'libre',
                                  selected: _leagues == Leagues.libre,
                                  onTap: () {
                                    setState(() {
                                      _leagues = Leagues.libre;
                                    });
                                  }),
                              LeaguesTab(
                                text: 'm30',
                                selected: _leagues == Leagues.m30,
                                onTap: () {
                                  setState(() {
                                    _leagues = Leagues.m30;
                                  });
                                },
                              ),
                              LeaguesTab(
                                text: 'm40',
                                selected: _leagues == Leagues.m40,
                                onTap: () {
                                  setState(() {
                                    _leagues = Leagues.m40;
                                  });
                                },
                              ),
                              LeaguesTab(
                                text: 'femenino',
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

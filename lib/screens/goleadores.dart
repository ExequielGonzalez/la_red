import 'package:flutter/material.dart';
import 'package:la_red/widgets/background.dart';
import 'package:la_red/widgets/background_template.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundTemplate(
        height: getHeight(1),
        width: getWidth(1),
        title: 'goleadores',
        child: Container(
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
      ),
    );
    ;
  }
}
